-- Achievement Serializer
-- Handles saving and loading achievement data using the registry
-- Eliminates hundreds of lines of repetitive save/load code

local AchievementRegistry = require "scripts/components/achievements/achievement_registry"

local AchievementSerializer = {}

-- Get all field names that need to be saved for an achievement
local function GetAchievementFields(achievement_name, def)
    local fields = {achievement_name}  -- The boolean flag

    -- Add counter field if it exists
    if def.counter_field then
        table.insert(fields, def.counter_field)
    end

    -- Add list field if it exists
    if def.list_field then
        table.insert(fields, def.list_field)
    end

    return fields
end

-- Save achievement data to a table
function AchievementSerializer:Save(achievement_component)
    local data = {}

    -- Save all achievements based on registry
    for achievement_name, def in pairs(AchievementRegistry.DEFINITIONS) do
        local fields = GetAchievementFields(achievement_name, def)

        for _, field in ipairs(fields) do
            data[field] = achievement_component[field]
        end
    end

    -- Save additional fields not in registry
    data.runcount = achievement_component.runcount

    return data
end

-- Load achievement data from a table
function AchievementSerializer:Load(achievement_component, data)
    if not data then return end

    -- Load all achievements based on registry
    for achievement_name, def in pairs(AchievementRegistry.DEFINITIONS) do
        local fields = GetAchievementFields(achievement_name, def)

        for _, field in ipairs(fields) do
            if data[field] ~= nil then
                achievement_component[field] = data[field]
            else
                -- Set default values
                if field == achievement_name then
                    achievement_component[field] = false
                elseif type(achievement_component[field]) == "number" then
                    achievement_component[field] = 0
                elseif type(achievement_component[field]) == "table" then
                    -- Keep the default table
                elseif field:match("list$") or field:match("List$") then
                    -- It's a list field, keep default
                end
            end
        end
    end

    -- Load additional fields
    achievement_component.runcount = data.runcount or 0
end

-- Save achievement data to global persistent storage
function AchievementSerializer:SaveToGlobal(inst, achievement_component)
    local name = inst:GetDisplayName()
    if not name then return end

    inst:DoTaskInTime(1, function()
        local SaveAchieve = {}

        -- Use the registry to save all fields
        for achievement_name, def in pairs(AchievementRegistry.DEFINITIONS) do
            local fields = GetAchievementFields(achievement_name, def)

            for _, field in ipairs(fields) do
                SaveAchieve[field] = achievement_component[field] or
                                     (type(achievement_component[field]) == "boolean" and false) or
                                     (type(achievement_component[field]) == "number" and 0) or
                                     achievement_component[field]
            end
        end

        -- Special fields
        SaveAchieve["totalstar"] = inst.components.allachivcoin.coinamount +
                                   math.ceil(inst.components.allachivcoin.starsspent)

        AchievementData[name] = SaveAchieve
    end)
end

return AchievementSerializer
