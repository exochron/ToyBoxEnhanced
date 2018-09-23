local ADDON_NAME, ADDON = ...

ADDON.TOYS_PER_PAGE = 18
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

function ADDON:LoadUI()
    PetJournal:HookScript("OnShow", function() if (not PetJournalPetCard.petID) then PetJournal_ShowPetCard(1) end end)

    --    ToyBox.searchBox:SetScript("OnTextChanged", function(sender) self:ToyBox_OnSearchTextChanged(sender) end)

    hooksecurefunc("ToyBox_UpdatePages", function()
        local maxPages = 1 + math.floor( math.max((#ADDON.filteredToyList - 1), 0) / ADDON.TOYS_PER_PAGE);
        ToyBox.PagingFrame:SetMaxPages(maxPages)
    end)

    FireCallbacks(loadUICallbacks)
    self:FilterAndRefresh()
end

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

function ADDON:FilterToys()
    local toyCount = C_ToyBox.GetNumTotalDisplayedToys()
    if (C_ToyBox.GetNumFilteredToys() ~= toyCount) then
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
        local itemId, name, icon, favorited = C_ToyBox.GetToyInfo(C_ToyBox.GetToyFromIndex(toyIndex))

        if ((doNameFilter and self:FilterToysByName(name))
                or (not doNameFilter and ADDON:FilterToy(toyIndex))) then
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
    if event == "PLAYER_LOGIN" then
        ADDON:OnLogin()
    end

    if ToyBox and not ADDON.initialized and ADDON.settings and not InCombatLockdown() then
        frame:UnregisterEvent("ADDON_LOADED")
        ADDON:LoadUI()
        ADDON.initialized = true
    end

    if ADDON.initialized and ToyBox:IsVisible() and (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED") then
        ADDON:FilterAndRefresh()
    end
end)