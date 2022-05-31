local ADDON_NAME, ADDON = ...

local SETTING_COLLECTED = "collected"
local SETTING_ONLY_FAVORITES = "onlyFavorites"
local SETTING_NOT_COLLECTED = "notCollected"
local SETTING_ONLY_USEABLE = "onlyUsable"
local SETTING_ONLY_TRADABLE = "onlyTradable"
local SETTING_ONLY_RECENT = "onlyRecent"
local SETTING_HIDDEN = "hidden"
local SETTING_SECRET = "secret"
local SETTING_SOURCE = "source"
local SETTING_SORT = "sort"
local SETTING_PROFESSION = "profession"
local SETTING_WORLD_EVENT = "worldEvent"
local SETTING_FACTION = "faction"
local SETTING_EXPANSION = "expansion"
local SETTING_EFFECT = "effect"

local L = ADDON.L

local function UpdateResetVisibility()
    if ToyBoxFilterButton.ResetButton then
        ToyBoxFilterButton.ResetButton:SetShown(not ADDON:IsUsingDefaultFilters())
    end
end

local function CreateFilterInfo(text, filterKey, filterSettings, callback)
    local info = {
        keepShownOnClick = true,
        isNotRadio = true,
        hasArrow = false,
        text = text,
    }

    if filterKey then
        if not filterSettings then
            filterSettings = ADDON.settings.filter
        end
        info.arg1 = filterSettings
        info.checked = function(self)
            return self.arg1[filterKey]
        end
        info.func = function(_, arg1, arg2, value)
            arg1[filterKey] = arg2 or value
            ADDON:FilterAndRefresh()
            UIDropDownMenu_RefreshAll(_G[ADDON_NAME .. "FilterMenu"])
            UpdateResetVisibility()

            if callback then
                callback(value)
            end
        end
    else
        info.notCheckable = true
    end

    return info
end

local function CreateFilterRadio(text, filterKey, filterSettings, filterValue)
    local info = CreateFilterInfo(text, filterKey, filterSettings)
    info.isNotRadio = false
    info.arg2 = filterValue
    info.checked = function(self)
        return self.arg1[filterKey] == filterValue
    end

    return info
end

local function CreateFilterCategory(text, value)
    return {
        text = text,
        value = value,
        hasArrow = true,
        keepShownOnClick = true,
        notCheckable = true,
    }
end

local function CheckSetting(settings)
    local hasTrue, hasFalse = false, false
    for _, v in pairs(settings) do
        if (v == true) then
            hasTrue = true
        elseif v == false then
            hasFalse = true
        end
        if hasTrue and hasFalse then
            break
        end
    end

    return hasTrue, hasFalse
end

local function SetAllSubFilters(settings, switch)
    for key, value in pairs(settings) do
        if type(value) == "table" then
            for subKey, _ in pairs(value) do
                settings[key][subKey] = switch
            end
        else
            settings[key] = switch
        end
    end

    UIDropDownMenu_RefreshAll(_G[ADDON_NAME .. "FilterMenu"])
    ADDON:FilterAndRefresh()
    UpdateResetVisibility()
end

local function RefreshCategoryButton(button, isNotRadio)
    local buttonName = button:GetName()
    local buttonCheck = _G[buttonName .. "Check"]

    if isNotRadio then
        buttonCheck:SetTexCoord(0.0, 0.5, 0.0, 0.5);
    else
        buttonCheck:SetTexCoord(0.0, 0.5, 0.5, 1.0);
    end

    button.isNotRadio = isNotRadio
end

local function CreateInfoWithMenu(text, filterKey, settings)
    local info = {
        text = text,
        value = filterKey,
        keepShownOnClick = true,
        hasArrow = true,
    }

    local hasTrue, hasFalse = CheckSetting(settings)
    info.isNotRadio = not hasTrue or not hasFalse

    info.checked = function(button)
        local isTrue, isFalse = CheckSetting(settings)
        RefreshCategoryButton(button, not isTrue or not isFalse)
        return isTrue
    end
    info.func = function(button, _, _, value)
        if button.isNotRadio == value then
            SetAllSubFilters(settings, true)
        elseif true == button.isNotRadio and false == value then
            SetAllSubFilters(settings, false)
        end
    end

    return info
end

local function AddCheckAllAndNoneInfo(settings, level)
    local info = CreateFilterInfo(CHECK_ALL)
    info.func = function()
        for _, v in pairs(settings) do
            SetAllSubFilters(v, true)
        end
    end
    UIDropDownMenu_AddButton(info, level)

    info = CreateFilterInfo(UNCHECK_ALL)
    info.func = function()
        for _, v in pairs(settings) do
            SetAllSubFilters(v, false)
        end
    end
    UIDropDownMenu_AddButton(info, level)
end

local function HasUserHiddenToys()
    for _, value in pairs(ADDON.settings.hiddenToys) do
        if value == true then
            return true
        end
    end

    return false
end

