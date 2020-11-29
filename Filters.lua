local ADDON_NAME, ADDON = ...

local function FilterHiddenToys(itemId)
    return ADDON.settings.filter.hidden or not ADDON.settings.hiddenToys[itemId]
end

local function FilterCollectedToys(collected)
    return (ADDON.settings.filter.collected and collected) or (ADDON.settings.filter.notCollected and not collected)
end

local function FilterFavoriteToys(isFavorite)
    return not ADDON.settings.filter.onlyFavorites or isFavorite or not ADDON.settings.filter.collected
end

local function FilterUsableToys(itemId)
    return not ADDON.settings.filter.onlyUsable or C_ToyBox.IsToyUsable(itemId)
end

local function CheckAllSettings(settings)
    local allDisabled = true
    local allEnabled = true
    for _, value in pairs(settings) do
        if (value) then
            allDisabled = false
        else
            allEnabled = false
        end
    end

    if allEnabled then
        return true
    elseif allDisabled then
        return false
    end

    return nil
end

local function CheckItemInList(settings, sourceData, itemId)
    local isInList = false

    for setting, value in pairs(settings) do
        if sourceData[setting] and sourceData[setting][itemId] then
            if (value) then
                return true
            else
                isInList = true
            end
        end
    end

    if isInList then
        return false
    end

    return nil
end

local function FilterToysByFaction(itemId)

    local allSettings = CheckAllSettings(ADDON.settings.filter.faction)
    if allSettings then
        return true
    end

    local settingResult = CheckItemInList(ADDON.settings.filter.faction, ADDON.db.faction, itemId)
    if settingResult ~= nil then
        return settingResult
    end

    return ADDON.settings.filter.faction.noFaction
end

local function FilterToysBySource(itemId)
    if CheckAllSettings(ADDON.settings.filter.source) then
        return true
    end

    return CheckItemInList(ADDON.settings.filter.source, ADDON.db.source, itemId)
end

local function FilterToysByProfession(itemId)
    return CheckItemInList(ADDON.settings.filter.profession, ADDON.db.profession, itemId)
end

local function FilterToysByWorldEvent(itemId)
    return CheckItemInList(ADDON.settings.filter.worldEvent, ADDON.db.worldEvent, itemId)
end

local function FilterToysByExpansion(itemId)

    local settingsResult = CheckAllSettings(ADDON.settings.filter.expansion)
    if settingsResult then
        return true
    end

    local settingResult = CheckItemInList(ADDON.settings.filter.expansion, ADDON.db.expansion, itemId)
    if settingResult ~= nil then
        return settingResult
    end

    for expansion, value in pairs(ADDON.settings.filter.expansion) do
        if ADDON.db.expansion[expansion] and
                ADDON.db.expansion[expansion]["minID"] <= itemId and
                itemId <= ADDON.db.expansion[expansion]["maxID"] then
            return value
        end
    end

    return false
end

local function FilterToysByEffect(itemId)
    local effectCategories = {}
    local effectSettings = {}

    -- flatten nested categorization
    for name, categoriesOrToys in pairs(ADDON.db.effect) do
        -- we need to go one layer deeper to check what categoriesOrToys holds
        for key, value in pairs(categoriesOrToys) do
            if type(key) == "string" then
                -- categoriesOrToys is a nested category.
                -- key is a filterKey and value is an array of toy IDs.
                effectCategories[key] = value
                effectSettings[key] = ADDON.settings.filter.effect[name][key]
            else
                -- categoriesOrToys is a list of toys.
                -- key is a toy ID and value is `true`.
                effectCategories[name] = categoriesOrToys
                effectSettings[name] = ADDON.settings.filter.effect[name]
            end
        end
    end

    local itemInList = CheckItemInList(effectSettings, effectCategories, itemId)
    if (itemInList == nil) then -- toy effect isn't categorized
        local allSettingsEnabled = CheckAllSettings(effectSettings)
        if (allSettingsEnabled == false) then -- every toy effect setting is disabled
            return true -- uncategorized toys should be shown when all filters are disabled
        end
    end

    return itemInList
end

function ADDON:FilterToy(itemId)
    local itemId, name, icon, favorited = C_ToyBox.GetToyInfo(itemId)
    local collected = PlayerHasToy(itemId)

    if (FilterHiddenToys(itemId)
            and FilterCollectedToys(collected)
            and FilterFavoriteToys(favorited)
            and FilterUsableToys(itemId)
            and FilterToysByFaction(itemId)
            and FilterToysByExpansion(itemId)
            and FilterToysByEffect(itemId)
            and (FilterToysBySource(itemId)
                or FilterToysByProfession(itemId)
                or FilterToysByWorldEvent(itemId))) then
        return true
    end

    return false
end
