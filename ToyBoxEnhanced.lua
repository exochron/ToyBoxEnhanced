local ADDON_NAME = ...

local TOYS_PER_PAGE = 18
local COLLECTION_ACHIEVEMENT_CATEGORY = 15246
local TOY_ACHIEVEMENT_CATEGORY = 15247

local DropDownOrderSource = { "Profession", "World Event", "Treasure", "Drop", "Quest", "Vendor", "Instance", "Reputation", "Achievement", "PvP", "Garrison", "Order Hall", "Pick Pocket", "Black Market", "Promotion" }
local DropDownOrderProfessions = { "Jewelcrafting", "Enchanting", "Engineering", "Inscription", "Leatherworking", "Archaeology", "Cooking", "Fishing" }
local DropDownOrderWorldEvents = { "Timewalking", "Darkmoon Faire", "Lunar Festival", "Love is in the Air", "Children's Week", "Midsummer Fire Festival", "Brewfest", "Hallow's End", "Day of the Dead", "Pilgrim's Bounty", "Pirates' Day", "Feast of Winter Veil" }
local DropDownOrderExpansions = { "Classic", "The Burning Crusade", "Wrath of the Lich King", "Cataclysm", "Mists of Pandaria", "Warlords of Draenor", "Legion" }

local L = CoreFramework:GetModule("Localization", "1.1"):GetLocalization(ADDON_NAME)

local initialState = {
    settings = {
        debugMode = false,
        hiddenToys = { },
        filter = {
            collected = true,
            notCollected = true,
            onlyFavorites = false,
            onlyUsable = false,
            source = { },
            faction = {
                alliance = true,
                horde = true,
                noFaction = true,
            },
            profession = { },
            worldEvent = { },
            expansion = { },
            hidden = false,
        },
    },
}
for name, _ in pairs(ToyBoxEnhancedSource) do
    initialState.settings.filter.source[name] = true
end
for name, _ in pairs(ToyBoxEnhancedProfession) do
    initialState.settings.filter.profession[name] = true
end
for name, _ in pairs(ToyBoxEnhancedWorldEvent) do
    initialState.settings.filter.worldEvent[name] = true
end
for name, _ in pairs(ToyBoxEnhancedExpansion) do
    initialState.settings.filter.expansion[name] = true
end
local defaultFilterStates = CopyTable(initialState.settings.filter)
local dependencies = {
    function() return ToyBox or LoadAddOn("Blizzard_Collections") end,
}
local private = CoreFramework:GetModule("Addon", "1.0"):NewAddon(ADDON_NAME, initialState, dependencies)

private.filteredToyList = { }
private.filterString = ""

-- region overload some core functions
local org_GetNumFilteredToys = C_ToyBox.GetNumFilteredToys
C_ToyBox.GetNumFilteredToys = function()
    return #private.filteredToyList
