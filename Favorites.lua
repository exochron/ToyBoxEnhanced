local ADDON_NAME, ADDON = ...

-- TODO: autoFavor new toys on all configured profiles

local L = ADDON.L
local starButton

--region api
function ADDON.Api:GetFavoriteProfile()
    local playerGuid = UnitGUID("player")
    local profileIndex = ADDON.settings.favorites.assignments[playerGuid] or 1
    if not ADDON.settings.favorites.profiles[profileIndex] then
        profileIndex = 1
    end

    local name = ADDON.settings.favorites.profiles[profileIndex].name
    if profileIndex == 1 then
        name = ADDON.L.FAVORITE_ACCOUNT_PROFILE
    end

    return profileIndex, name, ADDON.settings.favorites.profiles[profileIndex].toys
end
function ADDON.Api:GetIsFavorite(itemId)
    local _, _, favorites = ADDON.Api:GetFavoriteProfile()
    return tContains(favorites, itemId)
end
function ADDON.Api:HasFavorites()
    local _, _, favorites = ADDON.Api:GetFavoriteProfile()
    return #favorites > 0
end
function ADDON.Api:SetIsFavorite(itemId, value)
    local _, _, favorites = ADDON.Api:GetFavoriteProfile()

    local hasChange = false
    if true == value and not tContains(favorites, itemId) then
        table.insert(favorites, itemId)
        hasChange = true
    elseif false == value then
        local i = tIndexOf(favorites, itemId)
        if i then
            tUnorderedRemove(favorites, i)
            hasChange = true
        end
    end

    if hasChange then
        ADDON.Events:TriggerEvent("OnFavoritesChanged")
    end
end
function ADDON.Api:SetBulkIsFavorites(filteredProvider)
    local _, _, profileToys = ADDON.Api:GetFavoriteProfile()

    local itemsToAdd = CopyValuesAsKeys(filteredProvider)
    local hasChange = false

    for index = 1, #profileToys do
        local itemId = profileToys[index]

        if itemsToAdd[itemId] then
            itemsToAdd[itemId] = nil
        else
            tUnorderedRemove(profileToys, index)
            index = index -1
            hasChange = true
        end
    end

    for itemId, shouldAdd in pairs(itemsToAdd) do
        if shouldAdd then
            table.insert(profileToys, itemId)
            hasChange = true
        end
    end

    if hasChange then
        ADDON.Events:TriggerEvent("OnFavoritesChanged")
    end
end

function ADDON.Api:SwitchFavoriteProfile(newIndex)
    local oldIndex = ADDON.Api:GetFavoriteProfile()
    if oldIndex ~= newIndex then
        ADDON.settings.favorites.assignments[UnitGUID("player")] = newIndex
        ADDON.Events:TriggerEvent("OnFavoritesChanged")
        ADDON.Events:TriggerEvent("OnFavoriteProfileChanged")
    end
end
function ADDON.Api:RemoveFavoriteProfile(index)
    if index > 1 then
        local profileIndex = ADDON.Api:GetFavoriteProfile()
        if profileIndex == index then
            ADDON.Api:SwitchFavoriteProfile(1)
        end

        ADDON.settings.favorites.profiles[index] = nil
        -- todo cleanup all assignments
    end
end

--endregion


StaticPopupDialogs["TBE_EDIT_FAVORITE_PROFILE"] = {
    text = ADDON.L.ASK_FAVORITE_PROFILE_NAME,
    button1 = OKAY,
    button2 = CANCEL,
    whileDead = 1,
    hasEditBox = true,
    OnAccept = function (self, profileIndex)
        local text = self.editBox:GetText()
        if profileIndex > 1 then
            ADDON.settings.favorites.profiles[profileIndex].name = text
        elseif profileIndex == nil then
            table.insert(ADDON.settings.favorites.profiles, {
                ["name"] = text,
                ["toys"] = {}
            })
        end
    end,
    OnShow = function (self, profileIndex)
        if profileIndex and ADDON.settings.favorites.profiles[profileIndex] then
            self.editBox:SetText(ADDON.settings.favorites.profiles[profileIndex].name)
        end
    end,
    timeout = 0,
    hideOnEscape = 1,
    enterClicksFirstButton = 1,
};
StaticPopupDialogs["TBE_CONFIRM_DELETE_FAVORITE_PROFILE"] = {
    text = ADDON.L.CONFIRM_FAVORITE_PROFILE_DELETION,
    button1 = YES,
    button2 = NO,
    OnAccept = function (self, index)
        ADDON.Api:RemoveFavoriteProfile(index)
    end,
    hideOnEscape = 1,
    timeout = 0,
    whileDead = 1,
}


--region Star Button

