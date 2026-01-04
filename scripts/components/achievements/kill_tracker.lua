-- Kill Tracker
-- Handles all kill-based achievements using a data-driven approach
-- Eliminates massive code duplication

local BaseTracker = require "scripts/components/achievements/base_tracker"
local AchievementRegistry = require "scripts/components/achievements/achievement_registry"
local PlayerUtility = require "scripts/system/player_utility"

local KillTracker = Class(BaseTracker, function(self, inst, achievement_component)
    BaseTracker._ctor(self, inst, achievement_component)
    self:BuildKillHandlers()
end)

-- Build kill handlers from registry
function KillTracker:BuildKillHandlers()
    self.area_kill_handlers = {}
    self.solo_kill_handlers = {}
    self.trigger_kill_handlers = {}

    for achievement_name, def in pairs(AchievementRegistry.DEFINITIONS) do
        if def.type == AchievementRegistry.TYPES.AREA_KILL then
            self:RegisterAreaKillHandler(achievement_name, def)
        elseif def.type == AchievementRegistry.TYPES.SOLO_KILL then
            self:RegisterSoloKillHandler(achievement_name, def)
        end
    end

    -- Special kill handlers (these need custom logic)
    self:RegisterSpecialKillHandlers()
end

-- Register area kill achievement (awards all players within radius)
function KillTracker:RegisterAreaKillHandler(achievement_name, def)
    local prefabs = def.prefabs or {def.prefab}

    for _, prefab in ipairs(prefabs) do
        if not self.area_kill_handlers[prefab] then
            self.area_kill_handlers[prefab] = {}
        end
        table.insert(self.area_kill_handlers[prefab], {
            name = achievement_name,
            counter_field = def.counter_field,
            threshold = def.threshold,
            radius = def.radius or 30,
            condition = def.condition
        })
    end
end

-- Register solo kill achievement (must be alone, no helpers)
function KillTracker:RegisterSoloKillHandler(achievement_name, def)
    local prefabs = def.prefabs or {def.prefab}

    for _, prefab in ipairs(prefabs) do
        if not self.solo_kill_handlers[prefab] then
            self.solo_kill_handlers[prefab] = {}
        end
        table.insert(self.solo_kill_handlers[prefab], {
            name = achievement_name,
            counter_field = def.counter_field,
            threshold = def.threshold,
            radius = def.radius or 15,
            condition = def.condition
        })
    end
end

-- Register special kill handlers that need custom logic
function KillTracker:RegisterSpecialKillHandlers()
    self.special_handlers = {
        glommer = function(victim, killer, pos)
            -- Sick achievement: all nearby players get it
            PlayerUtility.ForEachPlayerNearby(victim, function(player)
                if player.components.allachivevent and not player.components.allachivevent.sick then
                    player.components.allachivevent.sick = true
                    player.components.allachivevent:CompleteAchievement(player, "sick")
                end
            end, 30)
        end,

        chester = function(victim, killer, pos)
            -- Coldblood achievement: killer gets it
            if killer and killer.components.allachivevent and not killer.components.allachivevent.coldblood then
                killer.components.allachivevent.coldblood = true
                killer.components.allachivevent:CompleteAchievement(killer, "coldblood")
            end
        end,

        hutch = function(victim, killer, pos)
            -- Hutch achievement: killer must be at low health
            if killer and killer.components.allachivevent and not killer.components.allachivevent.hutch then
                if victim.components.amorphous and victim.components.amorphous:GetCurrentForm() == "FUGU" then
                    if killer.components.health and killer.components.health.currenthealth <= 10 then
                        killer.components.allachivevent.hutch = true
                        killer.components.allachivevent:CompleteAchievement(killer, "hutch")
                    end
                end
            end
        end,

        tentacle = function(victim, killer, pos)
            -- Snake achievement: personal counter
            if killer and killer.components.allachivevent and not killer.components.allachivevent.snake then
                killer.components.allachivevent.snakeamount = killer.components.allachivevent.snakeamount + 1
                if killer.components.allachivevent.snakeamount >= allachiv_eventdata["snake"] then
                    killer.components.allachivevent.snake = true
                    killer.components.allachivevent:CompleteAchievement(killer, "snake")
                end
            end
        end,

        krampus = function(victim, killer, pos)
            -- Luck achievement: check for krampus sack drop
            killer.inst:DoTaskInTime(.1, function()
                local pos = Vector3(victim.Transform:GetWorldPosition())
                local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 3)
                for k, v in pairs(ents) do
                    if v.prefab == "krampus_sack" and
                       v.components.inventoryitem and v.components.inventoryitem.owner == nil and
                       v.components.ksmark and v.components.ksmark.mark == false then
                        v.components.ksmark.mark = true
                        if killer.components.allachivevent and not killer.components.allachivevent.luck then
                            killer.components.allachivevent.luck = true
                            killer.components.allachivevent:CompleteAchievement(killer.inst, "luck")
                        end
                    end
                end
            end)
        end,

        klaus = function(victim, killer, pos)
            -- Santa achievement: check for key drop, award all nearby players
            killer.inst:DoTaskInTime(1, function()
                local pos = Vector3(victim.Transform:GetWorldPosition())
                local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 5)
                for k, v in pairs(ents) do
                    if v.prefab == "klaussackkey" and
                       v.components.inventoryitem and v.components.inventoryitem.owner == nil and
                       v.components.ksmark and v.components.ksmark.mark == false then
                        v.components.ksmark.mark = true
                        PlayerUtility.ForEachPlayerNearby(victim, function(player)
                            if player.components.allachivevent and not player.components.allachivevent.santa then
                                player.components.allachivevent.santa = true
                                player.components.allachivevent:CompleteAchievement(player, "santa")
                            end
                        end, 30)
                    end
                end
            end)
        end,
    }