end
local org_GetToyFromIndex = C_ToyBox.GetToyFromIndex
C_ToyBox.GetToyFromIndex = function(index)
    if (index > #private.filteredToyList) then
        return -1
    end

    return private.filteredToyList[index]
end
C_ToyBox.ForceToyRefilter = function()
    return private:FilterToys()
end
-- endregion

-- region initialize UI
function private:LoadUI()
    PetJournal:HookScript("OnShow", function() if (not PetJournalPetCard.petID) then PetJournal_ShowPetCard(1) end end)

    ToyBox.searchBox:SetScript("OnTextChanged", function(sender) self:ToyBox_OnSearchTextChanged(sender) end)

    hooksecurefunc(ToyBox.toyOptionsMenu, "initialize", function(sender, level) UIDropDownMenu_InitializeHelper(sender) self:ToyBoxOptionsMenu_Init(sender, level) end)
    hooksecurefunc(ToyBoxFilterDropDown, "initialize", function(sender, level) UIDropDownMenu_InitializeHelper(sender) self:ToyBoxFilterDropDown_Initialize(sender, level) end)
    hooksecurefunc("ToySpellButton_UpdateButton", function(sender) self:ToySpellButton_UpdateButton(sender) end)

    self:ReplaceSpellButtons()
    self:CreateUIElements()
    self:FilterAndRefresh()
end

function private:ReplaceSpellButtons()
    for i = 1, TOYS_PER_PAGE do
        local oldToyButton = ToyBox.iconsFrame["spellButton" .. i]
        oldToyButton:SetParent(nil)
        oldToyButton:SetShown(false)

        local newToyButton = CreateFrame("CheckButton", nil, ToyBox.iconsFrame, "ToyBoxEnhancedSpellButtonTemplate", i)
        newToyButton:HookScript("OnClick", function(sender, button) self:ToySpellButton_OnClick(sender, button) end)
        newToyButton:SetScript("OnShow", ToySpellButton_OnShow)
        newToyButton:SetScript("OnEnter", function(sender)
            ToySpellButton_OnEnter(sender)
            self:ToySpellButton_OnEnter(sender)
        end)
        newToyButton:SetScript("OnLeave", function(sender) self:ToySpellButton_OnLeave(sender) end)
        newToyButton.updateFunction = ToySpellButton_UpdateButton

        ToyBox.iconsFrame["spellButton" .. i] = newToyButton
    end

    local positions = {
        { "TOPLEFT", ToyBox.iconsFrame, "TOPLEFT", 40, -46 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton1, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton2, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton1, "BOTTOMLEFT", 0, -16 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton4, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton5, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton4, "BOTTOMLEFT", 0, -16 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton7, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton8, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton7, "BOTTOMLEFT", 0, -16 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton10, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton11, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton10, "BOTTOMLEFT", 0, -16 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton13, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton14, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton13, "BOTTOMLEFT", 0, -16 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton16, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton17, "TOPLEFT", 208, 0 },
    }
    for i = 1, TOYS_PER_PAGE do
        ToyBox.iconsFrame["spellButton" .. i]:SetPoint(positions[i][1], positions[i][2], positions[i][3], positions[i][4], positions[i][5])
    end
end

function private:CreateUIElements()
    self.toyCountFrame = CreateFrame("Frame", nil, ToyBox, "TBEToyCountTemplate")
    self.toyCountFrame.staticText:SetText(L["Toys"])

    self.usableToyCountFrame = CreateFrame("Frame", nil, ToyBox, "TBEToyUsableCountTemplate")
    self.usableToyCountFrame.staticText:SetText(L["Usable"])

    ToyBox.progressBar:SetShown(false)

    local frame = CreateFrame("Button", nil, ToyBox, "TBEAchievementButtonTemplate")
    frame.staticText:SetText(GetCategoryAchievementPoints(TOY_ACHIEVEMENT_CATEGORY, true))
    frame:SetScript("OnClick", function()
        ToggleAchievementFrame()

        local clickChain = {COLLECTION_ACHIEVEMENT_CATEGORY, TOY_ACHIEVEMENT_CATEGORY }
        for _,achievementId in pairs(clickChain) do
            local i = 1
            local button = _G["AchievementFrameCategoriesContainerButton" .. i]
            while button do
                if (button.element.id == achievementId) then
                    button:Click()
                    break
                else
                    i = i + 1
                    button = _G["AchievementFrameCategoriesContainerButton" .. i]
                end
            end
        end
    end)
    frame:SetScript("OnEnter", function(sender) sender.highlight:SetShown(true) end)
    frame:SetScript("OnLeave", function(sender) sender.highlight:SetShown(false) end)
    self.achievementFrame = frame
end
-- endregion

function private:FilterAndRefresh()
    self:FilterToys()
    ToyBox_UpdatePages()
    ToyBox_UpdateButtons()
end

function private:LoadDebugMode()
    if (self.settings.debugMode) then
        print("ToyBoxEnhanced: Debug mode activated")

        local toyCount = C_ToyBox.GetNumTotalDisplayedToys()
        for toyIndex = 1, toyCount do
            local itemId = C_ToyBox.GetToyInfo(org_GetToyFromIndex(toyIndex))
            if (not self:ContainsItem(ToyBoxEnhancedSource, itemId)
                and not self:ContainsItem(ToyBoxEnhancedProfession, itemId)
                and not self:ContainsItem(ToyBoxEnhancedWorldEvent, itemId)
            ) then
                print("New toy (by Source): " .. itemId)
            end
        end

        for _, source in pairs(ToyBoxEnhancedSource) do
            for itemId, _ in pairs(source) do
                if (not C_ToyBox.GetToyInfo(itemId)) then
                    print("Old toy (by Source): " .. itemId)
                end
            end
        end
    end
end

function private:ContainsItem(data, itemId)
    for _, category in pairs(data) do
        if (category[itemId]) then
            return true
        end
    end

    return false
end

function private:ToyBox_OnSearchTextChanged(sender)
    SearchBoxTemplate_OnTextChanged(sender)

    local oldText = self.filterString
    self.filterString = string.lower(sender:GetText())

    if (oldText ~= self.filterString) then
        ToyBox.firstCollectedToyID = 0
        self:FilterAndRefresh()
    end
end

-- region dropdown menus

function private:ToyBoxOptionsMenu_Init(sender, level)
    local info = UIDropDownMenu_CreateInfo()
    info.notCheckable = true
    info.disabled = nil

    if (ToyBox.menuItemID and PlayerHasToy(ToyBox.menuItemID)) then
        local isFavorite = ToyBox.menuItemID and C_ToyBox.GetIsFavorite(ToyBox.menuItemID)

        if (isFavorite) then
            info.text = BATTLE_PET_UNFAVORITE
            info.func = function()
                C_ToyBox.SetIsFavorite(ToyBox.menuItemID, false)
                self:FilterAndRefresh()
            end
        else
            info.text = BATTLE_PET_FAVORITE
            info.func = function()
                C_ToyBox.SetIsFavorite(ToyBox.menuItemID, true)
                SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE, true)
                ToyBox.favoriteHelpBox:Hide()
                self:FilterAndRefresh()
            end
        end

        UIDropDownMenu_AddButton(info, level)
        info.disabled = nil
    end

    local itemId = ToyBox.menuItemID
    local isHidden = itemId and self.settings.hiddenToys[itemId]
    if (isHidden) then
        info.text = L["Show"]
        info.func = function()
            self.settings.hiddenToys[itemId] = nil
            self:FilterAndRefresh()
        end
    else
        info.text = L["Hide"]
        info.func = function()
            self.settings.hiddenToys[itemId] = true
            self:FilterAndRefresh()
        end
    end

    UIDropDownMenu_AddButton(info, level)
    info.disabled = nil

    info.text = CANCEL
    info.func = nil
    UIDropDownMenu_AddButton(info, level)
