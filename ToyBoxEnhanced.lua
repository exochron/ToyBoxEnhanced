local ADDON_NAME, ADDON = ...

ADDON.TOYS_PER_PAGE = 18
ADDON.Api = {}
ADDON.UI = {}
ADDON.DataProvider = CreateDataProvider()
ADDON.DataProvider:SetSortComparator(function(a, b)
    return ADDON:SortHandler(a, b)
end)
ADDON.DataProvider:RegisterCallback("OnSizeChanged", function()
    if not InCombatLockdown() then
        ADDON.UI:UpdatePages()
        ADDON.UI:UpdateButtons()
    end
end, ADDON_NAME)
ADDON.DataProvider:RegisterCallback("OnSort", function()
    if not InCombatLockdown() then
        ADDON.UI:UpdateButtons()
    end
end, ADDON_NAME)

-- see: https://www.townlong-yak.com/framexml/live/Blizzard_SharedXML/CallbackRegistry.lua
ADDON.Events = CreateFromMixins(EventRegistry)
ADDON.Events:OnLoad()
ADDON.Events:SetUndefinedEventsAllowed(true)
ADDON.Events:RegisterFrameEventAndCallback("NEW_TOY_ADDED", function(_, ...)
    ADDON.DataProvider:Sort()
end, 'new toy')

local function ResetAPIFilters()
    C_ToyBox.SetAllSourceTypeFilters(true)
    C_ToyBox.SetAllExpansionTypeFilters(true)
    C_ToyBox.SetCollectedShown(true)
    C_ToyBox.SetUncollectedShown(true)
    C_ToyBox.SetUnusableShown(true)
    C_ToyBox.SetFilterString("")

    return C_ToyBox.GetNumFilteredToys()
end

local function cleanupDatabase(itemIdsToRemoveFromList)
    if not TableIsEmpty(itemIdsToRemoveFromList) then
        local function diffTableKeys(tbl, keysToDrop)
            local result = {}

            for key, val in pairs(tbl) do
                if type(val) == "table" then
                    local subResult = diffTableKeys(val, keysToDrop)
                    if not TableIsEmpty(subResult) then
                        result[key] = subResult
                    end
                elseif true ~= keysToDrop[key] then
                    result[key] = val
                end
            end

            return result
        end

        -- now we have to remove those items from the list by recreating the table
        ADDON.db.ingameList = diffTableKeys(ADDON.db.ingameList, itemIdsToRemoveFromList)
        ADDON.db.worldEvent = diffTableKeys(ADDON.db.worldEvent, itemIdsToRemoveFromList)
        ADDON.db.profession = diffTableKeys(ADDON.db.profession, itemIdsToRemoveFromList)
        ADDON.db.faction = diffTableKeys(ADDON.db.faction, itemIdsToRemoveFromList)
        ADDON.db.source = diffTableKeys(ADDON.db.source, itemIdsToRemoveFromList)
        ADDON.db.effect = diffTableKeys(ADDON.db.effect, itemIdsToRemoveFromList)
    end
end

