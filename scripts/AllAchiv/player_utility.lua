-- Player Utility Functions
-- Generic helper functions for player-related operations
-- Based on patterns from winter_tree.lua

local PlayerUtility = {}

-- Get all players near inst within radius
function PlayerUtility.GetPlayersNearby(inst, radius)
    radius = radius or 80
    local players = {}
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, radius)

    for k, v in pairs(ents) do
        if v:HasTag("player") then
            table.insert(players, v)
        end
    end

    return players
end

-- Check if any player nearby meets a condition default radius of 80
function PlayerUtility.AnyPlayerNearbyMeetsCondition(inst, condition_fn, radius)
    radius = radius or 80
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local entities = TheSim:FindEntities(pos.x, pos.y, pos.z, radius)

    for k, v in pairs(entities) do
        if v:HasTag("player") then
            if condition_fn(v) then
                return true
            end
        end
    end

    return false
end

-- Check if all players nearby meet a condition
function PlayerUtility.AllPlayersNearbyMeetCondition(inst, condition_fn, radius)
    radius = radius or 80
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, radius)

    local hasPlayers = false
    for k, v in pairs(ents) do
        if v:HasTag("player") then
            hasPlayers = true
            if not condition_fn(v) then
                return false
            end
        end
    end

    return hasPlayers
end

-- Check if any player nearby has a specific allachivcoin property set to true
-- Component "allachivcoin" is hardcoded, always checks for true value
function PlayerUtility.AnyPlayerHasComponentProperty(inst, property_name, radius)
    radius = radius or 80
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, radius)

    for k, v in pairs(ents) do
        if v:HasTag("player") then
            if v.components.allachivcoin ~= nil then
                if v.components.allachivcoin[property_name] == true then
                    return true
                end
            end
        end
    end

    return false
end

-- Count players nearby that have a specific allachivcoin property set to true
function PlayerUtility.CountPlayersWithComponentProperty(inst, property_name, radius)
    radius = radius or 80
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, radius)

    local count = 0
    for k, v in pairs(ents) do
        if v:HasTag("player") then
            if v.components.allachivcoin ~= nil then
                if v.components.allachivcoin[property_name] == true then
                    count = count + 1
                end
            end
        end
    end

    return count
end

-- Execute a function on all players nearby
function PlayerUtility.ForEachPlayerNearby(inst, action_fn, radius)
    radius = radius or 80
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, radius)

    for k, v in pairs(ents) do
        if v:HasTag("player") then
            action_fn(v)
        end
    end
end

-- Example usage based on winter_tree.lua queuegifting function (lines 505-526):
-- Before:
--   local pos = Vector3(inst.Transform:GetWorldPosition())
--   local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 80)
--   for k,v in pairs(ents) do
--       if v:HasTag("player") then
--           if v.components.allachivcoin.shrine == true then
--               festiveperk = true
--           end
--       end
--   end
--
-- After:
--   local festiveperk = PlayerUtility.AnyPlayerHasComponentProperty(inst, "shrine")

return PlayerUtility
