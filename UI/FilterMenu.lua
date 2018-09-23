local ADDON_NAME, ADDON = ...

local SETTING_COLLECTED = "collected"
local SETTING_ONLY_FAVORITES = "onlyFavorites"
local SETTING_NOT_COLLECTED = "notCollected"
local SETTING_ONLY_USEABLE = "onlyUsable"
local SETTING_HIDDEN = "hidden"
local SETTING_SOURCE = "source"
local SETTING_PROFESSION = "profession"
local SETTING_WORLD_EVENT = "worldEvent"
local SETTING_FACTION = "faction"
local SETTING_EXPANSION = "expansion"

local L = ADDON.L

local function CreateFilterInfo(text, filterKey, filterSettings, callback)
    local info = MSA_DropDownMenu_CreateInfo()
    info.keepShownOnClick = true
    info.isNotRadio = true
    info.hasArrow = false
    info.text = text

    if filterKey then
        if not filterSettings then
            filterSettings = ADDON.settings.filter
        end
        info.arg1 = filterSettings
        info.notCheckable = false
        info.checked = function(self) return self.arg1[filterKey] end
        info.func = function(_, arg1, _, value)
            arg1[filterKey] = value
            ToyBox.firstCollectedToyID = 0
            ADDON:FilterAndRefresh()
            if (MSA_DROPDOWNMENU_MENU_LEVEL > 1) then
                for i=1, MSA_DROPDOWNMENU_MENU_LEVEL do
                    MSA_DropDownMenu_Refresh(_G[ADDON_NAME .. "FilterMenu"], nil, i)
                end
            end

            if callback then
                callback(value)
            end
        end
    else
        info.notCheckable = true
    end

    return info
end

local function CreateFilterCategory(text, value)
    local info = CreateFilterInfo(text)
    info.hasArrow = true
    info.value = value

    return info
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

    if (MSA_DROPDOWNMENU_MENU_LEVEL ~= 2) then
        MSA_DropDownMenu_Refresh(_G[ADDON_NAME .. "FilterMenu"], nil, 2)
    end
    MSA_DropDownMenu_Refresh(_G[ADDON_NAME .. "FilterMenu"])
    ToyBox.firstCollectedToyID = 0
    ADDON:FilterAndRefresh()
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
    local info = MSA_DropDownMenu_CreateInfo()
    info.text = text
    info.value = filterKey
    info.keepShownOnClick = true
    info.notCheckable = false
    info.hasArrow = true

    local hasTrue, hasFalse = CheckSetting(settings)
    info.isNotRadio = not hasTrue or not hasFalse

    info.checked = function(button)
        local hasTrue, hasFalse = CheckSetting(settings)
        RefreshCategoryButton(button, not hasTrue or not hasFalse)
        return hasTrue
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
    MSA_DropDownMenu_AddButton(info, level)

    info = CreateFilterInfo(UNCHECK_ALL)
    info.func = function()
        for _, v in pairs(settings) do
            SetAllSubFilters(v, false)
        end
    end
    MSA_DropDownMenu_AddButton(info, level)
end

