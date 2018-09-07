local ADDON_NAME, ADDON = ...

local DropDownOrderSource = { "Profession", "World Event", "Treasure", "Drop", "Quest", "Vendor", "Instance", "Reputation", "Achievement", "PvP", "Order Hall", "Garrison", "Pick Pocket", "Black Market", "Promotion" }
local DropDownOrderProfessions = { "Jewelcrafting", "Enchanting", "Engineering", "Inscription", "Leatherworking", "Archaeology", "Cooking", "Fishing" }
local DropDownOrderWorldEvents = { "Timewalking", "Darkmoon Faire", "Lunar Festival", "Love is in the Air", "Children's Week", "Midsummer Fire Festival", "Brewfest", "Hallow's End", "Day of the Dead", "Pilgrim's Bounty", "Pirates' Day", "Feast of Winter Veil" }
local DropDownOrderExpansions = { "Classic", "The Burning Crusade", "Wrath of the Lich King", "Cataclysm", "Mists of Pandaria", "Warlords of Draenor", "Legion", "Battle for Azeroth" }

local L = ADDON.L

local function CreateFilterInfo(text, filterKey, subfilterKey, callback)
    local info = UIDropDownMenu_CreateInfo()
    info.keepShownOnClick = true
    info.isNotRadio = true
    info.text = text

    if filterKey then
        info.hasArrow = false
        info.notCheckable = false
        if subfilterKey then
            info.checked = function() return ADDON.settings.filter[filterKey][subfilterKey] end
        else
            info.checked = ADDON.settings.filter[filterKey]
        end
        info.func = function(_, _, _, value)
            ToyBox.firstCollectedToyID = 0
            if subfilterKey then
                ADDON.settings.filter[filterKey][subfilterKey] = value
            else
                ADDON.settings.filter[filterKey] = value
            end
            ADDON:FilterAndRefresh()

            if callback then
                callback(value)
            end
        end
    else
        info.hasArrow = true
        info.notCheckable = true
    end

    return info
end

local function AddCheckAllAndNoneInfo(filterKeys, level, dropdownLevel)
    local info = CreateFilterInfo(CHECK_ALL)
    info.hasArrow = false
    info.func = function()
        for _, filterKey in pairs(filterKeys) do
            for key, _ in pairs(ADDON.settings.filter[filterKey]) do
                ADDON.settings.filter[filterKey][key] = true
            end
        end

        UIDropDownMenu_Refresh(ToyBoxFilterDropDown, dropdownLevel, level)
        ADDON:FilterAndRefresh()
    end
    UIDropDownMenu_AddButton(info, level)

    info = CreateFilterInfo(UNCHECK_ALL)
    info.hasArrow = false
    info.func = function()
        for _, filterKey in pairs(filterKeys) do
            for key, _ in pairs(ADDON.settings.filter[filterKey]) do
                ADDON.settings.filter[filterKey][key] = false
            end
        end

        UIDropDownMenu_Refresh(ToyBoxFilterDropDown, dropdownLevel, level)
        ADDON:FilterAndRefresh()
    end
    UIDropDownMenu_AddButton(info, level)
end

function ADDON:ToyBoxFilterDropDown_Initialize(sender, level)
    local info = UIDropDownMenu_CreateInfo()
    info.keepShownOnClick = true

    if level == 1 then
        info = CreateFilterInfo(COLLECTED, "collected", nil, function(value)
            if (value) then
                UIDropDownMenu_EnableButton(1, 2)
            else
                UIDropDownMenu_DisableButton(1, 2)
            end
        end)
        UIDropDownMenu_AddButton(info, level)

        info = CreateFilterInfo(FAVORITES_FILTER, "onlyFavorites")
        info.leftPadding = 16
        info.disabled = not ADDON.settings.filter.collected
        UIDropDownMenu_AddButton(info, level)

        info = CreateFilterInfo(NOT_COLLECTED, "notCollected")
        UIDropDownMenu_AddButton(info, level)

        info = CreateFilterInfo(L["Only usable"], "onlyUsable")
        UIDropDownMenu_AddButton(info, level)

        info = CreateFilterInfo(SOURCES)
        info.value = 1
        UIDropDownMenu_AddButton(info, level)

        info = CreateFilterInfo(FACTION)
        info.value = 2
        UIDropDownMenu_AddButton(info, level)

        info = CreateFilterInfo(L["Expansion"])
        info.value = 5
        UIDropDownMenu_AddButton(info, level)

        info = CreateFilterInfo(L["Hidden"], "hidden")
        UIDropDownMenu_AddButton(info, level)

        info = CreateFilterInfo(L["Reset filters"])
        info.keepShownOnClick = false
        info.hasArrow = false
        info.func = function(_, _, _, value)
            ToyBox.firstCollectedToyID = 0
            ADDON:ResetFilterSettings()
            ADDON:FilterAndRefresh()
        end
        UIDropDownMenu_AddButton(info, level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == 1) then
        AddCheckAllAndNoneInfo({ "source", "profession", "worldEvent" }, level, 1)
        for _, sourceName in pairs(DropDownOrderSource) do
            if sourceName == "Profession" then
                info = CreateFilterInfo(L[sourceName])
                info.value = 3
            elseif sourceName == "World Event" then
                info = CreateFilterInfo(L[sourceName])
                info.value = 4
            else
                info = CreateFilterInfo(L[sourceName], "source", sourceName)
            end
            UIDropDownMenu_AddButton(info, level)
        end

    elseif (UIDROPDOWNMENU_MENU_VALUE == 2) then
        info = CreateFilterInfo(FACTION_ALLIANCE, "faction", "alliance")
        UIDropDownMenu_AddButton(info, level)
        info = CreateFilterInfo(FACTION_HORDE, "faction", "horde")
        UIDropDownMenu_AddButton(info, level)
        info = CreateFilterInfo(NPC_NAMES_DROPDOWN_NONE, "faction", "noFaction")
        UIDropDownMenu_AddButton(info, level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == 3) then
        AddCheckAllAndNoneInfo({ "profession" }, level, 3)
        for _, professionName in pairs(DropDownOrderProfessions) do
            info = CreateFilterInfo(L[professionName], "profession", professionName)
            UIDropDownMenu_AddButton(info, level)
        end

    elseif (UIDROPDOWNMENU_MENU_VALUE == 4) then
        AddCheckAllAndNoneInfo({ "worldEvent" }, level, 4)
        for _, eventName in pairs(DropDownOrderWorldEvents) do
            info = CreateFilterInfo(L[eventName], "worldEvent", eventName)
            UIDropDownMenu_AddButton(info, level)
        end

    elseif (UIDROPDOWNMENU_MENU_VALUE == 5) then
        AddCheckAllAndNoneInfo({ "expansion" }, level, 5)
        for _, expansion in pairs(DropDownOrderExpansions) do
            info = CreateFilterInfo(L[expansion], "expansion", expansion)
            UIDropDownMenu_AddButton(info, level)
        end
    end
end

ADDON:RegisterLoadUICallback(function()
    hooksecurefunc(ToyBoxFilterDropDown, "initialize", function(sender, level) UIDropDownMenu_InitializeHelper(sender) ADDON:ToyBoxFilterDropDown_Initialize(sender, level) end)
end)
