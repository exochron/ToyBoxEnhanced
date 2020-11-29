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
local SETTING_EFFECT = "effect"
local SETTING_APPEARANCE = "Appearance"
local SETTING_CONSUMABLES = "Consumables"
local SETTING_CONTROLLERS = "Controllers"
local SETTING_CRITTERS = "Critters"
local SETTING_EMOTES = "Emotes"
local SETTING_ENVIRONMENT = "Environment"
local SETTING_INTERACTABLES = "Interactables"
local SETTING_MINIGAMES = "Minigames"
local SETTING_PROFESSION_EFFECTS = "Profession Effects"
local SETTING_PVP = "PVP"
local SETTING_SOUNDS = "Sounds"
local SETTING_TRANSPORTATION = "Transportation"

local L = ADDON.L

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
        info.func = function(_, arg1, _, value)
            arg1[filterKey] = value
            ADDON:FilterAndRefresh()
            UIDropDownMenu_RefreshAll(_G[ADDON_NAME .. "FilterMenu"])

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

local function InitializeDropDown(filterMenu, level)
    local info

    if (level == 1) then
        info = CreateFilterInfo(COLLECTED, SETTING_COLLECTED, nil, function(value)
            if (value) then
                UIDropDownMenu_EnableButton(1, 2)
                UIDropDownMenu_EnableButton(1, 3)
            else
                UIDropDownMenu_DisableButton(1, 2)
                UIDropDownMenu_DisableButton(1, 3)
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

        UIDropDownMenu_AddButton(CreateFilterInfo(NOT_COLLECTED, SETTING_NOT_COLLECTED), level)
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
        info.func = function(_, _, _, value)
            ADDON:ResetFilterSettings()
            ADDON:FilterAndRefresh()
        end
        UIDropDownMenu_AddButton(info, level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_SOURCE) then
        local settings = ADDON.settings.filter[SETTING_SOURCE]
        AddCheckAllAndNoneInfo({ settings, ADDON.settings.filter[SETTING_PROFESSION], ADDON.settings.filter[SETTING_WORLD_EVENT] }, level)

        UIDropDownMenu_AddButton(CreateInfoWithMenu(BATTLE_PET_SOURCE_4, SETTING_PROFESSION, ADDON.settings.filter[SETTING_PROFESSION]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(BATTLE_PET_SOURCE_7, SETTING_WORLD_EVENT, ADDON.settings.filter[SETTING_WORLD_EVENT]), level)

        UIDropDownMenu_AddButton(CreateFilterInfo(L["Treasure"], "Treasure", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_1, "Drop", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_2, "Quest", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_3, "Vendor", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(INSTANCE, "Instance", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(REPUTATION, "Reputation", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_6, "Achievement", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(PVP, "PvP", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Order Hall"], "Order Hall", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(GARRISON_LOCATION_TOOLTIP, "Garrison", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Pick Pocket"], "Pick Pocket", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Black Market"], "Black Market", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_10, "Shop", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BATTLE_PET_SOURCE_8, "Promotion", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_PROFESSION) then
        local settings = ADDON.settings.filter[SETTING_PROFESSION]
        AddCheckAllAndNoneInfo({ settings }, level)

        UIDropDownMenu_AddButton(CreateFilterInfo(L["Jewelcrafting"], "Jewelcrafting", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Enchanting"], "Enchanting", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Engineering"], "Engineering", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(INSCRIPTION, "Inscription", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Leatherworking"], "Leatherworking", settings), level)
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

        UIDropDownMenu_AddButton(CreateInfoWithMenu(L["Appearance"], SETTING_APPEARANCE, ADDON.settings.filter[SETTING_EFFECT][SETTING_APPEARANCE]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(L["Consumable"], SETTING_CONSUMABLES, ADDON.settings.filter[SETTING_EFFECT][SETTING_CONSUMABLES]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(L["Controller"], SETTING_CONTROLLERS, ADDON.settings.filter[SETTING_EFFECT][SETTING_CONTROLLERS]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(BATTLE_PET_NAME_5, SETTING_CRITTERS, ADDON.settings.filter[SETTING_EFFECT][SETTING_CRITTERS]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(EMOTE, SETTING_EMOTES, ADDON.settings.filter[SETTING_EFFECT][SETTING_EMOTES]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(ENVIRONMENT_SUBHEADER, SETTING_ENVIRONMENT, ADDON.settings.filter[SETTING_EFFECT][SETTING_ENVIRONMENT]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(L["Interactable"], SETTING_INTERACTABLES, ADDON.settings.filter[SETTING_EFFECT][SETTING_INTERACTABLES]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(GAMES, SETTING_MINIGAMES, ADDON.settings.filter[SETTING_EFFECT][SETTING_MINIGAMES]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(BATTLE_PET_SOURCE_4, SETTING_PROFESSION_EFFECTS, ADDON.settings.filter[SETTING_EFFECT][SETTING_PROFESSION_EFFECTS]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(PVP, SETTING_PVP, ADDON.settings.filter[SETTING_EFFECT][SETTING_PVP]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(SOUND, SETTING_SOUNDS, ADDON.settings.filter[SETTING_EFFECT][SETTING_SOUNDS]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(L["Transportation"], SETTING_TRANSPORTATION, ADDON.settings.filter[SETTING_EFFECT][SETTING_TRANSPORTATION]), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Perception"], "Perception", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(AUCTION_CATEGORY_BATTLE_PETS, "Pets", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_APPEARANCE) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_APPEARANCE]
        AddCheckAllAndNoneInfo({ settings }, level)

        UIDropDownMenu_AddButton(CreateFilterInfo(LOC_TYPE_FULL, "Full", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Minor"], "Minor", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Bigger"], "Bigger", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Smaller"], "Smaller", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(COLOR, "Color", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Pennant"], "Pennant", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_CONSUMABLES) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_CONSUMABLES]

        UIDropDownMenu_AddButton(CreateFilterInfo(L["Alcohol"], "Alcohol", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(MINIMAP_TRACKING_VENDOR_FOOD, "Food/Water", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(OTHER, "Other Usable Items", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_CONTROLLERS) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_CONTROLLERS]

        UIDropDownMenu_AddButton(CreateFilterInfo(L["Aircraft"], "Aircraft", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Tonk"], "Tonks", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Vision"], "Vision", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_CRITTERS) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_CRITTERS]

        UIDropDownMenu_AddButton(CreateFilterInfo(L["Nearby"], "Nearby", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(SUMMON, "Summon", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_EMOTES) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_EMOTES]
        AddCheckAllAndNoneInfo({ settings }, level)

        UIDropDownMenu_AddButton(CreateFilterInfo(L["Act"], "Acts", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(CORPSE, "Corpse", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(ROLL, "Roll", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Statue"], "Statue", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_ENVIRONMENT) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_ENVIRONMENT]
        AddCheckAllAndNoneInfo({ settings }, level)

        UIDropDownMenu_AddButton(CreateFilterInfo(L["Banner"], "Banners", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Clone"], "Clone", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Firework"], "Fireworks", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Ground"], "Ground", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(PET_BATTLE_WEATHER_LABEL, "Weather", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_INTERACTABLES) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_INTERACTABLES]
        AddCheckAllAndNoneInfo({ settings }, level)

        UIDropDownMenu_AddButton(CreateFilterInfo("Chair", "Chairs", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo("Clickable", "Clickables", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(MAIL_LABEL, "Mail", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo("NPC", "NPCs", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo("Target Dummy", "Target Dummies", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_MINIGAMES) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_MINIGAMES]

        UIDropDownMenu_AddButton(CreateFilterInfo(SOLO, "Solo", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo("Co-op", "Co-op", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_PROFESSION_EFFECTS) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_PROFESSION_EFFECTS]
        AddCheckAllAndNoneInfo({ settings }, level)

        UIDropDownMenu_AddButton(CreateFilterInfo(PROFESSIONS_COOKING, "Cooking Effects", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(PROFESSIONS_FISHING, "Fishing Effects", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Jewelcrafting"], "Jewelcrafting Effects", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Skinning"], "Skinning Effects", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_PVP) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_PVP]
        AddCheckAllAndNoneInfo({ settings }, level)

        UIDropDownMenu_AddButton(CreateFilterInfo(WORLD_PVP, "Ashran", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(BINDING_NAME_DISMOUNT, "Dismounts", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Taunt"], "Taunts", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Transform"], "Transforms", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_SOUNDS) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_SOUNDS]

        UIDropDownMenu_AddButton(CreateFilterInfo(L["Effect"], "Effects", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(VOICE_MUSIC, "Music", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L["Voice"], "Voice", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_TRANSPORTATION) then
        local settings = ADDON.settings.filter[SETTING_EFFECT][SETTING_TRANSPORTATION]
        AddCheckAllAndNoneInfo({ settings }, level)

        UIDropDownMenu_AddButton(CreateFilterInfo("Fly/Fall", "Fly/Fall", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo("Flight Path", "Flight Paths", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo("Hearthstone", "Hearthstones", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(NPE_JUMP, "Jump", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo("Run", "Run", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo("Swim", "Swim", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo("Teleport", "Teleports", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo("Water Walk", "Water Walk", settings), level)

    end

end

ADDON:RegisterLoadUICallback(function()
    local menu = CreateFrame("Frame", ADDON_NAME .. "FilterMenu", ToyBox, "UIDropDownMenuTemplate")
    UIDropDownMenu_Initialize(menu, InitializeDropDown, "MENU")

    local toggle = true
    DropDownList1:HookScript("OnHide", function()
        if not MouseIsOver(ToyBoxFilterButton) then
            toggle = true
        end
    end)

    ToyBoxFilterButton:HookScript('OnMouseDown', function(sender, button)
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
end)
