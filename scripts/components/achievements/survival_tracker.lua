-- Survival Tracker
-- Handles time-based survival achievements (freezing, burning, starving, walking, etc.)

local BaseTracker = require "scripts/components/achievements/base_tracker"
local AchievementRegistry = require "scripts/components/achievements/achievement_registry"

local SurvivalTracker = Class(BaseTracker, function(self, inst, achievement_component)
    BaseTracker._ctor(self, inst, achievement_component)
end)

-- Track time in a state and check all related achievements
function SurvivalTracker:TrackTime(counter_field, delta_time)
    local current = self:GetCounter(counter_field)
    self:SetCounter(counter_field, current + delta_time)

    -- Check all time-based achievements using this counter
    for achievement_name, def in pairs(AchievementRegistry.DEFINITIONS) do
        if def.type == AchievementRegistry.TYPES.TIME_BASED and
           def.counter_field == counter_field and
           def.threshold then

            local current_value = self:GetCounter(counter_field)
            if current_value >= def.threshold and not self:IsCompleted(achievement_name) then
                self:AwardAchievement(achievement_name)
                -- Cap at threshold if needed
                self:SetCounter(counter_field, def.threshold)
            end
        end
    end
end

return SurvivalTracker
