local _, ADDON = ...

--TODO: sync Account profile with ingame favorites

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
function ADDON.Api:HasFavorites()
    local _, _, favorites = ADDON.Api:GetFavoriteProfile()
    return #favorites > 0
end
function ADDON.Api:GetIsFavorite(itemId)
    local _, _, favorites = ADDON.Api:GetFavoriteProfile()
    return tContains(favorites, itemId)
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
function ADDON.Api:SetBulkIsFavorites(filteredProvider, inclusive)
    local _, _, profileToys = ADDON.Api:GetFavoriteProfile()

    local itemsToAdd = CopyValuesAsKeys(filteredProvider)
    local hasChange = false

    local index = 1
    while index <= #profileToys do
        local itemId = profileToys[index]

        if itemsToAdd[itemId] then
            itemsToAdd[itemId] = nil
            index = index + 1
        elseif inclusive then
            -- skip remove
            index = index + 1
        else
            tUnorderedRemove(profileToys, index)
            hasChange = true
        end
    end

    local tInsert = table.insert
    for itemId, shouldAdd in pairs(itemsToAdd) do
        if shouldAdd then
            tInsert(profileToys, itemId)
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
        -- cleanup all assignments
        for guid, profileIndex in pairs(ADDON.settings.favorites.assignments) do
            if profileIndex == index then
                ADDON.settings.favorites.assignments[guid] = 1
            end
        end
    end
end
--endregion

StaticPopupDialogs["TBE_EDIT_FAVORITE_PROFILE"] = {
    text = ADDON.L.ASK_FAVORITE_PROFILE_NAME,
    button1 = OKAY,
    button2 = CANCEL,
    whileDead = 1,
    hasEditBox = true,
    OnAccept = function (popup, profileIndex)
        local editBox = popup.editBox or popup.EditBox
        local text = editBox:GetText()
        if profileIndex == nil then
            table.insert(ADDON.settings.favorites.profiles, {
                ["name"] = text,
                ["autoFavor"] = false,
                ["toys"] = {}
            })
            ADDON.Api:SwitchFavoriteProfile(#ADDON.settings.favorites.profiles)
        elseif profileIndex > 1 then
            ADDON.settings.favorites.profiles[profileIndex].name = text
            ADDON.Events:TriggerEvent("OnFavoriteProfileChanged")
        end
    end,
    OnShow = function (popup, profileIndex)
        if profileIndex and ADDON.settings.favorites.profiles[profileIndex] then
            local editBox = popup.editBox or popup.EditBox
            editBox:SetText(ADDON.settings.favorites.profiles[profileIndex].name)
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
    OnAccept = function (_, index)
        ADDON.Api:RemoveFavoriteProfile(index)
    end,
    hideOnEscape = 1,
    timeout = 0,
    whileDead = 1,
}

--region Star Button
function ADDON.UI:BuildFavoriteProfileMenu(root, withEditOptions)
    local sortedIndex = {}

    local profiles = ADDON.settings.favorites.profiles
    for index, profileData in pairs(profiles) do
        if profileData then
            table.insert(sortedIndex, index)
        end
    end
    table.sort(sortedIndex, function(a, b)
        return profiles[a].name < profiles[b].name
    end)

    for _, index in ipairs(sortedIndex) do
        local profileData = profiles[index]
        local name = index == 1 and ADDON.L.FAVORITE_ACCOUNT_PROFILE or profileData.name
        local singleProfileRoot = root:CreateRadio(name.." ("..(#profileData.toys)..")", function()
            return index == ADDON.Api:GetFavoriteProfile()
        end, function()
            ADDON.Api:SwitchFavoriteProfile(index)
            return MenuResponse.Refresh
        end)

        if withEditOptions then
            singleProfileRoot:CreateCheckbox(ADDON.L.FAVOR_AUTO, function()
                return profileData.autoFavor
            end, function()
                profileData.autoFavor = not profileData.autoFavor
                return MenuResponse.Refresh
            end)
            if index > 1 then
                singleProfileRoot:CreateButton(PET_RENAME, function()
                    StaticPopup_Show("TBE_EDIT_FAVORITE_PROFILE", nil, nil, index)
                end)
                singleProfileRoot:CreateButton(REMOVE, function()
                    StaticPopup_Show("TBE_CONFIRM_DELETE_FAVORITE_PROFILE", profileData.name, ADDON.L.FAVORITE_ACCOUNT_PROFILE, index)
                end)
            end
        end
    end
end

local function CreateFavoritesMenu(_, root)
    root:CreateTitle(FAVORITES)
    root:SetScrollMode(GetScreenHeight() - 100)

    root:CreateButton(L.FAVOR_DISPLAYED, function()
        ADDON.Api:SetBulkIsFavorites(ADDON.DataProvider:GetCollection(), true)
    end)
    root:CreateButton(UNCHECK_ALL, function()
        ADDON.Api:SetBulkIsFavorites({})
    end)

    local _, profileName = ADDON.Api:GetFavoriteProfile()
    local profileRoot = root:CreateButton(ADDON.L.FAVORITE_PROFILE..": "..profileName)

    profileRoot:CreateButton(ADD, function()
        StaticPopup_Show("TBE_EDIT_FAVORITE_PROFILE")
    end)
    profileRoot:QueueSpacer()

    ADDON.UI:BuildFavoriteProfileMenu(profileRoot, true)
end

local function BuildStarButton()
    starButton = CreateFrame("DropdownButton", nil, ToyBox)
    starButton:SetPoint("RIGHT", ToyBox.searchBox.Left, "LEFT", ADDON.isClassic and -5 or -10, 0)
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

    starButton:SetupMenu(CreateFavoritesMenu)

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

-- initial scan of account profile
ADDON.Events:RegisterCallback("OnLogin", function()
    local profileIndex, _ , favorites = ADDON.Api:GetFavoriteProfile()
    if 1 == profileIndex and not ADDON.settings.favorites.profiles[1].initialScan then
        ADDON.settings.favorites.profiles[1].initialScan = true

        if 0 == #favorites then
            local favoredToys = {}
            for itemId, validToy in pairs(ADDON.db.ingameList) do
                if validToy then
                    local _, _, _, isFavorite = C_ToyBox.GetToyInfo(itemId)
                    if isFavorite then
                        favoredToys[#favoredToys +1] = itemId
                    end
                end
            end

            ADDON.Api:SetBulkIsFavorites(favoredToys)
        end
    end
end, "favorite account scan")

-- auto favor
ADDON.Events:RegisterFrameEventAndCallback("NEW_TOY_ADDED", function(_, itemId)
    local currentProfile = ADDON.Api:GetFavoriteProfile()

    for index, profileData in pairs(ADDON.settings.favorites.profiles) do
        if profileData and profileData.autoFavor then
            if index == currentProfile then
                ADDON.Api:SetIsFavorite(itemId, true)
            elseif not tContains(profileData.toys, itemId) then
                table.insert(profileData.toys, itemId)
            end
        end
    end
end, 'auto favor new toy')