end

function private:CreateFilterInfo(text, filterKey, subfilterKey, callback)
    local info = UIDropDownMenu_CreateInfo()
    info.keepShownOnClick = true
    info.isNotRadio = true
    info.text = text

    if filterKey then
        info.hasArrow = false
        info.notCheckable = false
        if subfilterKey then
            info.checked = function() return self.settings.filter[filterKey][subfilterKey] end
        else
            info.checked = self.settings.filter[filterKey]
        end
        info.func = function(_, _, _, value)
            ToyBox.firstCollectedToyID = 0
            if subfilterKey then
                self.settings.filter[filterKey][subfilterKey] = value
            else
                self.settings.filter[filterKey] = value
            end
            self:FilterAndRefresh()

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

function private:AddCheckAllAndNoneInfo(filterKeys, level, dropdownLevel)
    local info = self:CreateFilterInfo(CHECK_ALL)
    info.hasArrow = false
    info.func = function()
        for _, filterKey in pairs(filterKeys) do
            for key, _ in pairs(self.settings.filter[filterKey]) do
                self.settings.filter[filterKey][key] = true
            end
        end

        UIDropDownMenu_Refresh(ToyBoxFilterDropDown, dropdownLevel, level)
        self:FilterAndRefresh()
    end
    UIDropDownMenu_AddButton(info, level)

    info = self:CreateFilterInfo(UNCHECK_ALL)
    info.hasArrow = false
    info.func = function()
        for _, filterKey in pairs(filterKeys) do
            for key, _ in pairs(self.settings.filter[filterKey]) do
                self.settings.filter[filterKey][key] = false
            end
        end

        UIDropDownMenu_Refresh(ToyBoxFilterDropDown, dropdownLevel, level)
        self:FilterAndRefresh()
    end
    UIDropDownMenu_AddButton(info, level)
