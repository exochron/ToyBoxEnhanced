local ADDON_NAME, ADDON = ...

ADDON.TOYS_PER_PAGE = 18
ADDON.UI = {}
ADDON.DataProvider = CreateDataProvider()
ADDON.DataProvider:SetSortComparator(function(a, b)
    return ADDON:SortHandler(a, b)
end)

-- see: https://www.townlong-yak.com/framexml/ptr/CallbackRegistry.lua
ADDON.Events = CreateFromMixins(CallbackRegistryMixin)
ADDON.Events:OnLoad()
ADDON.Events:SetUndefinedEventsAllowed(true)

local function ResetAPIFilters()
    C_ToyBox.SetAllSourceTypeFilters(true)
    C_ToyBox.SetAllExpansionTypeFilters(true)
    C_ToyBox.SetCollectedShown(true)
    C_ToyBox.SetUncollectedShown(true)
    C_ToyBox.SetUnusableShown(true)
    C_ToyBox.SetFilterString("")

    return C_ToyBox.GetNumFilteredToys()
end

function ADDON:FilterAndRefresh()
    if not InCombatLockdown() then
        ADDON:FilterToys()
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

    -- check if there is an item which is not in the game anymore
    local itemsToRemoveFromList = {}
    for itemId, isIngame in pairs(ADDON.db.ingameList) do
        if isIngame == false and C_Item.DoesItemExistByID(itemId) == false then
            table.insert(itemsToRemoveFromList, itemId)
        end
    end
    if #itemsToRemoveFromList > 0 then
        -- now we have to remove those items from the list by recreating the table
        local newTbl = {}
        for itemId, isIngame in pairs(ADDON.db.ingameList) do
            if not tContains(itemsToRemoveFromList, itemId) then
                newTbl[itemId] = isIngame
            end
        end
        ADDON.db.ingameList = newTbl
    end
end

-- some items might not be cached. therefore you won't get any name etc.
-- we have to load them initially, so we can work with that data.
local function LoadItemsIntoCache(onDone)
    local countOfUnloadedItems = 0
    for _ in pairs(ADDON.db.ingameList) do
        countOfUnloadedItems = countOfUnloadedItems + 1
    end

    local delayDone = function()
        countOfUnloadedItems = countOfUnloadedItems - 1
        if countOfUnloadedItems == 0 then
            onDone()
        end
    end
    for itemId in pairs(ADDON.db.ingameList) do
        -- AddCallback() also requests the item data
        ItemEventListener:AddCallback(itemId, delayDone)
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
        if ResetAPIFilters() < ADDON.DELAY_CHECK then
            delayLoginUntilFullyLoaded = true
        end
        playerLoggedIn = true
    end
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        addonLoaded = true
    elseif event == "TOYS_UPDATED" and delayLoginUntilFullyLoaded and playerLoggedIn and nil == arg1 and ResetAPIFilters() >= ADDON.DELAY_CHECK then
        delayLoginUntilFullyLoaded = false
    end

    if playerLoggedIn and addonLoaded and not delayLoginUntilFullyLoaded and not loggedIn and not InCombatLockdown() then
        loggedIn = true
        OnLogin()
        ADDON.Events:TriggerEvent("OnInit")
        ADDON.Events:TriggerEvent("OnLogin")
        ADDON.Events:UnregisterEvents({"OnInit", "OnLogin"})
    end

    if ADDON.initialized and ToyBox:IsVisible() and (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED") then
        ADDON:FilterAndRefresh(true)
    end
end)

local loadUIisRunning = false
EventRegistry:RegisterCallback("CollectionsJournal.TabSet", function(_,_,selectedTab)
    if selectedTab == COLLECTIONS_JOURNAL_TAB_INDEX_TOYS and ToyBox and loggedIn and not ADDON.initialized and ADDON.settings and not loadUIisRunning and not InCombatLockdown() then
        loadUIisRunning = true
        frame:UnregisterEvent("ADDON_LOADED")
        LoadItemsIntoCache(function()
            ADDON.Events:TriggerEvent("PreLoadUI")
            ADDON.Events:TriggerEvent("OnLoadUI")
            ADDON.Events:TriggerEvent("PostLoadUI")
            ADDON.Events:UnregisterEvents({"PreLoadUI", "OnLoadUI", "PostLoadUI"})

            ADDON:FilterAndRefresh(true)
            ADDON.initialized = true
            EventRegistry:UnregisterCallback("CollectionsJournal.TabSet", ADDON_NAME)
        end)
    end
end, ADDON_NAME)