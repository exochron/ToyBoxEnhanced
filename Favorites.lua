local ADDON_NAME, ADDON = ...

local L = ADDON.L
local starButton

function ADDON:CollectFavoredToys()
    local personalFavored = {}
    if ADDON.settings.favoritePerChar then
        for itemId in pairs(ADDON.db.ingameList) do
            if PlayerHasToy(itemId) and C_ToyBox.GetIsFavorite(itemId) then
                personalFavored[#personalFavored + 1] = itemId
            end
        end
    end

    ADDON.settings.favoredToys = personalFavored

    return personalFavored
end

local function FavorToys(itemIds, finishedCallback)
    -- apparently WoW only allows ~5 requests per second

    if starButton then
        starButton:Disable()
    end

    local updateCount = 0
    for itemId in pairs(ADDON.db.ingameList) do
        if PlayerHasToy(itemId) then
            local isFavorite = C_ToyBox.GetIsFavorite(itemId)
            local shouldFavor = tContains(itemIds, itemId)
            if isFavorite and not shouldFavor then
                C_ToyBox.SetIsFavorite(itemId, false)
                updateCount = updateCount + 1
            elseif not isFavorite and shouldFavor then
                C_ToyBox.SetIsFavorite(itemId, true)
                updateCount = updateCount + 1
            end

            -- client cant handle more anyway
            if updateCount > 10 then
                break
            end
        end
    end

    if updateCount > 0 then
        C_Timer.After(1, function()
            FavorToys(itemIds, finishedCallback)
        end)
    else
        if starButton then
            starButton:Enable()
        end
        if ADDON.initialized then
            ADDON:FilterAndRefresh()
        end
        finishedCallback()
    end
end

--region Star Button

local function RunSetFavorites(itemIds)
    print(L['TASK_FAVOR_START'])
    FavorToys(itemIds, function()
        print(L['TASK_END'])
    end)
end

local function InitializeDropDown(_, level)
    if level == 1 then
        local info = {
            isNotRadio = true,
            notCheckable = true,
            text = L['FAVOR_DISPLAYED'],
            func = function()
                RunSetFavorites(ADDON.filteredToyList)
            end,
        }
        UIDropDownMenu_AddButton(info, level)

        info = {
            isNotRadio = true,
            notCheckable = true,
            text = UNCHECK_ALL,
            func = function()
                RunSetFavorites({})
            end,
        }
        UIDropDownMenu_AddButton(info, level)

        info = {
            isNotRadio = true,
            checked = ADDON.settings.favoritePerChar,
            text = L["FAVOR_PER_CHARACTER"],
            func = function(_, _, _, value)
                ADDON.settings.favoritePerChar = not value
                ADDON:CollectFavoredToys()
            end,
        }
        UIDropDownMenu_AddButton(info, level)
    end
end

local function BuildStarButton()
    local menu = CreateFrame("Frame", ADDON_NAME .. "FavorMenu", ToyBox, "UIDropDownMenuTemplate")
    UIDropDownMenu_Initialize(menu, InitializeDropDown, "MENU")

    starButton = CreateFrame("Button", nil, ToyBox)
    starButton:SetPoint("RIGHT", ToyBox.searchBox, "LEFT", -4, 0)
    starButton:SetSize(25, 25)
    starButton:SetNormalAtlas("PetJournal-FavoritesIcon", true)
    starButton:SetScript("OnEnter", function(sender)
        GameTooltip:SetOwner(sender, "ANCHOR_NONE")
        GameTooltip:SetPoint("BOTTOM", sender, "TOP", 0, -4)
        GameTooltip:SetText(FAVORITES)
        GameTooltip:Show()
    end);
    starButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end);
    starButton:SetScript("OnClick", function()
        ToggleDropDownMenu(1, nil, menu, starButton, 0, 10)
    end)
    starButton:RegisterEvent("PLAYER_REGEN_ENABLED")
    starButton:RegisterEvent("PLAYER_REGEN_DISABLED")
    starButton:SetScript("OnEvent", function(self, event)
        self:SetShown(event == "PLAYER_REGEN_ENABLED")
    end)
    starButton:SetShown(not InCombatLockdown())
end

ADDON.Events:RegisterCallback("OnLoadUI", BuildStarButton, "favorites")

--endregion

local function HookSetIsFavorite(itemId, value)
    if value and not tContains(ADDON.settings.favoredToys, itemId) then
        tinsert(ADDON.settings.favoredToys, itemId)
    elseif not value then
        for i, item in ipairs(ADDON.settings.favoredToys) do
            if itemId == item then
                tremove(ADDON.settings.favoredToys, i)
                break
            end
        end
    end
end

ADDON.Event:RegisterCallback("OnLogin", function()
    if ADDON.settings.favoritePerChar then
        FavorToys(ADDON.settings.favoredToys, function()
            hooksecurefunc(C_ToyBox, "SetIsFavorite", HookSetIsFavorite)
        end)
    else
        hooksecurefunc(C_ToyBox, "SetIsFavorite", HookSetIsFavorite)
    end
end, "favorites")