end

function private:ToyBoxFilterDropDown_Initialize(sender, level)
    local info = UIDropDownMenu_CreateInfo()
    info.keepShownOnClick = true

    if level == 1 then
        info = self:CreateFilterInfo(COLLECTED, "collected", nil, function(value)
            if (value) then
                UIDropDownMenu_EnableButton(1, 2)
            else
                UIDropDownMenu_DisableButton(1, 2)
            end
        end)
        UIDropDownMenu_AddButton(info, level)

        info = self:CreateFilterInfo(FAVORITES_FILTER, "onlyFavorites")
        info.leftPadding = 16
        info.disabled = not self.settings.filter.collected
        UIDropDownMenu_AddButton(info, level)

        info = self:CreateFilterInfo(NOT_COLLECTED, "notCollected")
        UIDropDownMenu_AddButton(info, level)

        info = self:CreateFilterInfo(L["Only usable"], "onlyUsable")
        UIDropDownMenu_AddButton(info, level)

        info = self:CreateFilterInfo(SOURCES)
        info.value = 1
        UIDropDownMenu_AddButton(info, level)

        info = self:CreateFilterInfo(FACTION)
        info.value = 2
        UIDropDownMenu_AddButton(info, level)

        info = self:CreateFilterInfo(L["Expansion"])
        info.value = 5
        UIDropDownMenu_AddButton(info, level)

        info = self:CreateFilterInfo(L["Hidden"], "hidden")
        UIDropDownMenu_AddButton(info, level)

        info = self:CreateFilterInfo(L["Reset filters"])
        info.keepShownOnClick = false
        info.hasArrow = false
        info.func = function(_, _, _, value)
            ToyBox.firstCollectedToyID = 0
            self.settings.filter = CopyTable(defaultFilterStates)
            self:FilterAndRefresh()
        end
        UIDropDownMenu_AddButton(info, level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == 1) then
        self:AddCheckAllAndNoneInfo({ "source", "profession", "worldEvent" }, level, 1)
        for _, sourceName in pairs(DropDownOrderSource) do
            if sourceName == "Profession" then
                info = self:CreateFilterInfo(L[sourceName])
                info.value = 3
            elseif sourceName == "World Event" then
                info = self:CreateFilterInfo(L[sourceName])
                info.value = 4
            else
                info = self:CreateFilterInfo(L[sourceName], "source", sourceName)
            end
            UIDropDownMenu_AddButton(info, level)
        end

    elseif (UIDROPDOWNMENU_MENU_VALUE == 2) then
        info = self:CreateFilterInfo(FACTION_ALLIANCE, "faction", "alliance")
        UIDropDownMenu_AddButton(info, level)
        info = self:CreateFilterInfo(FACTION_HORDE, "faction", "horde")
        UIDropDownMenu_AddButton(info, level)
        info = self:CreateFilterInfo(NPC_NAMES_DROPDOWN_NONE, "faction", "noFaction")
        UIDropDownMenu_AddButton(info, level)

    elseif (UIDROPDOWNMENU_MENU_VALUE == 3) then
        self:AddCheckAllAndNoneInfo({ "profession" }, level, 3)
        for _, professionName in pairs(DropDownOrderProfessions) do
            info = self:CreateFilterInfo(L[professionName], "profession", professionName)
            UIDropDownMenu_AddButton(info, level)
        end

    elseif (UIDROPDOWNMENU_MENU_VALUE == 4) then
        self:AddCheckAllAndNoneInfo({ "worldEvent" }, level, 4)
        for _, eventName in pairs(DropDownOrderWorldEvents) do
            info = self:CreateFilterInfo(L[eventName], "worldEvent", eventName)
            UIDropDownMenu_AddButton(info, level)
        end

    elseif (UIDROPDOWNMENU_MENU_VALUE == 5) then
        self:AddCheckAllAndNoneInfo({ "expansion" }, level, 5)
        for _, expansion in pairs(DropDownOrderExpansions) do
            info = self:CreateFilterInfo(L[expansion], "expansion", expansion)
            UIDropDownMenu_AddButton(info, level)
        end
    end
end

-- endregion

