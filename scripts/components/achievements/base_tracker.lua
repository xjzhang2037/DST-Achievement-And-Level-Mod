-- Base Achievement Tracker
-- Provides common functionality for all achievement trackers

local BaseTracker = Class(function(self, inst, achievement_component)
    self.inst = inst
    self.achievement_component = achievement_component
end)

-- Award an achievement to the player
function BaseTracker:AwardAchievement(achievement_name)
    if not self.achievement_component[achievement_name] then
        self.achievement_component[achievement_name] = true
        self.achievement_component:CompleteAchievement(self.inst, achievement_name)
        return true
    end
    return false
end

-- Increment a counter and check if threshold is reached
function BaseTracker:IncrementCounter(achievement_name, counter_field, threshold, amount)
    amount = amount or 1

    if not self.achievement_component[achievement_name] then
        self.achievement_component[counter_field] = self.achievement_component[counter_field] + amount

        if self.achievement_component[counter_field] >= threshold then
            self:AwardAchievement(achievement_name)
            return true
        end
    end

    return false
end

-- Check if achievement is already completed
function BaseTracker:IsCompleted(achievement_name)
    return self.achievement_component[achievement_name] == true
end

-- Get counter value
function BaseTracker:GetCounter(counter_field)
    return self.achievement_component[counter_field] or 0
end

-- Set counter value
function BaseTracker:SetCounter(counter_field, value)
    self.achievement_component[counter_field] = value
end

return BaseTracker
