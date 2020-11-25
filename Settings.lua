local ADDON_NAME, ADDON = ...

ToyBoxEnhancedSettings = ToyBoxEnhancedSettings or {}
local defaultFilterStates

function ADDON:ResetFilterSettings()
    ADDON.settings.filter = CopyTable(defaultFilterStates)
end

function ADDON:ResetUISettings()
    ADDON.settings.enableCursorKeys = true
    ADDON.settings.replaceProgressBar = true
    ADDON.settings.favoritePerChar = false
end

local function PrepareDefaults()
    local defaultSettings = {
        debugMode = false,
        enableCursorKeys = true,
        replaceProgressBar = true,
        favoritePerChar = false,
        favoredToys = {},
        hiddenToys = {},
        filter = {
            collected = true,
            notCollected = true,
            onlyFavorites = false,
            onlyUsable = false,
            source = {},
            faction = {
                alliance = true,
                horde = true,
                noFaction = true,
            },
            profession = {},
            worldEvent = {},
            expansion = {},
            effect = {},
            hidden = false,
        },
    }

    for name, _ in pairs(ADDON.db.source) do
        defaultSettings.filter.source[name] = true
    end
    for name, _ in pairs(ADDON.db.profession) do
        defaultSettings.filter.profession[name] = true
    end
    for name, _ in pairs(ADDON.db.worldEvent) do
        defaultSettings.filter.worldEvent[name] = true
    end
    for name, _ in pairs(ADDON.db.expansion) do
        defaultSettings.filter.expansion[name] = true
    end
    for name, categoriesOrToys in pairs(ADDON.db.effect) do
        defaultSettings.filter.effect[name] = {}
        for x, _ in pairs(categoriesOrToys) do
            if type(x) == "string" then
                -- `categoriesOrToys` is more categories of nested toys
                for categoryName, _ in pairs(categoriesOrToys) do
                    defaultSettings.filter.effect[name][categoryName] = true
                end
            else -- type(x) is a number, indicating we're iterating over toys
                defaultSettings.filter.effect[name] = true
                -- we don't actually want to iterate over toys
                -- we just needed to check if it was a toy or another category
                break
            end
        end
    end

    return defaultSettings
end

local function CombineSettings(settings, defaultSettings)
    for key, value in pairs(defaultSettings) do
        if (settings[key] == nil) then
            settings[key] = value;
        elseif (type(value) == "table") and next(value) ~= nil then
            if type(settings[key]) ~= "table" then
                settings[key] = {}
            end
            CombineSettings(settings[key], value);
        end
    end

    -- cleanup old still existing settings
    for key, _ in pairs(settings) do
        if (defaultSettings[key] == nil) then
            settings[key] = nil;
        end
    end
end

-- Settings have to be loaded during PLAYER_LOGIN
ADDON:RegisterLoginCallback(function()
    local defaultSettings = PrepareDefaults()
    defaultFilterStates = CopyTable(defaultSettings.filter)
    CombineSettings(ToyBoxEnhancedSettings, defaultSettings)
    ADDON.settings = ToyBoxEnhancedSettings
end)