function private:ToySpellButton_OnClick(sender, button)
    if (IsModifiedClick()) then
        ToySpellButton_OnModifiedClick(sender, button)
    elseif (not sender.isPassive and button ~= "LeftButton") then
        ToyBox_ShowToyDropdown(sender.itemID, sender, 0, 0)
    end
end

function private:ToySpellButton_OnEnter(sender)
    if (not InCombatLockdown()) then
        sender:SetAttribute("type1", "toy")
        sender:SetAttribute("toy", sender.itemID)
        sender:SetAttribute("shift-action1", ATTRIBUTE_NOOP)
    end
end

function private:ToySpellButton_OnLeave(sender)
    if (not InCombatLockdown()) then
        sender:SetAttribute("type1", nil)
        sender:SetAttribute("toy", nil)
        sender:SetAttribute("shift-action1", ATTRIBUTE_NOOP)
    end

    GameTooltip_Hide()
end

function private:ToySpellButton_UpdateButton(sender)

    if (sender.itemID == -1) then
        return
    end

    local itemID, toyName, icon = C_ToyBox.GetToyInfo(sender.itemID)
    if (itemID == nil or toyName == nil) then
        return
    end

    sender.slotFrameUncollectedInnerGlow:SetAlpha(0.18)
    sender.iconTextureUncollected:SetAlpha(0.18)

    sender.IsHidden:SetShown(self.settings.hiddenToys[itemID])

    local alpha = 1.0
    if (PlayerHasToy(sender.itemID) and (InCombatLockdown() or not C_ToyBox.IsToyUsable(itemID))) then
        alpha = 0.25
    end

    sender.name:SetAlpha(alpha)
    sender.iconTexture:SetAlpha(alpha)
    sender.slotFrameCollected:SetAlpha(alpha)
end

-- region filter functions

function private:FilterToys()
    local toyCount = C_ToyBox.GetNumTotalDisplayedToys()
    if (org_GetNumFilteredToys() ~= toyCount) then
        C_ToyBox.SetAllSourceTypeFilters(true)
        C_ToyBox.SetFilterString("")
        C_ToyBox.SetCollectedShown(true)
        C_ToyBox.SetUncollectedShown(true)
    end

    self.filteredToyList = {}

    local doNameFilter = false
    if (self.filterString and string.len(self.filterString) > 0) then
        doNameFilter = true
    end

    for toyIndex = 1, toyCount do
        local itemId, name, icon, favorited = C_ToyBox.GetToyInfo(org_GetToyFromIndex(toyIndex))
        local collected = PlayerHasToy(itemId)

        if ((doNameFilter and self:FilterToysByName(name))
            or (not doNameFilter
                and self:FilterHiddenToys(itemId)
                and self:FilterCollectedToys(collected)
                and self:FilterFavoriteToys(favorited)
                and self:FilterUsableToys(itemId)
                and self:FilterToysByFaction(itemId)
                and self:FilterToysByExpansion(itemId)
                and ( self:FilterToysBySource(itemId)
                    or self:FilterToysByProfession(itemId)
                    or self:FilterToysByWorldEvent(itemId)
        ))) then
            table.insert(self.filteredToyList, itemId)
        end
    end

    if (self.toyCountFrame) then
        self.toyCountFrame.uniqueCount:SetText(C_ToyBox.GetNumLearnedDisplayedToys())
    end

    if (self.usableToyCountFrame) then
        self.usableToyCountFrame.uniqueCount:SetText(self:GetUsableToysCount())
    end
end

function private:FilterToysByName(name)
    if (string.find(string.lower(name), self.filterString, 1, true)) then
        return true
    else
        return false
    end
end

function private:FilterHiddenToys(itemId)
    return self.settings.filter.hidden or not self.settings.hiddenToys[itemId]
end

function private:FilterCollectedToys(collected)
    return (self.settings.filter.collected and collected) or (self.settings.filter.notCollected and not collected)
end

function private:FilterFavoriteToys(isFavorite)
    return not self.settings.filter.onlyFavorites or isFavorite or not self.settings.filter.collected
end

function private:FilterUsableToys(itemId)
    return not self.settings.filter.onlyUsable or C_ToyBox.IsToyUsable(itemId)
end