local function InitializeDropDown(_, level)
    local info

    if level == 1 then
        UIDropDownMenu_AddButton(CreateFilterCategory(CLUB_FINDER_SORT_BY, SETTING_SORT), level)
        UIDropDownMenu_AddSpace(level)

        info = CreateFilterInfo(COLLECTED, SETTING_COLLECTED, nil, function(value)
            if value then
                UIDropDownMenu_EnableButton(1, 4)
                UIDropDownMenu_EnableButton(1, 5)
            else
                UIDropDownMenu_DisableButton(1, 4)
                UIDropDownMenu_DisableButton(1, 5)
            end
        end)
        UIDropDownMenu_AddButton(info, level)
        info = CreateFilterInfo(FAVORITES_FILTER, SETTING_ONLY_FAVORITES)
        info.leftPadding = 16
        info.disabled = not ADDON.settings.filter.collected
        UIDropDownMenu_AddButton(info, level)
        info = CreateFilterInfo(PET_JOURNAL_FILTER_USABLE_ONLY, SETTING_ONLY_USEABLE)
        info.leftPadding = 16
        info.disabled = not ADDON.settings.filter.collected
        UIDropDownMenu_AddButton(info, level)

        info = CreateFilterInfo(NOT_COLLECTED, SETTING_NOT_COLLECTED, nil, function (value)
            if value then
                UIDropDownMenu_EnableButton(1, 7)
            else
                UIDropDownMenu_DisableButton(1, 7)
            end
        end)
        UIDropDownMenu_AddButton(info, level)
        info = CreateFilterInfo(L.FILTER_SECRET, SETTING_SECRET)
        info.leftPadding = 16
        info.disabled = not ADDON.settings.filter.notCollected
        UIDropDownMenu_AddButton(info, level)

        UIDropDownMenu_AddButton(CreateFilterInfo(L.FILTER_ONLY_LATEST, SETTING_ONLY_RECENT), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L.FILTER_ONLY_TRADABLE, SETTING_ONLY_TRADABLE), level)

        if ADDON.settings.filter[SETTING_HIDDEN] or HasUserHiddenToys() then
            UIDropDownMenu_AddButton(CreateFilterInfo(L["Hidden"], SETTING_HIDDEN), level)
        end

        UIDropDownMenu_AddSpace(level)
        UIDropDownMenu_AddButton(CreateFilterCategory(L["Effect"], SETTING_EFFECT), level)
        UIDropDownMenu_AddButton(CreateFilterCategory(SOURCES, SETTING_SOURCE), level)
        UIDropDownMenu_AddButton(CreateFilterCategory(FACTION, SETTING_FACTION), level)
        UIDropDownMenu_AddButton(CreateFilterCategory(EXPANSION_FILTER_TEXT, SETTING_EXPANSION), level)

        UIDropDownMenu_AddSpace(level)
        info = CreateFilterInfo(L["Reset filters"])
        info.keepShownOnClick = false
        info.justifyH = "CENTER"
        info.func = function()
            ToyBoxFilterButton.resetFunction()
        end
        UIDropDownMenu_AddButton(info, level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_SOURCE) then
        local settings = ADDON.settings.filter[SETTING_SOURCE]
        AddCheckAllAndNoneInfo({ settings, ADDON.settings.filter[SETTING_PROFESSION], ADDON.settings.filter[SETTING_WORLD_EVENT] }, level)

        UIDropDownMenu_AddButton(CreateInfoWithMenu(BATTLE_PET_SOURCE_4, SETTING_PROFESSION, ADDON.settings.filter[SETTING_PROFESSION]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(BATTLE_PET_SOURCE_7, SETTING_WORLD_EVENT, ADDON.settings.filter[SETTING_WORLD_EVENT]), level)

        UIDropDownMenu_AddButton(CreateFilterInfo(GetSpellInfo(225652), "Treasure", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_1, "Drop", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_2, "Quest", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_3, "Vendor", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(INSTANCE, "Instance", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(REPUTATION, "Reputation", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_6, "Achievement", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(PVP, "PvP", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Order Hall"], "Order Hall", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GARRISON_LOCATION_TOOLTIP, "Garrison", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetSpellInfo(921), "Pick Pocket", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Black Market"], "Black Market", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_10, "Shop", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_8, "Promotion", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_PROFESSION) then
        local settings = ADDON.settings.filter[SETTING_PROFESSION]
        AddCheckAllAndNoneInfo({ settings }, level)

        UIDropDownMenu_AddButton(CreateFilterInfo(GetSpellInfo(25229), "Jewelcrafting", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetSpellInfo(7411), "Enchanting", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetSpellInfo(4036), "Engineering", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(INSCRIPTION, "Inscription", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetSpellInfo(2108), "Leatherworking", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(PROFESSIONS_ARCHAEOLOGY, "Archaeology", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(PROFESSIONS_COOKING, "Cooking", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(PROFESSIONS_FISHING, "Fishing", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_WORLD_EVENT) then
        local settings = ADDON.settings.filter[SETTING_WORLD_EVENT]
        AddCheckAllAndNoneInfo({ settings }, level)

        UIDropDownMenu_AddButton(CreateFilterInfo(PLAYER_DIFFICULTY_TIMEWALKER, "Timewalking", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(CALENDAR_FILTER_DARKMOON, "Darkmoon Faire", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetCategoryInfo(160), "Lunar Festival", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetCategoryInfo(187), "Love is in the Air", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetCategoryInfo(159), "Noblegarden", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetCategoryInfo(163), "Children's Week", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetCategoryInfo(161), "Midsummer Fire Festival", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetCategoryInfo(162), "Brewfest", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetCategoryInfo(158), "Hallow's End", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Day of the Dead"], "Day of the Dead", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetCategoryInfo(14981), "Pilgrim's Bounty", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Pirates' Day"], "Pirates' Day", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GetCategoryInfo(156), "Feast of Winter Veil", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_FACTION) then
        local settings = ADDON.settings.filter[SETTING_FACTION]
        UIDropDownMenu_AddButton(CreateFilterInfo(FACTION_ALLIANCE, "alliance", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(FACTION_HORDE, "horde", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(NPC_NAMES_DROPDOWN_NONE, "noFaction", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_EXPANSION) then
        local settings = ADDON.settings.filter[SETTING_EXPANSION]
        AddCheckAllAndNoneInfo({ settings }, level)
        for i = 0, #ADDON.db.expansion do
            UIDropDownMenu_AddButton(CreateFilterInfo(_G["EXPANSION_NAME" .. i], i, settings), level)
        end

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_EFFECT) then
        local settings = ADDON.settings.filter[SETTING_EFFECT]
        AddCheckAllAndNoneInfo({ settings }, level)

        local sortedEffects, hasSubCategories = {}, {}
        for effect, mainConfig in pairs(ADDON.db.effect) do
            hasSubCategories[effect] = false
            for _, subConfig in pairs(mainConfig) do
                if type(subConfig) == "table" then
                    hasSubCategories[effect] = true
                end
                break
            end
            table.insert(sortedEffects, effect)
        end
        table.sort(sortedEffects, function(a, b)
            return (L[a] or a) < (L[b] or b)
        end)

        for _, effect in pairs(sortedEffects) do
            if hasSubCategories[effect] then
                UIDropDownMenu_AddButton(CreateInfoWithMenu(L[effect] or effect, effect, settings[effect]), level)
            else
                UIDropDownMenu_AddButton(CreateFilterInfo(L[effect] or effect, effect, settings), level)
            end
        end

    elseif (level == 3 and ADDON.db.effect[UIDROPDOWNMENU_MENU_VALUE]) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][UIDROPDOWNMENU_MENU_VALUE]
        local sortedEffects = {}
        for effect, _ in pairs(ADDON.db.effect[UIDROPDOWNMENU_MENU_VALUE]) do
            table.insert(sortedEffects, effect)
        end
        table.sort(sortedEffects, function(a, b)
            return (L[a] or a) < (L[b] or b)
        end)

        if #sortedEffects > 3 then
            AddCheckAllAndNoneInfo({ settings }, level)
        end

        for _, effect in pairs(sortedEffects) do
            UIDropDownMenu_AddButton(CreateFilterInfo(L[effect] or effect, effect, settings), level)
        end
    elseif UIDROPDOWNMENU_MENU_VALUE == SETTING_SORT then
        local settings = ADDON.settings[SETTING_SORT]
        UIDropDownMenu_AddButton(CreateFilterRadio(NAME, "by", settings, 'name'), level)
        UIDropDownMenu_AddButton(CreateFilterRadio(EXPANSION_FILTER_TEXT, "by", settings, 'expansion'), level)
        UIDropDownMenu_AddSpace(level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L.SORT_REVERSE, 'descending', settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L.SORT_FAVORITES_FIRST, 'favoritesFirst', settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L.SORT_UNOWNED_AFTER, 'unownedAtLast', settings), level)
        UIDropDownMenu_AddSpace(level)

        info = CreateFilterInfo(NEWBIE_TOOLTIP_STOPWATCH_RESETBUTTON)
        info.keepShownOnClick = false
        info.justifyH = "CENTER"
        info.func = function()
            ADDON:ResetSortSettings()
            ADDON:FilterAndRefresh()
        end
        UIDropDownMenu_AddButton(info, level)
    end

end

ADDON.Events:RegisterCallback("OnLoadUI", function()
    local menu = CreateFrame("Frame", ADDON_NAME .. "FilterMenu", ToyBox, "UIDropDownMenuTemplate")
    UIDropDownMenu_Initialize(menu, InitializeDropDown, "MENU")

    local toggle = true
    DropDownList1:HookScript("OnHide", function()
        if not MouseIsOver(ToyBoxFilterButton) then
            toggle = true
        end
    end)

    ToyBoxFilterButton:HookScript('OnMouseDown', function(sender)
        if not InCombatLockdown() then
            HideDropDownMenu(1)
            if toggle then
                ToggleDropDownMenu(1, nil, menu, sender, 74, 15)
                toggle = false
            else
                toggle = true
            end
        end
    end)

    ToyBoxFilterButton.resetFunction = function()
        ADDON:ResetFilterSettings()
        ADDON:FilterAndRefresh()
        UpdateResetVisibility()
    end
    UpdateResetVisibility()

end, "filter-menu")
