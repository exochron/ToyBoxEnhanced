local _, ADDON = ...

ToyBoxEnhancedSettings = ToyBoxEnhancedSettings or {}
ToyBoxEnhancedGlobalSettings = ToyBoxEnhancedGlobalSettings or {}
local defaultFilterStates, defaultSortStates

function ADDON:IsUsingDefaultFilters()
    return tCompare(ADDON.settings.filter, defaultFilterStates, 3)
end

function ADDON:ResetFilterSettings()
    ADDON.settings.filter = CopyTable(defaultFilterStates)
    ToyBoxEnhancedSettings.filter = ADDON.settings.filter
end

function ADDON:ResetSortSettings()
    ADDON.settings.sort = CopyTable(defaultSortStates)
    ToyBoxEnhancedSettings.sort = ADDON.settings.sort
end

local function PreparePersonalDefaults()
    local defaultSettings = {
        ui = {
            debugMode = false,
            enableCursorKeys = true,
            searchInDescription = true,
        },
        hiddenToys = {},
        filter = {
            collected = true,
            notCollected = true,
            onlyFavorites = false,
            onlyUsable = false,
            onlyTradable = false,
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
    for i = 0, GetClientDisplayExpansionLevel() do
        defaultSettings.filter.expansion[i] = true
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

local function PrepareGlobalSettings()
    return {
        ["favorites"] = {
            ["assignments"] = {},
            ["profiles"] = {
                {
                    ["name"] = "",
                    ["autoFavor"] = false,
                    ["toys"] = {},
                }
            },
        }
    }
end

local function CombineSettings(settings, defaultSettings)
    for key, value in pairs(defaultSettings) do
        if settings[key] == nil then
            settings[key] = value;
        elseif type(value) == "table" and next(value) ~= nil then
            if type(settings[key]) ~= "table" then
                settings[key] = {}
            end
            CombineSettings(settings[key], value);
        end
    end

    if type(next(settings)) ~= "number" then
        -- cleanup old still existing settings
        for key, _ in pairs(settings) do
            if defaultSettings[key] == nil then
                settings[key] = nil;
            end
        end
    end
end

--region Migrations
-- Later: remove after 2025-10
local function MigrateToUIStructure(settings, defaults)
    if not settings["ui"] then
        local ui = {}
        for k, _ in pairs(defaults.ui) do
            if nil ~= settings[k] then
                ui[k] = settings[k]
            end
        end
        settings["ui"] = ui
    end
end
-- Later: remove after 2025-10
local function MigrateToFavoriteProfiles(settings, globalSettings)
    if false == settings.favoritePerChar and 0 == #globalSettings["favorites"]["profiles"][1] then
        for itemId in pairs(ADDON.db.ingameList) do
            if PlayerHasToy(itemId) and C_ToyBox.GetIsFavorite(itemId) then
                table.insert(globalSettings["favorites"]["profiles"][1], itemId)
            end
        end

    elseif settings.favoritePerChar and settings.favoredToys then
        local playerGuid = UnitGUID("player")
        if nil == globalSettings["favorites"]["assignments"][playerGuid] then
            local player, realm = UnitFullName("player")
            local profile = {
                ["name"] = player.."-"..realm,
                ["toys"] = settings.favoredToys,
            }
            table.insert(globalSettings["favorites"]["profiles"], profile)
            local profileId = #globalSettings["favorites"]["profiles"]
            globalSettings["favorites"]["assignments"][playerGuid] = profileId
        end
    end
end
--endregion

-- Settings have to be loaded during PLAYER_LOGIN
ADDON.Events:RegisterCallback("OnInit", function()
    local defaultPersonalSettings = PreparePersonalDefaults()
    defaultFilterStates = CopyTable(defaultPersonalSettings.filter)
    defaultSortStates = CopyTable(defaultPersonalSettings.sort)

    CombineSettings(ToyBoxEnhancedGlobalSettings, PrepareGlobalSettings())

    MigrateToUIStructure(ToyBoxEnhancedSettings, defaultPersonalSettings)
    MigrateToFavoriteProfiles(ToyBoxEnhancedSettings, ToyBoxEnhancedGlobalSettings)

    CombineSettings(ToyBoxEnhancedSettings, defaultPersonalSettings)

    ADDON.settings = {}
    for k, v in pairs(ToyBoxEnhancedSettings) do
        ADDON.settings[k] = v
    end
    for k, v in pairs(ToyBoxEnhancedGlobalSettings) do
        ADDON.settings[k] = v
    end
end, "settings")
