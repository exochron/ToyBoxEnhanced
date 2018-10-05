local ADDON_NAME, ADDON = ...

local L = ADDON.L
local starButton

function ADDON:CollectFavoredToys()
    local personalFavored = {}
    if ADDON.settings.favoritePerChar then
        for _, itemId in pairs(ADDON.db.ingameList) do
            if PlayerHasToy(itemId) and C_ToyBox.GetIsFavorite(itemId) then
                personalFavored[#personalFavored + 1] = itemId
            end
        end
    end

    ADDON.settings.favoredToys = personalFavored

    return personalFavored
end

local function FavorToys(itemIds, finishedCallback)
    -- appearantly Blizzard only allows ~5 requests per second

    if starButton then
        starButton:Disable()
    end

    local hasUpdate
    for _, itemId in pairs(ADDON.db.ingameList) do
        if PlayerHasToy(itemId) then
            local isFavorite = C_ToyBox.GetIsFavorite(itemId)
            local shouldFavor = tContains(itemIds, itemId)
            if isFavorite and not shouldFavor then
                C_ToyBox.SetIsFavorite(itemId, false)
                hasUpdate = true
            elseif not isFavorite and shouldFavor then
                C_ToyBox.SetIsFavorite(itemId, true)
                hasUpdate = true
            end
        end
    end

    if ADDON.initialized then
        ADDON:FilterAndRefresh()
    end

    if hasUpdate then
        C_Timer.After(1, function()
            FavorToys(itemIds, finishedCallback)
        end)
    elseif finishedCallback then
        if starButton then
            starButton:Enable()
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

local function InitializeDropDown(menu, level)
    local info = MSA_DropDownMenu_CreateInfo()
    info.keepShownOnClick = false
    info.isNotRadio = true
    info.notCheckable = true
    info.hasArrow = false

    if level == 1 then
        info.text = L['FAVOR_DISPLAYED']
        info.func = function()
            RunSetFavorites(ADDON.filteredToyList)
        end
        MSA_DropDownMenu_AddButton(info, level)

        info.text = UNCHECK_ALL
        info.func = function()
            RunSetFavorites({})
        end
        MSA_DropDownMenu_AddButton(info, level)

        info.text = L["FAVOR_PER_CHARACTER"]
        info.notCheckable = false
        info.checked = ADDON.settings.favoritePerChar
        info.func = function(_, _, _, value)
            ADDON.settings.favoritePerChar = not value
            ADDON:CollectFavoredToys()
        end
        MSA_DropDownMenu_AddButton(info, level)
    end
end

local function BuildStarButton()
    local menu = MSA_DropDownMenu_Create(ADDON_NAME .. "FavorMenu", ToyBox)
    MSA_DropDownMenu_Initialize(menu, InitializeDropDown, "MENU")

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
    starButton:SetScript("OnLeave", function(sender)
        GameTooltip:Hide()
    end);
    starButton:SetScript("OnClick", function()
        MSA_ToggleDropDownMenu(1, nil, menu, starButton, 0, 10)
    end)
    starButton:RegisterEvent("PLAYER_REGEN_ENABLED")
    starButton:RegisterEvent("PLAYER_REGEN_DISABLED")
    starButton:SetScript("OnEvent", function(self, event, arg1)
        self:SetShown(event == "PLAYER_REGEN_ENABLED")
    end)
    starButton:SetShown(not ADDON.inCombat)
end

ADDON:RegisterLoadUICallback(BuildStarButton)

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

ADDON:RegisterLoginCallback(function()
    if ADDON.settings.favoritePerChar then
        FavorToys(ADDON.settings.favoredToys, function()
            hooksecurefunc(C_ToyBox, "SetIsFavorite", HookSetIsFavorite)
        end)
    else
        hooksecurefunc(C_ToyBox, "SetIsFavorite", HookSetIsFavorite)
    end
end)