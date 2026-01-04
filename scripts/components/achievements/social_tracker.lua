-- Social Tracker
-- Handles friendship/befriending achievements

local BaseTracker = require "scripts/components/achievements/base_tracker"
local AchievementRegistry = require "scripts/components/achievements/achievement_registry"

local SocialTracker = Class(BaseTracker, function(self, inst, achievement_component)
    BaseTracker._ctor(self, inst, achievement_component)
end)

-- Map of creature tags/prefabs to their friendship counter field
local FRIEND_MAP = {
    pigman = "friendpig",
    bunnyman = "friendbunny",
    catcoon = "friendcat",
    spider = "friendspider",
    rocky = "friendrocky",
}

-- Increment friendship counter for a creature type
function SocialTracker:MakeFriend(creature_type)
    local counter_field = FRIEND_MAP[creature_type]
    if not counter_field then return end

    local current = self:GetCounter(counter_field)
    self:SetCounter(counter_field, current + 1)

    -- Check all achievements using this friendship counter
    for achievement_name, def in pairs(AchievementRegistry.DEFINITIONS) do
        if def.counter_field == counter_field and def.threshold then
            local current_value = self:GetCounter(counter_field)
            if current_value >= def.threshold and not self:IsCompleted(achievement_name) then
                self:AwardAchievement(achievement_name)
            end
        end
    end
end

return SocialTracker
