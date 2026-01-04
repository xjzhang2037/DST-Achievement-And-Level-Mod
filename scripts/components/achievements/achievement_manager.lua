-- Achievement Manager
-- Central coordinator for all achievement trackers
-- Provides a clean interface to the achievement system

local KillTracker = require "scripts/components/achievements/kill_tracker"
local CounterTracker = require "scripts/components/achievements/counter_tracker"
local SurvivalTracker = require "scripts/components/achievements/survival_tracker"
local SocialTracker = require "scripts/components/achievements/social_tracker"
local CollectionTracker = require "scripts/components/achievements/collection_tracker"
local AchievementSerializer = require "scripts/components/achievements/achievement_serializer"
local AchievementRegistry = require "scripts/components/achievements/achievement_registry"

local AchievementManager = {}

-- Initialize the achievement manager with specialized trackers
function AchievementManager:Create(achievement_component)
    local manager = {
        achievement_component = achievement_component,
        inst = achievement_component.inst,
    }

    -- Create specialized trackers
    manager.kill_tracker = KillTracker(manager.inst, achievement_component)
    manager.counter_tracker = CounterTracker(manager.inst, achievement_component)
    manager.survival_tracker = SurvivalTracker(manager.inst, achievement_component)
    manager.social_tracker = SocialTracker(manager.inst, achievement_component)
    manager.collection_tracker = CollectionTracker(manager.inst, achievement_component)

    setmetatable(manager, {__index = self})
    return manager
end

-- Initialize all trackers (set up event listeners)
function AchievementManager:InitTrackers()
    -- Initialize kill tracker
    if self.kill_tracker then
        self.kill_tracker:Init()
    end

    -- Other trackers don't need explicit initialization as they're called directly
end

-- Delegate methods to appropriate trackers

-- Kill tracking
function AchievementManager:OnKilled(victim, data)
    if self.kill_tracker then
        self.kill_tracker:OnKilled(victim, data)
    end
end

-- Counter tracking (work achievements: eat, build, mine, chop, etc.)
function AchievementManager:IncrementCounter(counter_field, amount)
    if self.counter_tracker then
        self.counter_tracker:IncrementAndCheck(counter_field, amount or 1)
    end
end

-- Survival tracking (time-based achievements)
function AchievementManager:TrackSurvivalTime(counter_field, delta_time)
    if self.survival_tracker then
        self.survival_tracker:TrackTime(counter_field, delta_time)
    end
end

-- Social tracking (friendship achievements)
function AchievementManager:MakeFriend(creature_type)
    if self.social_tracker then
        self.social_tracker:MakeFriend(creature_type)
    end
end

-- Collection tracking
function AchievementManager:CollectItem(counter_field, list_field, item_name)
    if self.collection_tracker then
        self.collection_tracker:CollectItem(counter_field, list_field, item_name)
    end
end

-- Trigger a simple achievement (one-time events)
function AchievementManager:TriggerAchievement(achievement_name)
    local achiv = self.achievement_component
    if not achiv[achievement_name] then
        achiv[achievement_name] = true
        achiv:seffc(self.inst, achievement_name)
        return true
    end
    return false
end

-- Save/Load delegation
function AchievementManager:Save()
    return AchievementSerializer:Save(self.achievement_component)
end

function AchievementManager:Load(data)
    AchievementSerializer:Load(self.achievement_component, data)
end

function AchievementManager:SaveToGlobal()
    AchievementSerializer:SaveToGlobal(self.inst, self.achievement_component)
end

-- Grant all achievements (for debugging)
function AchievementManager:GrantAll()
    for achievement_name, _ in pairs(AchievementRegistry.DEFINITIONS) do
        self.achievement_component[achievement_name] = true
    end
end

-- Get achievement progress
function AchievementManager:GetProgress(achievement_name)
    local def = AchievementRegistry:GetDefinition(achievement_name)
    if not def then return nil end

    local achiv = self.achievement_component
    local result = {
        name = achievement_name,
        completed = achiv[achievement_name] == true,
        category = def.category,
        type = def.type,
    }

    if def.counter_field then
        result.current = achiv[def.counter_field] or 0
        result.threshold = def.threshold
    end

    return result
end

-- Get all achievements in a category
function AchievementManager:GetCategoryProgress(category)
    local results = {}
    local category_achievements = AchievementRegistry:GetByCategory(category)

    for achievement_name, _ in pairs(category_achievements) do
        results[achievement_name] = self:GetProgress(achievement_name)
    end

    return results
end

return AchievementManager
