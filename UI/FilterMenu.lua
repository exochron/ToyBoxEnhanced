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

local function setAllSettings(settings, switch)
    for key, value in pairs(settings) do
        if type(value) == "table" then
            for subKey, _ in pairs(value) do
                settings[key][subKey] = switch
            end
        else
            settings[key] = switch
        end
    end
end

local onlyPool
local function AddOnlyButton(info, settings)
    if not onlyPool then
        onlyPool = CreateFramePool("Button")
    end

    local onlyButton = onlyPool:Acquire()
    if not onlyButton.initialized then
        onlyButton:SetNormalFontObject(GameFontHighlightSmallLeft)
        onlyButton:SetHighlightFontObject(GameFontHighlightSmallLeft)
        onlyButton:SetText(ADDON.L.FILTER_ONLY)

        onlyButton:SetSize(onlyButton:GetTextWidth(), UIDROPDOWNMENU_BUTTON_HEIGHT)

        onlyButton.CallParent = function(self, script, ...)
            local parent = self:GetParent()
            parent:GetScript(script)(parent, ...)
        end

        onlyButton:HookScript("OnEnter", function(self)
            self:Show()
            self:CallParent("OnEnter")
        end)
        onlyButton:HookScript("OnLeave", function(self)
            if not self:GetParent():IsMouseOver() then
                self:CallParent("OnLeave")
                if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE  then
                    self:Hide()
                end
            end
        end)

        onlyButton.initialized = true
    end

    -- overwrite every time
    onlyButton:SetScript("OnClick", function(self, ...)
        setAllSettings(settings, false)
        self:CallParent("OnClick", ...)
    end)

    -- classic doesn't has funcOnEnter and funcOnLeave yet. so we simply always show
    if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE  then
        info.funcOnEnter = function()
            onlyButton:Show()
        end
        info.funcOnLeave = function()
            if not onlyButton:IsMouseOver() then
                onlyButton:Hide()
            end
        end
    end
    info.customFrame = {
        only = onlyButton,
        button = nil,
        Show = function(self)
            self.button:Show()
            if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE  then
                self.only:Show()
            end
        end,
        Hide = function(self)
            self.button:Hide()
            self.only:SetParent()
            onlyPool:Release(self.only)
        end,
        IsShown = function(self)
            return self.button:IsShown()
        end,
        SetOwningButton = function(self, button)
            self.button = button
            self.only:SetParent(button)
            self.only:SetPoint("RIGHT", button, "RIGHT")
            self.only:SetFrameLevel(button:GetFrameLevel()+2)
        end,
        ClearAllPoints = function() end,
        SetPoint = function() end,
        GetPreferredEntryWidth = function(self)
            local button = self.button
            local width = button:GetTextWidth() + 40
            -- Add padding if has and expand arrow or color swatch
            if ( button.hasArrow or button.hasColorSwatch ) then
                width = width + 10;
            end
            if ( button.padding ) then
                width = width + button.padding;
            end

            width = width + self.only:GetTextWidth()

            return width
        end,
        GetPreferredEntryHeight = function(self)
            self.button:Show() -- show again after SetShown(false) in default logic
            return self.button:GetHeight()
        end
    }

    return info
end

local function CreateFilterInfo(text, filterKey, filterSettings, withOnly, callback)
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
            ADDON:FilterToys()
            UIDropDownMenu_RefreshAll(_G[ADDON_NAME .. "FilterMenu"])
            UpdateResetVisibility()

            if callback then
                callback(value)
            end
        end
        if withOnly then
            -- accept other settings table as withOnly-Param
            info = AddOnlyButton(info, true == withOnly and filterSettings or withOnly)
        end
    else
        info.notCheckable = true
    end

    return info
end

local function CreateFilterRadio(text, filterKey, filterSettings, filterValue, callback)
    local info = CreateFilterInfo(text, filterKey, filterSettings, false, callback)
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
    setAllSettings(settings, switch)

    UIDropDownMenu_RefreshAll(_G[ADDON_NAME .. "FilterMenu"])
    ADDON:FilterToys()
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

local hookedWidthButtons = {}
local function HookResizeButtonWidth(button, calcWidth)
    local name = button:GetName()
    button.arg2 = {"TBE_RESIZE", calcWidth}
    if not hookedWidthButtons[name] then
        hookedWidthButtons[name] = true
        hooksecurefunc(button, "SetWidth", function(self, width)
            if "table" == type(self.arg2) and self.arg2[1] == "TBE_RESIZE" then
                self:SetSize(self.arg2[2](width), self:GetHeight())
            end
        end)
    end
