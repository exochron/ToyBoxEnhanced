local _, ADDON = ...

ToyBoxEnhancedSettings = ToyBoxEnhancedSettings or {}
local defaultFilterStates, defaultSortStates

function ADDON:ResetFilterSettings()
    ADDON.settings.filter = CopyTable(defaultFilterStates)
end

function ADDON:ResetSortSettings()
    ADDON.settings.sort = CopyTable(defaultSortStates)
    ToyBoxEnhancedSettings.sort = ADDON.settings.sort
end

function ADDON:ResetUISettings()
    ADDON.settings.enableCursorKeys = true
    ADDON.settings.searchInDescription = true
    ADDON.settings.favoritePerChar = false
end

local function PrepareDefaults()
    local defaultSettings = {
        debugMode = false,
        enableCursorKeys = true,
        searchInDescription = true,
        favoritePerChar = false,
        favoredToys = {},
        hiddenToys = {},
        filter = {
            collected = true,
            notCollected = true,
            onlyFavorites = false,
            onlyUsable = false,
            onlyRecent = false,
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
            hidden = false, -- hidden by user
            secret = false, -- hidden in game
        },

        sort = {
            by = 'name', -- name|expansion
            descending = false,
            favoritesFirst = true,
            unownedAtLast = false,
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
        -- we need to go one layer deeper to check if the current
        -- layer is a Table or an Array
        for x, _ in pairs(categoriesOrToys) do
            if type(x) == "string" then
                defaultSettings.filter.effect[name][x] = true
            else -- type(x) is a number, indicating we're iterating over toys
                defaultSettings.filter.effect[name] = true
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
ADDON.Events:RegisterCallback("OnInit", function()
    local defaultSettings = PrepareDefaults()
    defaultFilterStates = CopyTable(defaultSettings.filter)
    defaultSortStates = CopyTable(defaultSettings.sort)
    CombineSettings(ToyBoxEnhancedSettings, defaultSettings)
    ADDON.settings = ToyBoxEnhancedSettings
end, "settings")