local function OnLogin()
    for toyIndex = 1, C_ToyBox.GetNumFilteredToys() do
        local itemId = C_ToyBox.GetToyFromIndex(toyIndex)
        if itemId then
            ADDON.db.ingameList[itemId] = true
        end
    end

    local DoesItemExistInGame = C_Item.DoesItemExistByID
    -- C_Item.DoesItemExistByID() always returns true. got broken sometime during DF. (https://github.com/Stanzilla/WoWUIBugs/issues/449)
    if true == C_Item.DoesItemExistByID(1) then
        DoesItemExistInGame = function(itemId)
            return C_Item.GetItemIconByID(itemId) ~= 134400 -- question icon
        end
    end

    -- check if there is an item which is not in the game anymore
    local itemsToRemoveFromList = {}
    for itemId, isIngame in pairs(ADDON.db.ingameList) do
        if isIngame == false and (not DoesItemExistInGame(itemId) or not C_ToyBox.GetToyInfo(itemId)) then
            itemsToRemoveFromList[itemId] = true
        end
    end

    cleanupDatabase(itemsToRemoveFromList)
end

-- some items might not be cached. therefore you won't get any name etc.
-- we have to load them initially, so we can work with that data.
local function LoadItemsIntoCache(onDone)
    local countOfUnloadedItems = CountTable(ADDON.db.ingameList)
    local invalidItems = {}

    local frame = CreateFrame("Frame")
    frame:SetScript("OnEvent", function(self, _, itemId, success)
        if nil ~= ADDON.db.ingameList[itemId] then
            if not success then
                -- some item data can already be in game for a future update
                invalidItems[itemId] = true
            end

            countOfUnloadedItems = countOfUnloadedItems - 1
            if countOfUnloadedItems == 0 then
                cleanupDatabase(invalidItems)
                onDone()
                self:UnregisterEvent("ITEM_DATA_LOAD_RESULT")
                self:SetScript("OnEvent", nil)
            end
        end
    end)
    frame:RegisterEvent("ITEM_DATA_LOAD_RESULT")

    for itemId in pairs(ADDON.db.ingameList) do
        C_Item.RequestLoadItemDataByID(itemId)
    end
end

local loggedIn = false
local addonLoaded = false
local playerLoggedIn = false
local delayLoginUntilFullyLoaded = false

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN") -- might already been triggered
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("TOYS_UPDATED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:SetScript("OnEvent", function(_, event, arg1)
    if false == playerLoggedIn and IsLoggedIn() then
        if ResetAPIFilters() < 0.9 * C_ToyBox.GetNumTotalDisplayedToys() then
            -- toys are not yet fully loaded, so we delay a bit until at least 90% are there
            -- for further explanation see bottom of DebugTest
            delayLoginUntilFullyLoaded = true
        end
        playerLoggedIn = true
    end
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        addonLoaded = true
    elseif event == "TOYS_UPDATED" and delayLoginUntilFullyLoaded and playerLoggedIn and nil == arg1 and ResetAPIFilters() >= 0.9 * C_ToyBox.GetNumTotalDisplayedToys() then
        delayLoginUntilFullyLoaded = false
    end

    if playerLoggedIn and addonLoaded and not delayLoginUntilFullyLoaded and not loggedIn and not InCombatLockdown() then
        C_Timer.After(0.2, function() -- give client a bit more time to load remaining 10%
            if not InCombatLockdown() and not loggedIn then
                loggedIn = true
                OnLogin()
                ADDON.Events:TriggerEvent("OnInit")
                ADDON.Events:TriggerEvent("OnLogin")
                ADDON.Events:UnregisterEvents({ "OnInit", "OnLogin" })
            end
        end)
    end

    if ADDON.initialized and ToyBox:IsVisible() and (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED") then
        ADDON:FilterToys()
    end
end)

local loadUIisRunning = false
EventRegistry:RegisterCallback("CollectionsJournal.TabSet", function(_, _, selectedTab)
    if selectedTab == COLLECTIONS_JOURNAL_TAB_INDEX_TOYS and ToyBox and loggedIn and not ADDON.initialized and ADDON.settings and not loadUIisRunning and not InCombatLockdown() then
        loadUIisRunning = true
        frame:UnregisterEvent("ADDON_LOADED")
        LoadItemsIntoCache(function()
            ADDON.Events:TriggerEvent("PreLoadUI")
            ADDON.Events:TriggerEvent("OnLoadUI")
            ADDON.Events:TriggerEvent("PostLoadUI")
            ADDON.Events:UnregisterEvents({ "PreLoadUI", "OnLoadUI", "PostLoadUI" })

            ADDON:FilterToys()
            ADDON.initialized = true
            C_Timer.After(0, function()
                -- EventRegistry might crash when removing an callback while looping through all callbacks
                EventRegistry:UnregisterCallback("CollectionsJournal.TabSet", ADDON_NAME)
            end)
        end)
    end
end, ADDON_NAME)
