local ADDON_NAME, ADDON = ...

local TOYS_PER_PAGE = 18

ADDON.filteredToyList = {}
ADDON.filterString = ""

-- region callbacks
local loginCallbacks, loadUICallbacks = {}, {}
function ADDON:RegisterLoginCallback(func)
    table.insert(loginCallbacks, func)
end
function ADDON:RegisterLoadUICallback(func)
    table.insert(loadUICallbacks, func)
end
local function FireCallbacks(callbacks)
    for _, callback in pairs(callbacks) do
        callback()
    end
end
--endregion

local org_GetNumFilteredToys
local function OverloadToyBox()
    org_GetNumFilteredToys = C_ToyBox.GetNumFilteredToys
    C_ToyBox.GetNumFilteredToys = function()
        return #ADDON.filteredToyList
    end
    local org_GetToyFromIndex = C_ToyBox.GetToyFromIndex
    C_ToyBox.GetToyFromIndex = function(index)
        if (index > #ADDON.filteredToyList) then
            return -1
        end

        return ADDON.filteredToyList[index]
    end
    C_ToyBox.ForceToyRefilter = function()
        return ADDON:FilterToys()
    end
    function ADDON:GetToyInfoOfOriginalIndex(index)
        return C_ToyBox.GetToyInfo(org_GetToyFromIndex(index))
    end
end

-- region initialize UI
function ADDON:LoadUI()
    OverloadToyBox()
    PetJournal:HookScript("OnShow", function() if (not PetJournalPetCard.petID) then PetJournal_ShowPetCard(1) end end)

    ToyBox.searchBox:SetScript("OnTextChanged", function(sender) self:ToyBox_OnSearchTextChanged(sender) end)

    hooksecurefunc("ToySpellButton_UpdateButton", function(sender) self:ToySpellButton_UpdateButton(sender) end)

    self:ReplaceSpellButtons()
    self:FilterAndRefresh()

    FireCallbacks(loadUICallbacks)
end

function ADDON:ReplaceSpellButtons()
    for i = 1, TOYS_PER_PAGE do
        local oldToyButton = ToyBox.iconsFrame["spellButton" .. i]
        oldToyButton:SetParent(nil)
        oldToyButton:SetShown(false)

        local newToyButton = CreateFrame("CheckButton", nil, ToyBox.iconsFrame, "ToyBoxEnhancedSpellButtonTemplate", i)
        newToyButton:HookScript("OnClick", function(sender, button)
            if (IsModifiedClick()) then
                ToySpellButton_OnModifiedClick(sender, button)
            end
        end)
        newToyButton:SetScript("OnShow", ToySpellButton_OnShow)
        newToyButton:SetScript("OnEnter", function(sender)
            ToySpellButton_OnEnter(sender)
            if (not InCombatLockdown()) then
                sender:SetAttribute("type1", "toy")
                sender:SetAttribute("toy", sender.itemID)
                sender:SetAttribute("shift-action1", ATTRIBUTE_NOOP)
            end
        end)
        newToyButton:SetScript("OnLeave", function(sender)
            if (not InCombatLockdown()) then
                sender:SetAttribute("type1", nil)
                sender:SetAttribute("toy", nil)
                sender:SetAttribute("shift-action1", ATTRIBUTE_NOOP)
            end

            GameTooltip_Hide() end)
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

-- endregion

function ADDON:FilterAndRefresh()
    self:FilterToys()
    ToyBox_UpdatePages()
    ToyBox_UpdateButtons()
end

function ADDON:ToyBox_OnSearchTextChanged(sender)
    SearchBoxTemplate_OnTextChanged(sender)

    local oldText = self.filterString
    self.filterString = string.lower(sender:GetText())

    if (oldText ~= self.filterString) then
        ToyBox.firstCollectedToyID = 0
        self:FilterAndRefresh()
    end
end

function ADDON:ToySpellButton_UpdateButton(sender)

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

function ADDON:FilterToys()
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
        local itemId, name, icon, favorited = ADDON:GetToyInfoOfOriginalIndex(toyIndex)
        local collected = PlayerHasToy(itemId)

        if ((doNameFilter and self:FilterToysByName(name))
                or (not doNameFilter
                and self:FilterHiddenToys(itemId)
                and self:FilterCollectedToys(collected)
                and self:FilterFavoriteToys(favorited)
                and self:FilterUsableToys(itemId)
                and self:FilterToysByFaction(itemId)
                and self:FilterToysByExpansion(itemId)
                and (self:FilterToysBySource(itemId)
                or self:FilterToysByProfession(itemId)
                or self:FilterToysByWorldEvent(itemId)))) then
            table.insert(self.filteredToyList, itemId)
        end
    end
end

function ADDON:FilterToysByName(name)
    if (string.find(string.lower(name), self.filterString, 1, true)) then
        return true
    else
        return false
    end
end

function ADDON:FilterHiddenToys(itemId)
    return self.settings.filter.hidden or not self.settings.hiddenToys[itemId]
end

function ADDON:FilterCollectedToys(collected)
    return (self.settings.filter.collected and collected) or (self.settings.filter.notCollected and not collected)
end

function ADDON:FilterFavoriteToys(isFavorite)
    return not self.settings.filter.onlyFavorites or isFavorite or not self.settings.filter.collected
end

function ADDON:FilterUsableToys(itemId)
    return not self.settings.filter.onlyUsable or C_ToyBox.IsToyUsable(itemId)
end

function ADDON:CheckAllSettings(settings)
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

function ADDON:CheckItemInList(settings, sourceData, itemId)
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

function ADDON:FilterToysByFaction(itemId)

    local allSettings = self:CheckAllSettings(self.settings.filter.faction)
    if allSettings then
        return true
    end

    local settingResult = self:CheckItemInList(self.settings.filter.faction, ADDON.ToyBoxEnhancedFaction, itemId)
    if settingResult ~= nil then
        return settingResult
    end

    return self.settings.filter.faction.noFaction
end

function ADDON:FilterToysBySource(itemId)
    if self:CheckAllSettings(self.settings.filter.source) then
        return true
    end

    return self:CheckItemInList(self.settings.filter.source, ADDON.ToyBoxEnhancedSource, itemId)
end

function ADDON:FilterToysByProfession(itemId)
    return self:CheckItemInList(self.settings.filter.profession, ADDON.ToyBoxEnhancedProfession, itemId)
end

function ADDON:FilterToysByWorldEvent(itemId)
    return self:CheckItemInList(self.settings.filter.worldEvent, ADDON.ToyBoxEnhancedWorldEvent, itemId)
end

function ADDON:FilterToysByExpansion(itemId)

    local settingsResult = self:CheckAllSettings(self.settings.filter.expansion)
    if settingsResult then
        return true
    end

    local settingResult = self:CheckItemInList(self.settings.filter.expansion, ADDON.ToyBoxEnhancedExpansion, itemId)
    if settingResult ~= nil then
        return settingResult
    end

    for expansion, value in pairs(self.settings.filter.expansion) do
        if ADDON.ToyBoxEnhancedExpansion[expansion] and
                ADDON.ToyBoxEnhancedExpansion[expansion]["minID"] <= itemId and
                itemId <= ADDON.ToyBoxEnhancedExpansion[expansion]["maxID"] then
            return value
        end
    end

    return false
end

-- endregion

function ADDON:GetUsableToysCount()
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
        local itemId = ADDON:GetToyInfoOfOriginalIndex(toyIndex)
        if (PlayerHasToy(itemId) and C_ToyBox.IsToyUsable(itemId)) then
            usableCount = usableCount + 1
        end
    end

    return usableCount
end

function ADDON:OnLogin()
    FireCallbacks(loginCallbacks)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("TOYS_UPDATED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:SetScript("OnEvent", function(self, event, arg1)
    local doInit = false
    if event == "PLAYER_LOGIN" then
        ADDON:OnLogin()
        if ToyBox then
            doInit = true
        end
    elseif event == "ADDON_LOADED" and arg1 == "Blizzard_Collections" then
        if not ADDON.initialized and ADDON.settings then
            doInit = true
        end
    elseif ADDON.initialized and (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED") then
        if (ToyBox:IsVisible()) then
            self:FilterAndRefresh()
        end
    end

    if doInit then
        frame:UnregisterEvent("ADDON_LOADED")
        ADDON:LoadUI()
        ADDON.initialized = true
    end
end)