function private:CheckAllSettings(settings)
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

function private:CheckItemInList(settings, sourceData, itemId)
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

function private:FilterToysByFaction(itemId)

    local allSettings = self:CheckAllSettings(self.settings.filter.faction)
    if allSettings then
        return true
    end

    local settingResult = self:CheckItemInList(self.settings.filter.faction, ToyBoxEnhancedFaction, itemId)
    if settingResult ~= nil then
        return settingResult
    end

    return self.settings.filter.faction.noFaction
end

function private:FilterToysBySource(itemId)
    if self:CheckAllSettings(self.settings.filter.source) then
        return true
    end

    return self:CheckItemInList(self.settings.filter.source, ToyBoxEnhancedSource, itemId)
end

function private:FilterToysByProfession(itemId)
    return self:CheckItemInList(self.settings.filter.profession, ToyBoxEnhancedProfession, itemId)
end

function private:FilterToysByWorldEvent(itemId)
    return self:CheckItemInList(self.settings.filter.worldEvent, ToyBoxEnhancedWorldEvent, itemId)
end

function private:FilterToysByExpansion(itemId)

    local settingsResult = self:CheckAllSettings(self.settings.filter.expansion)
    if settingsResult then
        return true
    end

    local settingResult = self:CheckItemInList(self.settings.filter.expansion, ToyBoxEnhancedExpansion, itemId)
    if settingResult ~= nil then
        return settingResult
    end

    for expansion, value in pairs(self.settings.filter.expansion) do
        if ToyBoxEnhancedExpansion[expansion] and
                ToyBoxEnhancedExpansion[expansion]["minID"] <= itemId and
                itemId <= ToyBoxEnhancedExpansion[expansion]["maxID"]
        then
            return value
        end
    end

    return false
end

-- endregion

function private:GetUsableToysCount()
    local toyCount = C_ToyBox.GetNumTotalDisplayedToys()
    if (org_GetNumFilteredToys() ~= toyCount) then
        C_ToyBox.SetAllSourceTypeFilters(true)
        C_ToyBox.SetFilterString("")
        C_ToyBox.SetCollectedShown(true)
        C_ToyBox.SetUncollectedShown(true)
    end

    local usableCount = 0

    local toyCount = C_ToyBox.GetNumTotalDisplayedToys()
    for toyIndex = 1, toyCount do
        local itemId = C_ToyBox.GetToyInfo(org_GetToyFromIndex(toyIndex))
        if (PlayerHasToy(itemId) and C_ToyBox.IsToyUsable(itemId)) then
            usableCount = usableCount + 1
        end
    end

    return usableCount
end

function private:Load()
    self:LoadUI()
    self:LoadDebugMode()

    self:AddEventHandler("TOYS_UPDATED", function(...) self:OnToysUpdated(...) end)
    self:AddEventHandler("ACHIEVEMENT_EARNED", function() self:OnAchievement() end)
    self:AddEventHandler("PLAYER_REGEN_ENABLED", function() self:OnCombatStateChanged() end)
    self:AddEventHandler("PLAYER_REGEN_DISABLED", function() self:OnCombatStateChanged() end)

    self:AddSlashCommand("TOYBOXENHANCED", function(...) self:OnSlashCommand(...) end, 'toyboxenhanced', 'tbe')
end

function private:OnToysUpdated(event, ...)
    local itemID, new = ...

    if (ToyBox:IsVisible()) then
        self:FilterAndRefresh()
    end
end

function private:OnAchievement()
    self.achievementFrame.staticText:SetText(GetCategoryAchievementPoints(TOY_ACHIEVEMENT_CATEGORY, true))
end

function private:OnCombatStateChanged()
    if (ToyBox:IsVisible()) then
        self:FilterAndRefresh()
    end
end

function private:OnSlashCommand(command, parameter1, parameter2)
    if (command == "debug") then
        if (parameter1 == "on") then
            self.settings.debugMode = true
            print("ToyBoxEnhanced: Debug mode activated.")
        elseif (parameter1 == "off") then
            self.settings.debugMode = false
            print("ToyBoxEnhanced: Debug mode deactivated.")
        end
    else
        print("Syntax:")
        print("/tbe debug (on | off)")
    end
end