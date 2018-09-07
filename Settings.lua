local ADDON_NAME, ADDON = ...

ToyBoxEnhancedSettings = ToyBoxEnhancedSettings or {}
local defaultFilterStates

function ADDON:ResetFilterSettings()
    ADDON.settings.filter = CopyTable(defaultFilterStates)
end

local function PrepareDefaults()
    local defaultSettings = {
        debugMode = false,
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
            hidden = false,
        },
    }

    for name, _ in pairs(ADDON.ToyBoxEnhancedSource) do
        defaultSettings.filter.source[name] = true
    end
    for name, _ in pairs(ADDON.ToyBoxEnhancedProfession) do
        defaultSettings.filter.profession[name] = true
    end
    for name, _ in pairs(ADDON.ToyBoxEnhancedWorldEvent) do
        defaultSettings.filter.worldEvent[name] = true
    end
    for name, _ in pairs(ADDON.ToyBoxEnhancedExpansion) do
        defaultSettings.filter.expansion[name] = true
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
hooksecurefunc(ADDON, "OnLogin", function()
    local defaultSettings = PrepareDefaults()
    defaultFilterStates = CopyTable(defaultSettings.filter)
    CombineSettings(ToyBoxEnhancedSettings, defaultSettings)
    ADDON.settings = ToyBoxEnhancedSettings
end)