local _, ADDON = ...

local function FilterBySearch(itemId, searchString)
    local _, name = C_ToyBox.GetToyInfo(itemId)
    if name == nil or name == '' then
        return false
    end

    name = name:lower()
    local pos = strfind(name, searchString, 1, true)
    local result = pos ~= nil
    if result then
        return result
    end

    if ADDON.settings.searchInDescription then
        local _, spellId = GetItemSpell(itemId)
        local spellDescription = GetSpellDescription(spellId)
        spellDescription = spellDescription:lower()
        pos = strfind(spellDescription, searchString, 1, true)
        result = pos ~= nil
    end

    return result
end

local function FilterUserHiddenToys(itemId)
    return ADDON.settings.filter.hidden or not ADDON.settings.hiddenToys[itemId]
end
local function FilterSecretToys(itemId)
    return ADDON.settings.filter.secret or ADDON.db.ingameList[itemId] == true
end

local function FilterCollectedToys(itemId)
    local collected = PlayerHasToy(itemId)
    return (ADDON.settings.filter.collected and collected) or (ADDON.settings.filter.notCollected and not collected)
end

local function FilterFavoriteToys(itemId)
    return not ADDON.settings.filter.onlyFavorites or not ADDON.settings.filter.collected or C_ToyBox.GetIsFavorite(itemId)
end

local function FilterUsableToys(itemId)
    return not ADDON.settings.filter.onlyUsable or C_ToyBox.IsToyUsable(itemId)
end

local function CheckAllSettings(settings)
    local allDisabled = true
    local allEnabled = true
    for _, value in pairs(settings) do
        if type(value) == "table" then
            local subResult = CheckAllSettings(value)
            if subResult == nil then
                allDisabled = false
                allEnabled = false
                break
            elseif subResult == true then
                allDisabled = false
            elseif subResult == false then
                allEnabled = false
            end
        elseif value then
            allDisabled = false
        else
            allEnabled = false
        end

        if allEnabled == false and allDisabled == false then
            break
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

local function FilterTradableToys(itemId)
    return not ADDON.settings.filter.onlyTradable or ADDON.db.Tradable[itemId]
end

local function FilterRecentToys(itemId)
    return not ADDON.settings.filter.onlyRecent or (ADDON.db.Recent.minID <= itemId and not tContains(ADDON.db.Recent.blacklist, itemId))
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
    local settings = ADDON.settings.filter.effect

    local allSettingsResult = CheckAllSettings(settings)
    if allSettingsResult then
        return true
    end

    for name, categoriesOrToys in pairs(ADDON.db.effect) do
        local hasCategories = false
        for _, value in pairs(categoriesOrToys) do
            if type(value) == "table" then
                hasCategories = true
            end
            break
        end

        if hasCategories then
            local settingResult = CheckItemInList(settings[name], categoriesOrToys, itemId)
            if settingResult ~= nil then
                return settingResult
            end
        end
    end

    local settingResult = CheckItemInList(settings, ADDON.db.effect, itemId)
    if settingResult ~= nil then
        return settingResult
    end

    -- Todo: Remove later
    if allSettingsResult == false then
        return true -- uncategorized toys should be shown when all filters are disabled
    end

    return false
end

local function UpdateDataProvider(result)
    local dataProvider = ADDON.DataProvider
    if #result == 0 then
        dataProvider:Flush()
    else
        local flippedResult = CopyValuesAsKeys(result)
        local skipAdd = {}
        local toRemove = {}
        dataProvider:ForEach(function(itemId)
            local resultPosition = flippedResult[itemId]
            if resultPosition then
                -- already in provider
                skipAdd[itemId] = true
            else
                toRemove[#toRemove + 1] = itemId
            end
        end)
        if #toRemove > 0 then
            dataProvider:Remove(unpack(toRemove))
        end
        local toAdd = tFilter(result, function(itemId)
            return not skipAdd[itemId]
        end, true)
        if #toAdd > 0 then
            dataProvider:InsertTable(toAdd)
        end
    end
end

function ADDON:FilterToys()
    local result = {}

    local searchString = ToyBox and ToyBox.searchString or ""
    if searchString ~= "" then
        searchString = searchString:lower()
        for itemId in pairs(ADDON.db.ingameList) do
            if FilterBySearch(itemId, searchString) then
                result[#result + 1] = itemId
            end
        end
    else
        for itemId in pairs(ADDON.db.ingameList) do
            if FilterUserHiddenToys(itemId)
                and FilterSecretToys(itemId)
                and FilterCollectedToys(itemId)
                and FilterFavoriteToys(itemId)
                and FilterTradableToys(itemId)
                and FilterRecentToys(itemId)
                and FilterUsableToys(itemId)
                and FilterToysByFaction(itemId)
                and FilterToysByExpansion(itemId)
                and FilterToysByEffect(itemId)
                and (FilterToysBySource(itemId) or FilterToysByProfession(itemId) or FilterToysByWorldEvent(itemId))
            then
                result[#result + 1] = itemId
            end
        end
    end

    UpdateDataProvider(result)

    return result
end