end
local function AddCheckAllAndNoneInfo(settings, level)
    local info = CreateFilterInfo(ALL)
    info.justifyH = "CENTER"
    info.func = function()
        for _, v in pairs(settings) do
            SetAllSubFilters(v, true)
        end
    end
    local AllButton = UIDropDownMenu_AddButton(info, level)
    HookResizeButtonWidth(AllButton, function(w) return w/2 end)

    info = CreateFilterInfo(NONE)
    info.justifyH = "CENTER"
    info.func = function()
        for _, v in pairs(settings) do
            SetAllSubFilters(v, false)
        end
    end
    local NoneButton = UIDropDownMenu_AddButton(info, level)
    NoneButton:SetPoint("TOPLEFT", AllButton, "TOPRIGHT", 0, 0)
    HookResizeButtonWidth(NoneButton, function(w) return w/2 end)
end

local function HasUserHiddenToys()
    for _, value in pairs(ADDON.settings.hiddenToys) do
        if value == true then
            return true
        end
    end

    return false
end

local function AddOrderedFilterButtons(order, database, settings,  resetSettings, level)
    for _, index in ipairs(order) do
        if database[index] then
            local button = UIDropDownMenu_AddButton(CreateFilterInfo(L[index], index, settings, resetSettings), level)
            if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                -- somehow some menu items don't get displayed properly.
                local a,_,c,d,e = button:GetPoint(1)
                button:SetParent(_G["DropDownList"..level])
                button:SetPoint(a, _G["DropDownList"..level], c,d,e)
            end
        end
    end
end

