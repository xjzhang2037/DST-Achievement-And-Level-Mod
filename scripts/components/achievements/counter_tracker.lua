-- Counter Tracker
-- Handles simple counter-based achievements (eat, build, mine, chop, cook, pick, fish)
-- Uses registry to eliminate repetitive counter incrementing code

local BaseTracker = require "scripts/components/achievements/base_tracker"
local AchievementRegistry = require "scripts/components/achievements/achievement_registry"

local CounterTracker = Class(BaseTracker, function(self, inst, achievement_component)
    BaseTracker._ctor(self, inst, achievement_component)
end)

-- Check all counter achievements that share a counter field
function CounterTracker:CheckCounterAchievements(counter_field)
    for achievement_name, def in pairs(AchievementRegistry.DEFINITIONS) do
        if def.type == AchievementRegistry.TYPES.SIMPLE_COUNTER and
           def.counter_field == counter_field and
           def.threshold then

            local current_value = self:GetCounter(counter_field)
            if current_value >= def.threshold and not self:IsCompleted(achievement_name) then
                self:AwardAchievement(achievement_name)
            end
        end
    end
end

-- Increment a counter and check all related achievements
function CounterTracker:IncrementAndCheck(counter_field, amount)
    amount = amount or 1
    local current = self:GetCounter(counter_field)
    self:SetCounter(counter_field, current + amount)
    self:CheckCounterAchievements(counter_field)
end

return CounterTracker