local function InitializeDropDown(_, level)
    if level == 1 then
        local info = {
            isNotRadio = true,
            notCheckable = true,
            text = L['FAVOR_DISPLAYED'],
            func = function()
                ADDON.Api:SetBulkIsFavorites(ADDON.DataProvider:GetCollection())
            end,
        }
        UIDropDownMenu_AddButton(info, level)

        info = {
            isNotRadio = true,
            notCheckable = true,
            text = UNCHECK_ALL,
            func = function()
                ADDON.Api:SetBulkIsFavorites(CreateDataProvider())
            end,
        }
        UIDropDownMenu_AddButton(info, level)
    end
end
local function CreateFavoritesMenu(owner, root)
    root:CreateTitle(FAVORITES)

    root:CreateButton(L.FAVOR_DISPLAYED, function()
        ADDON.Api:SetBulkIsFavorites(ADDON.DataProvider:GetCollection())
    end)
    root:CreateButton(UNCHECK_ALL, function()
        ADDON.Api:SetBulkIsFavorites({})
    end)

    local profileIndex, profileName = ADDON.Api:GetFavoriteProfile()
    local profileRoot = root:CreateButton(ADDON.L.FAVORITE_PROFILE..": "..profileName)

    profileRoot:CreateButton(ADD, function()
        StaticPopup_Show("TBE_EDIT_FAVORITE_PROFILE")
    end)
    profileRoot:QueueSpacer()

    -- all profiles
    for index, profileData in ipairs(ADDON.settings.favorites.profiles) do
        local singleProfileRoot = profileRoot:CreateRadio(profileData.name.." ("..(#profileData.toys)..")", function()
            return index == ADDON.Api:GetFavoriteProfile()
        end, function()
            ADDON.Api:SwitchFavoriteProfile(index)
            return MenuResponse.Refresh
        end)
        if index > 1 then
            singleProfileRoot:CreateButton(PET_RENAME, function()
                StaticPopup_Show("TBE_EDIT_FAVORITE_PROFILE", nil, nil, index)
            end)
            singleProfileRoot:CreateButton(REMOVE, function()
                StaticPopup_Show("TBE_CONFIRM_DELETE_FAVORITE_PROFILE", profileData.name, nil, index)
            end)
        end
    end

end

local function BuildStarButton()
    local menu

    starButton = CreateFrame(MenuUtil and "DropdownButton" or "Button", nil, ToyBox)
    starButton:SetPoint("RIGHT", ToyBox.searchBox.Left, "LEFT", WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE and -5 or -10, 0)
    starButton:SetSize(16, 16)

    local icon = starButton:CreateTexture(nil, "ARTWORK")
    icon:SetAtlas("auctionhouse-icon-favorite")
    icon:SetAllPoints(starButton)

    starButton:SetHighlightAtlas("auctionhouse-icon-favorite", "ADD")
    local highlight = starButton:GetHighlightTexture()
    highlight:SetAlpha(0.4)
    highlight:SetAllPoints(icon)

    starButton:HookScript("OnMouseDown", function()
        icon:AdjustPointsOffset(1, -1)
    end)
    starButton:HookScript("OnMouseUp", function()
        icon:AdjustPointsOffset(-1, 1)
    end)

    if starButton.SetupMenu then
        starButton:SetupMenu(CreateFavoritesMenu)
    else
        starButton:SetScript("OnClick", function()
            if not menu then
                menu = CreateFrame("Frame", ADDON_NAME .. "FavorMenu", ToyBox, "UIDropDownMenuTemplate")
                UIDropDownMenu_Initialize(menu, InitializeDropDown, "MENU")
            end

            ToggleDropDownMenu(1, nil, menu, starButton, 0, 1)
        end)
        starButton:SetScript("OnEnter", function(sender)
            GameTooltip:SetOwner(sender, "ANCHOR_NONE")
            GameTooltip:SetPoint("BOTTOM", sender, "TOP", 0, -4)
            GameTooltip:SetText(FAVORITES)
            GameTooltip:Show()
        end);
        starButton:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end);
    end
    starButton:RegisterEvent("PLAYER_REGEN_ENABLED")
    starButton:RegisterEvent("PLAYER_REGEN_DISABLED")
    starButton:SetScript("OnEvent", function(self, event)
        self:SetShown(event == "PLAYER_REGEN_ENABLED")
    end)
    starButton:SetShown(not InCombatLockdown())

    ADDON.UI.FavoriteButton = starButton
end

--endregion
ADDON.Events:RegisterCallback("OnLoadUI", BuildStarButton, "favorites")
ADDON.Events:RegisterCallback("OnFavoritesChanged", function()
    ADDON.DataProvider:Sort()
end, "sort dataprovider")