local function InitializeDropDown(frame, level)
    local info

    if level == 1 then
        UIDropDownMenu_AddButton(CreateFilterCategory(RAID_FRAME_SORT_LABEL, SETTING_SORT), level)
        UIDropDownMenu_AddSpace(level)

        info = CreateFilterInfo(COLLECTED, SETTING_COLLECTED, nil, nil, function(value)
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

        info = CreateFilterInfo(NOT_COLLECTED, SETTING_NOT_COLLECTED, nil, nil,function (value)
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
            UIDropDownMenu_AddButton(CreateFilterInfo(L["FILTER_HIDDEN_MANUAL"], SETTING_HIDDEN), level)
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
        local resetSettings = { settings, ADDON.settings.filter[SETTING_PROFESSION], ADDON.settings.filter[SETTING_WORLD_EVENT] }
        AddCheckAllAndNoneInfo(resetSettings, level)

        UIDropDownMenu_AddButton(CreateInfoWithMenu(BATTLE_PET_SOURCE_4, SETTING_PROFESSION, ADDON.settings.filter[SETTING_PROFESSION]), level)
        UIDropDownMenu_AddButton(CreateInfoWithMenu(BATTLE_PET_SOURCE_7, SETTING_WORLD_EVENT, ADDON.settings.filter[SETTING_WORLD_EVENT]), level)

        local sourceOrder = {
            "Treasure",
            "Drop",
            "Quest",
            "Vendor",
            "Instance",
            "Reputation",
            "Achievement",
            "PvP",
            "Order Hall",
            "Garrison",
            "Pick Pocket",
            "Trading Post",
            "Black Market",
            "Promotion",
            "Shop",
        }
        AddOrderedFilterButtons(sourceOrder, ADDON.db.source, settings, resetSettings, level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_PROFESSION) then
        local settings = ADDON.settings.filter[SETTING_PROFESSION]
        local resetSettings = { settings, ADDON.settings.filter[SETTING_SOURCE], ADDON.settings.filter[SETTING_WORLD_EVENT] }
        AddCheckAllAndNoneInfo(resetSettings, level)

        local professionOrder = {
            "Jewelcrafting",
            "Enchanting",
            "Engineering",
            "Inscription",
            "Leatherworking",
            "Tailoring",
            "Archaeology",
            "Cooking",
            "Fishing",
        }
        AddOrderedFilterButtons(professionOrder, ADDON.db.profession, settings, resetSettings, level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_WORLD_EVENT) then
        local settings = ADDON.settings.filter[SETTING_WORLD_EVENT]
        local resetSettings = { settings, ADDON.settings.filter[SETTING_SOURCE], ADDON.settings.filter[SETTING_PROFESSION] }
        AddCheckAllAndNoneInfo(resetSettings, level)

        local eventOrder = {
            "Timewalking",
            "Darkmoon Faire",
            "Lunar Festival",
            "Love is in the Air",
            "Noblegarden",
            "Children's Week",
            "Midsummer Fire Festival",
            "Secrets of Azeroth",
            "Brewfest",
            "Hallow's End",
            "Day of the Dead",
            "Pilgrim's Bounty",
            "Pirates' Day",
            "Feast of Winter Veil",
        }
        AddOrderedFilterButtons(eventOrder, ADDON.db.worldEvent, settings, resetSettings, level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_FACTION) then
        local settings = ADDON.settings.filter[SETTING_FACTION]
        UIDropDownMenu_AddButton(CreateFilterInfo(FACTION_ALLIANCE, "alliance", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(FACTION_HORDE, "horde", settings), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(NPC_NAMES_DROPDOWN_NONE, "noFaction", settings), level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == SETTING_EXPANSION) then
        local settings = ADDON.settings.filter[SETTING_EXPANSION]
        AddCheckAllAndNoneInfo({ settings }, level)
        for i = GetExpansionLevel(), 0, -1 do
            if _G["EXPANSION_NAME" .. i] then
                UIDropDownMenu_AddButton(CreateFilterInfo(_G["EXPANSION_NAME" .. i], i, settings, settings), level)
            end
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
                UIDropDownMenu_AddButton(CreateFilterInfo(L[effect] or effect, effect, settings, settings), level)
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
            UIDropDownMenu_AddButton(CreateFilterInfo(L[effect] or effect, effect, settings, ADDON.settings.filter[SETTING_EFFECT]), level)
        end
    elseif UIDROPDOWNMENU_MENU_VALUE == SETTING_SORT then
        local settings = ADDON.settings[SETTING_SORT]
        local doSort = function()
            ADDON.DataProvider:Sort()
        end
        UIDropDownMenu_AddButton(CreateFilterRadio(NAME, "by", settings, 'name', doSort), level)
        UIDropDownMenu_AddButton(CreateFilterRadio(EXPANSION_FILTER_TEXT, "by", settings, 'expansion', doSort), level)
        UIDropDownMenu_AddSpace(level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L.SORT_REVERSE, 'descending', settings, nil, doSort), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L.SORT_FAVORITES_FIRST, 'favoritesFirst', settings, nil, doSort), level)
        UIDropDownMenu_AddButton(CreateFilterInfo(L.SORT_UNOWNED_AFTER, 'unownedAtLast', settings, nil, doSort), level)
        UIDropDownMenu_AddSpace(level)

        info = CreateFilterInfo(NEWBIE_TOOLTIP_STOPWATCH_RESETBUTTON)
        info.keepShownOnClick = false
        info.justifyH = "CENTER"
        info.func = function()
            ADDON:ResetSortSettings()
            doSort()
        end
        UIDropDownMenu_AddButton(info, level)
    end

    UIDropDownMenu_Refresh(frame, nil, level)
end

ADDON.Events:RegisterCallback("OnLoadUI", function()
    local menu
    local toggle = true
    DropDownList1:HookScript("OnHide", function()
        if not MouseIsOver(ToyBoxFilterButton) then
            toggle = true
        end
    end)

    local toggleFunc = function(sender)
        if not InCombatLockdown() then
            HideDropDownMenu(1)
            if toggle then
                if not menu then
                    menu = CreateFrame("Frame", ADDON_NAME .. "FilterMenu", ToyBox, "UIDropDownMenuTemplate")
                    UIDropDownMenu_Initialize(menu, InitializeDropDown, "MENU")
                end

                ToggleDropDownMenu(1, nil, menu, sender, 74, 15)
                toggle = false
            else
                toggle = true
            end
        end
    end
    if ToyBoxFilterButton.ResetButton then -- newer retail handling
        ToyBoxFilterButton:HookScript('OnMouseDown', toggleFunc)
    else -- older classic handling
        ToyBoxFilterButton:SetScript('OnClick', toggleFunc)
    end

    ToyBoxFilterButton.resetFunction = function()
        ADDON:ResetFilterSettings()
        ADDON:FilterToys()
        UpdateResetVisibility()
    end
    UpdateResetVisibility()

end, "filter-menu")
