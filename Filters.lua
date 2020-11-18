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

local function FilterToysByUse(itemId)

    return CheckItemInList(ADDON.settings.filter.use, ADDON.db.use, itemId)
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
            and FilterToysByUse(itemId)
            and (FilterToysBySource(itemId)
                or FilterToysByProfession(itemId)
                or FilterToysByWorldEvent(itemId))) then
        return true
    end

    return false
end
