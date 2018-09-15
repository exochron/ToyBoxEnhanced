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

    local settingResult = CheckItemInList(ADDON.settings.filter.faction, ADDON.ToyBoxEnhancedFaction, itemId)
    if settingResult ~= nil then
        return settingResult
    end

    return ADDON.settings.filter.faction.noFaction
end

local function FilterToysBySource(itemId)
    if CheckAllSettings(ADDON.settings.filter.source) then
        return true
    end

    return CheckItemInList(ADDON.settings.filter.source, ADDON.ToyBoxEnhancedSource, itemId)
end

local function FilterToysByProfession(itemId)
    return CheckItemInList(ADDON.settings.filter.profession, ADDON.ToyBoxEnhancedProfession, itemId)
end

local function FilterToysByWorldEvent(itemId)
    return CheckItemInList(ADDON.settings.filter.worldEvent, ADDON.ToyBoxEnhancedWorldEvent, itemId)
end

local function FilterToysByExpansion(itemId)

    local settingsResult = CheckAllSettings(ADDON.settings.filter.expansion)
    if settingsResult then
        return true
    end

    local settingResult = CheckItemInList(ADDON.settings.filter.expansion, ADDON.ToyBoxEnhancedExpansion, itemId)
    if settingResult ~= nil then
        return settingResult
    end

    for expansion, value in pairs(ADDON.settings.filter.expansion) do
        if ADDON.ToyBoxEnhancedExpansion[expansion] and
                ADDON.ToyBoxEnhancedExpansion[expansion]["minID"] <= itemId and
                itemId <= ADDON.ToyBoxEnhancedExpansion[expansion]["maxID"] then
            return value
        end
    end

    return false
end

function ADDON:FilterToy(toyIndex)
    local itemId, name, icon, favorited = ADDON:GetToyInfoOfOriginalIndex(toyIndex)
    local collected = PlayerHasToy(itemId)

    if (FilterHiddenToys(itemId)
            and FilterCollectedToys(collected)
            and FilterFavoriteToys(favorited)
            and FilterUsableToys(itemId)
            and FilterToysByFaction(itemId)
            and FilterToysByExpansion(itemId)
            and (FilterToysBySource(itemId)
                or FilterToysByProfession(itemId)
                or FilterToysByWorldEvent(itemId))) then
        return true
    end

    return false
end