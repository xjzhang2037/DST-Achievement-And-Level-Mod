-- Collection Tracker
-- Handles collection-based achievements (gems, items, foods, etc.)

local BaseTracker = require "scripts/components/achievements/base_tracker"
local AchievementRegistry = require "scripts/components/achievements/achievement_registry"

local CollectionTracker = Class(BaseTracker, function(self, inst, achievement_component)
    BaseTracker._ctor(self, inst, achievement_component)
end)

-- Helper to find item in list
local function findInList(list, item)
    for index, value in pairs(list) do
        if value == item then
            return true
        end
    end
    return false
end

-- Helper to remove item from list
local function removeFromList(list, item)
    for index, value in pairs(list) do
        if value == item then
            table.remove(list, index)
            return true
        end
    end
    return false
end

-- Track collection of an item
function CollectionTracker:CollectItem(counter_field, list_field, item_name)
    if not item_name then return end

    local achiv = self.achievement_component
    local current_count = achiv[counter_field] or 0

    -- Increment counter
    achiv[counter_field] = current_count + 1

    -- If there's a list field, remove from list
    if list_field and achiv[list_field] then
        removeFromList(achiv[list_field], item_name)
    end

    -- Check all collection achievements using this counter
    for achievement_name, def in pairs(AchievementRegistry.DEFINITIONS) do
        if def.type == AchievementRegistry.TYPES.COLLECTION and
           def.counter_field == counter_field and
           def.threshold then

            if achiv[counter_field] >= def.threshold and not self:IsCompleted(achievement_name) then
                self:AwardAchievement(achievement_name)
            end
        end
    end
end

return CollectionTracker
