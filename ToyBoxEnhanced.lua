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

local function ResetAPIFilters()
    C_ToyBox.SetAllSourceTypeFilters(true)
    C_ToyBox.SetAllExpansionTypeFilters(true)
    C_ToyBox.SetCollectedShown(true)
    C_ToyBox.SetUncollectedShown(true)
    C_ToyBox.SetUnusableShown(true)
    C_ToyBox.SetFilterString("")
end

local function LoadUI()
    PetJournal:HookScript("OnShow", function()
        if not PetJournalPetCard.petID then
            PetJournal_ShowPetCard(1)
        end
    end)

    FireCallbacks(loadUICallbacks)
    ADDON:FilterAndRefresh()
end

local function FilterToys()
    local filteredToyList = {}

    local searchString = ToyBox.searchString
    if not searchString then
        searchString = ""
    else
        searchString = searchString:lower()
    end

    for itemId in pairs(ADDON.db.ingameList) do
        if ADDON:FilterToy(itemId, searchString) then
            table.insert(filteredToyList, itemId)
        end
    end

    table.sort(filteredToyList, function(itemA, itemB)
        if itemA == itemB then
            return false
        end

        local result = false

        local _, nameA, _, isFavoriteA = C_ToyBox.GetToyInfo(itemA)
        local _, nameB, _, isFavoriteB = C_ToyBox.GetToyInfo(itemB)

        if ADDON.settings.sort.favoritesFirst and isFavoriteA ~= isFavoriteB then
            return isFavoriteA and not isFavoriteB
        end
        if ADDON.settings.sort.unownedAtLast then
            local isCollectedA = PlayerHasToy(itemA)
            local isCollectedB = PlayerHasToy(itemB)
            if isCollectedA ~= isCollectedB then
                return isCollectedA and not isCollectedB
            end
        end

        if ADDON.settings.sort.by == 'name' then
            result = strcmputf8i(nameA, nameB) < 0
        elseif ADDON.settings.sort.by == 'expansion' then
            result = itemA < itemB
        end

        if ADDON.settings.sort.descending then
            result = not result
        end

        return result
    end)

    ADDON.filteredToyList = filteredToyList
end

function ADDON:FilterAndRefresh()
    if not InCombatLockdown() then
        FilterToys()
        ToyBox_UpdatePages()
        ToyBox_UpdateButtons()
    end
end

local function OnLogin()
    for toyIndex = 1, C_ToyBox.GetNumFilteredToys() do
        local itemId = C_ToyBox.GetToyFromIndex(toyIndex)
        if itemId then
            ADDON.db.ingameList[itemId] = true
        end
    end

    FireCallbacks(loginCallbacks)
end

local loggedIn = false
local addonLoaded = false
local playerLoggedIn = false
local delayLoginUntilFullyLoaded = false

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("TOYS_UPDATED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        addonLoaded = true
    elseif event == "PLAYER_LOGIN" and false == playerLoggedIn then
        ResetAPIFilters()

        if C_ToyBox.GetNumFilteredToys() < 555 then
            delayLoginUntilFullyLoaded = true
        end
        playerLoggedIn = true
    elseif event == "TOYS_UPDATED" and delayLoginUntilFullyLoaded and playerLoggedIn and nil == arg1 and C_ToyBox.GetNumFilteredToys() > 555 then
        delayLoginUntilFullyLoaded = false
    end

    if playerLoggedIn and addonLoaded and not delayLoginUntilFullyLoaded and not loggedIn and not InCombatLockdown() then
        loggedIn = true
        OnLogin()
    end

    if ToyBox and loggedIn and not ADDON.initialized and ADDON.settings and not InCombatLockdown() then
        frame:UnregisterEvent("ADDON_LOADED")
        LoadUI()
        ADDON.initialized = true
    elseif ADDON.initialized and ToyBox:IsVisible() and (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED") then
        ADDON:FilterAndRefresh()
    end
end)
