local ADDON_NAME, ADDON = ...

ADDON.TOYS_PER_PAGE = 18
ADDON.filteredToyList = {}

--region callbacks
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

local function LoadUI()
    PetJournal:HookScript("OnShow", function() if (not PetJournalPetCard.petID) then PetJournal_ShowPetCard(1) end end)

    FireCallbacks(loadUICallbacks)
    ADDON:FilterAndRefresh()
end

function ADDON:FilterAndRefresh()
    if not InCombatLockdown() then
        self:FilterToys()
        ToyBox_UpdatePages()
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

local function ResetAPIFilters()
    C_ToyBox.SetAllSourceTypeFilters(true)
    C_ToyBox.SetAllExpansionTypeFilters(true)
    C_ToyBox.SetCollectedShown(true)
    C_ToyBox.SetUncollectedShown(true)
    C_ToyBox.SetUnusableShown(true)
    C_ToyBox.SetFilterString("")
end

function ADDON:FilterToys()
    local searchIsActive = SearchIsActive()

    local toyCount = C_ToyBox.GetNumTotalDisplayedToys()
    if (not searchIsActive and C_ToyBox.GetNumFilteredToys() ~= toyCount) then
        ResetAPIFilters()
    end

    local filteredToyList = {}

    for toyIndex = 1, C_ToyBox.GetNumFilteredToys() do
        local itemId = C_ToyBox.GetToyFromIndex(toyIndex)

        if (searchIsActive or ADDON:FilterToy(itemId)) then
            table.insert(filteredToyList, itemId)
        end
    end
    self.filteredToyList = filteredToyList
end

local function OnLogin()
    ResetAPIFilters()

    for toyIndex = 1, C_ToyBox.GetNumFilteredToys() do
        local itemId = C_ToyBox.GetToyFromIndex(toyIndex)
        if itemId then
            tinsert(ADDON.db.ingameList, itemId)
        end
    end

    FireCallbacks(loginCallbacks)
end

local loggedIn = false
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("TOYS_UPDATED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_LOGIN" and false == loggedIn then
        loggedIn = true
        OnLogin()
    end

    if ToyBox and not ADDON.initialized and ADDON.settings then
        if false == loggedIn then
            loggedIn = true
            frame:UnregisterEvent("PLAYER_LOGIN")
            OnLogin()
        end
        frame:UnregisterEvent("ADDON_LOADED")
        LoadUI()
        ADDON.initialized = true
    elseif ADDON.initialized and ToyBox:IsVisible() and (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED") then
        ADDON:FilterAndRefresh()
    end
end)