end

-- Handle area kill achievements (award all players within radius)
function KillTracker:HandleAreaKills(victim, killer, pos)
    local handlers = self.area_kill_handlers[victim.prefab]
    if not handlers then return end

    for _, handler in ipairs(handlers) do
        -- Check condition if specified
        if handler.condition and not handler.condition(victim) then
            goto continue
        end

        -- Award all nearby players
        PlayerUtility.ForEachPlayerNearby(victim, function(player)
            if player.components.allachivevent and not player.components.allachivevent[handler.name] then
                local achiv = player.components.allachivevent
                achiv[handler.counter_field] = achiv[handler.counter_field] + 1
                if achiv[handler.counter_field] >= handler.threshold then
                    achiv[handler.name] = true
                    achiv:seffc(player, handler.name)
                end
            end
        end, handler.radius)

        ::continue::
    end
end

-- Handle solo kill achievements (must be alone)
function KillTracker:HandleSoloKills(victim, killer, pos)
    if not killer then return end

    local handlers = self.solo_kill_handlers[victim.prefab]
    if not handlers then return end

    for _, handler in ipairs(handlers) do
        -- Check condition if specified
        if handler.condition and not handler.condition(victim) then
            goto continue
        end

        -- Check if player is alone (no other players/helpers nearby)
        local alone = true
        PlayerUtility.ForEachPlayerNearby(victim, function(player)
            if player ~= killer then
                alone = false
            end
        end, handler.radius)

        -- Also check for AI helpers
        if alone then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, handler.radius)
            for k, v in pairs(ents) do
                if (v.prefab == "bunnyman" or v.prefab == "hutch" or
                    v.prefab == "rocky" or v.prefab == "pigman") and v ~= killer then
                    alone = false
                    break
                end
            end
        end

        if alone and killer.components.allachivevent and not killer.components.allachivevent[handler.name] then
            local achiv = killer.components.allachivevent
            achiv[handler.counter_field] = achiv[handler.counter_field] + 1
            if achiv[handler.counter_field] >= handler.threshold then
                achiv[handler.name] = true
                achiv:CompleteAchievement(killer, handler.name)
            end
        end

        ::continue::
    end
end

-- Handle special kill achievements
function KillTracker:HandleSpecialKills(victim, killer, pos)
    local handler = self.special_handlers[victim.prefab]
    if handler then
        handler(victim, killer, pos)
    end
end

-- Main kill event handler
function KillTracker:OnKilled(victim, data)
    local pos = Vector3(victim.Transform:GetWorldPosition())

    -- Handle different types of kill achievements
    self:HandleAreaKills(victim, self.inst, pos)
    self:HandleSoloKills(victim, self.inst, pos)
    self:HandleSpecialKills(victim, self.inst, pos)
end

-- Initialize the kill tracker
function KillTracker:Init()
    self.inst:ListenForEvent("killed", function(inst, data)
        if data and data.victim then
            self:OnKilled(data.victim, data)
        end
    end)
end

return KillTracker