local function InitializeDropDown(filterMenu, level)
    local info

    if (level == 1) then
        info = CreateFilterInfo(COLLECTED, SETTING_COLLECTED, nil, function(value)
            if (value) then
                MSA_DropDownMenu_EnableButton(1, 2)
            else
                MSA_DropDownMenu_DisableButton(1, 2)
            end
        end)
        MSA_DropDownMenu_AddButton(info, level)

        info = CreateFilterInfo(FAVORITES_FILTER, SETTING_ONLY_FAVORITES)
        info.leftPadding = 16
        info.disabled = not ADDON.settings.filter.collected
        MSA_DropDownMenu_AddButton(info, level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(NOT_COLLECTED, SETTING_NOT_COLLECTED), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Only usable"], SETTING_ONLY_USEABLE), level)

        MSA_DropDownMenu_AddButton(CreateFilterCategory(SOURCES, SETTING_SOURCE), level)
        MSA_DropDownMenu_AddButton(CreateFilterCategory(FACTION, SETTING_FACTION), level)
        MSA_DropDownMenu_AddButton(CreateFilterCategory(EXPANSION_FILTER_TEXT, SETTING_EXPANSION), level)

        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Hidden"], SETTING_HIDDEN), level)
        info = CreateFilterInfo(L["Reset filters"])
        info.keepShownOnClick = false
        info.func = function(_, _, _, value)
            ToyBox.firstCollectedToyID = 0
            ADDON:ResetFilterSettings()
            ADDON:FilterAndRefresh()
        end
        MSA_DropDownMenu_AddButton(info, level)

    elseif (MSA_DROPDOWNMENU_MENU_VALUE == SETTING_SOURCE) then
        local settings = ADDON.settings.filter[SETTING_SOURCE]
        AddCheckAllAndNoneInfo({settings, ADDON.settings.filter[SETTING_PROFESSION], ADDON.settings.filter[SETTING_WORLD_EVENT]}, level)

        MSA_DropDownMenu_AddButton(CreateInfoWithMenu(BATTLE_PET_SOURCE_4, SETTING_PROFESSION, ADDON.settings.filter[SETTING_PROFESSION]), level)
        MSA_DropDownMenu_AddButton(CreateInfoWithMenu(BATTLE_PET_SOURCE_7, SETTING_WORLD_EVENT, ADDON.settings.filter[SETTING_WORLD_EVENT]), level)

        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Treasure"], "Treasure", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_1, "Drop", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_2, "Quest", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_3, "Vendor", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(INSTANCE, "Instance", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(REPUTATION, "Reputation", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_6, "Achievement", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(PVP, "PvP", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Order Hall"], "Order Hall", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(GARRISON_LOCATION_TOOLTIP, "Garrison", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Pick Pocket"], "Pick Pocket", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Black Market"], "Black Market", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_8, "Promotion", settings), level)

    elseif (MSA_DROPDOWNMENU_MENU_VALUE == SETTING_PROFESSION) then
        local settings = ADDON.settings.filter[SETTING_PROFESSION]
        AddCheckAllAndNoneInfo({settings}, level)

        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Jewelcrafting"], "Jewelcrafting", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Enchanting"], "Enchanting", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Engineering"], "Engineering", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(INSCRIPTION, "Inscription", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Leatherworking"], "Leatherworking", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(PROFESSIONS_ARCHAEOLOGY, "Archaeology", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(PROFESSIONS_COOKING, "Cooking", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(PROFESSIONS_FISHING, "Fishing", settings), level)

    elseif (MSA_DROPDOWNMENU_MENU_VALUE == SETTING_WORLD_EVENT) then
        local settings = ADDON.settings.filter[SETTING_WORLD_EVENT]
        AddCheckAllAndNoneInfo({settings}, level)

        MSA_DropDownMenu_AddButton(CreateFilterInfo(PLAYER_DIFFICULTY_TIMEWALKER, "Timewalking", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(CALENDAR_FILTER_DARKMOON, "Darkmoon Faire", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Lunar Festival"], "Lunar Festival", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Love is in the Air"], "Love is in the Air", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Children's Week"], "Children's Week", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Midsummer Fire Festival"], "Midsummer Fire Festival", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Brewfest"], "Brewfest", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Hallow's End"], "Hallow's End", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Day of the Dead"], "Day of the Dead", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Pilgrim's Bounty"], "Pilgrim's Bounty", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Pirates' Day"], "Pirates' Day", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(L["Feast of Winter Veil"], "Feast of Winter Veil", settings), level)

    elseif (MSA_DROPDOWNMENU_MENU_VALUE == SETTING_FACTION) then
        local settings = ADDON.settings.filter[SETTING_FACTION]
        MSA_DropDownMenu_AddButton(CreateFilterInfo(FACTION_ALLIANCE, "alliance", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(FACTION_HORDE, "horde", settings), level)
        MSA_DropDownMenu_AddButton(CreateFilterInfo(NPC_NAMES_DROPDOWN_NONE, "noFaction", settings), level)

    elseif (MSA_DROPDOWNMENU_MENU_VALUE == SETTING_EXPANSION) then
        local settings = ADDON.settings.filter[SETTING_EXPANSION]
        AddCheckAllAndNoneInfo({settings}, level)
        for i = 0, 7 do
            MSA_DropDownMenu_AddButton(CreateFilterInfo(_G["EXPANSION_NAME" .. i], _G["EXPANSION_NAME" .. i], settings), level)
        end
    end

end

ADDON:RegisterLoadUICallback(function()
    local menu = MSA_DropDownMenu_Create(ADDON_NAME .. "FilterMenu", ToyBoxFilterButton)
    MSA_DropDownMenu_Initialize(menu, InitializeDropDown, "MENU")
    ToyBoxFilterButton:HookScript("OnClick", function(sender)
--        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
        MSA_ToggleDropDownMenu(1, nil, menu, sender, 74, 15)
    end)
end)
