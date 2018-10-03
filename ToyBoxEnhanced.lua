local ADDON_NAME, ADDON = ...

ADDON.TOYS_PER_PAGE = 18
ADDON.filteredToyList = {}
ADDON.inCombat = InCombatLockdown()

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

function ADDON:ResetAPIFilters()
    C_ToyBox.SetAllSourceTypeFilters(true)
    C_ToyBox.SetAllExpansionTypeFilters(true)
    C_ToyBox.SetFilterString("")
    C_ToyBox.SetCollectedShown(true)
    C_ToyBox.SetUncollectedShown(true)
    C_ToyBox.SetUnusableShown(true)
end

function ADDON:LoadUI()
    self:ResetAPIFilters()

    PetJournal:HookScript("OnShow", function() if (not PetJournalPetCard.petID) then PetJournal_ShowPetCard(1) end end)

    FireCallbacks(loadUICallbacks)
    self:FilterAndRefresh()
end

function ADDON:FilterAndRefresh()
    self:FilterToys()
    ToyBox_UpdatePages()
    if not ADDON.inCombat then
        ToyBox_UpdateButtons()
    end
end

local function SearchIsActive()
    local searchString = ToyBox.searchString
    if (not searchString or string.len(searchString) == 0) then
        return false
    end

    return true
end

function ADDON:FilterToys()
    local searchIsActive = SearchIsActive()

    local toyCount = C_ToyBox.GetNumTotalDisplayedToys()
    if (not searchIsActive and C_ToyBox.GetNumFilteredToys() ~= toyCount) then
        self:ResetAPIFilters()
    end

    self.filteredToyList = {}

    for toyIndex = 1, C_ToyBox.GetNumFilteredToys() do
        local itemId = C_ToyBox.GetToyFromIndex(toyIndex)

        if (searchIsActive or ADDON:FilterToy(itemId)) then
            table.insert(self.filteredToyList, itemId)
        end
    end
end

function ADDON:OnLogin()
    self:ResetAPIFilters()
    FireCallbacks(loginCallbacks)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("TOYS_UPDATED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_LOGIN" then
        ADDON:OnLogin()
    elseif event == "PLAYER_REGEN_DISABLED" then
        ADDON.inCombat = true
    elseif event == "PLAYER_REGEN_ENABLED" then
        ADDON.inCombat = false
    end

    if ToyBox and not ADDON.initialized and ADDON.settings then
        frame:UnregisterEvent("ADDON_LOADED")
        ADDON:LoadUI()
        ADDON.initialized = true
    elseif ADDON.initialized and ToyBox:IsVisible() and (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED") then
        ADDON:FilterAndRefresh()
    end
end)