local ADDON_NAME, ADDON = ...

local actionButton

local function buildActionButton()
    local button = CreateFrame("Button", nil, nil, "InsecureActionButtonTemplate")
    button:SetAttribute("pressAndHoldAction", 1)
    button:SetAttribute("type", "toy")
    button:SetAttribute("typerelease", "toy")
    button:RegisterForClicks("LeftButtonUp")
    button:SetPropagateMouseClicks(true)
    button:SetPropagateMouseMotion(true)
    button:Hide()

    return button
end

local function generateFavoritesMenu(_, root)
    root:SetTag(ADDON_NAME.."-LDB-Favorites")
    root:SetScrollMode(GetScreenHeight() - 100)

    local _, _, favoredToys = ADDON.Api:GetFavoriteProfile()
    local sortedToys = CopyTable(favoredToys)
    table.sort(sortedToys, function(a, b)
        return (C_Item.GetItemNameByID(a) or "") < (C_Item.GetItemNameByID(b) or "")
    end)

    for _, itemId in ipairs(sortedToys) do
        local _, name, icon = C_ToyBox.GetToyInfo(itemId)
        if name and icon then
            local element = root:CreateButton("|T" .. icon .. ":0|t "..name)
            element:SetOnEnter(function(frame)
                actionButton:SetAttribute("toy", itemId)
                actionButton:SetParent(frame)
                actionButton:SetAllPoints(frame)
                actionButton:SetFrameStrata("FULLSCREEN_DIALOG")
                actionButton:SetFrameLevel(600)
                actionButton:Show()

                GameTooltip:SetOwner(frame, "ANCHOR_NONE")
                GameTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT")
                GameTooltip:ClearLines()
                GameTooltip:SetToyByItemID(itemId)
                GameTooltip:Show()
            end)
            element:SetOnLeave(function()
                GameTooltip:Hide()
                actionButton:Hide()
            end)
            local cooldownTimer = C_Container.GetItemCooldown(itemId)
            if cooldownTimer > 0 then
                element:AddInitializer(function(button)
                    button.fontString:SetAlpha(0.5)
                end)
            end
        end
    end
end
local function generateProfileMenu(_, root)
    root:SetTag(ADDON_NAME.."-LDB-FavoriteProfiles")
    root:SetScrollMode(GetScreenHeight() - 100)

    root:CreateTitle(ADDON.L.FAVORITE_PROFILE)
    ADDON.UI:BuildFavoriteProfileMenu(root)
end

local function OpenMenu(anchorSource, generator)
    local menuDescription = MenuUtil.CreateRootMenuDescription(MenuVariants.GetDefaultContextMenuMixin())

    local point, relativeTo, relativePoint, offsetX, offsetY = anchorSource:GetPoint(1)

    Menu.PopulateDescription(generator, relativeTo, menuDescription)

    local anchor = CreateAnchor(point, relativeTo, relativePoint, offsetX, offsetY)
    local menu = Menu.GetManager():OpenMenu(relativeTo, menuDescription, anchor)
    if menu then
        menu:HookScript("OnLeave", function()
            if not menu:IsMouseOver() then
                menu:Close()
            end
        end) -- OnLeave gets reset every time
    end

    return menu
end

local function count()
    local c = 0
    for itemId, valid in pairs(ADDON.db.ingameList) do
        if valid then
            if PlayerHasToy(itemId) then
                c = c + 1
            end
        end
    end

    return c
end

ADDON.Events:RegisterCallback("OnLogin", function()
    local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
    if not ldb then
        return
    end

    actionButton = buildActionButton()

    local menu
    local tooltipProxy = CreateFrame("Frame")
    tooltipProxy:Hide()

    tooltipProxy:HookScript("OnShow", function()
        menu = nil
        if not ADDON.Api:HasFavorites() then
            local L = ADDON.L
            GameTooltip:SetOwner(tooltipProxy, "ANCHOR_NONE")
            GameTooltip:SetPoint(tooltipProxy:GetPoint(1))
            GameTooltip:ClearLines()
            GameTooltip_SetTitle(GameTooltip, L.LDB_TIP_NO_FAVORITES_TITLE)
            GameTooltip_AddInstructionLine(GameTooltip, L.LDB_TIP_NO_FAVORITES_INSTRUCTION, true)
            GameTooltip:AddLine(L.LDB_TIP_NO_FAVORITES_LEFT_CLICK)
            GameTooltip:AddLine(L.LDB_TIP_NO_FAVORITES_RIGHT_CLICK)
            GameTooltip:Show()
        elseif not InCombatLockdown() then
            if ADDON.initialized then
                menu = OpenMenu(tooltipProxy, generateFavoritesMenu)
            else
                local _, _, favoredToys = ADDON.Api:GetFavoriteProfile()
                ADDON:LoadItemsIntoCache(favoredToys, function()
                    menu = OpenMenu(tooltipProxy, generateFavoritesMenu)
                end)
            end
        end
    end)
    tooltipProxy:HookScript("OnHide", function()
        if menu and not menu:IsMouseOver() then
            menu:Close()
        end
    end)

    local _, profileName = ADDON.Api:GetFavoriteProfile()
    local ldbDataObject = ldb:NewDataObject( ADDON_NAME.." Favorites", {
        type = "data source",
        text = profileName,
        value = count(),
        label = ADDON.L.FAVORITE_PROFILE,
        icon = "Interface\\Icons\\Trade_Archaeology_ChestofTinyGlassAnimals",
        tooltip = tooltipProxy,

        OnClick = function(_, button)
            if button == "RightButton" then
                GameTooltip:Hide()
                menu = OpenMenu(tooltipProxy, generateProfileMenu)
            elseif not InCombatLockdown() then
                ToggleCollectionsJournal(COLLECTIONS_JOURNAL_TAB_INDEX_TOYS)
            end
        end,
    } )

    ADDON.Events:RegisterCallback("OnFavoriteProfileChanged", function()
        local _, profileName = ADDON.Api:GetFavoriteProfile()
        ldbDataObject.text = profileName
    end, "ldb-favorites")
    ADDON.Events:RegisterFrameEventAndCallback("NEW_TOY_ADDED", function(_, ...)
        ldbDataObject.value = count()
    end, 'new toy')

end, "ldb-plugin")