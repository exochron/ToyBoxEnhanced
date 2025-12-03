local ADDON_NAME, ADDON = ...

local actionButton = CreateFrame("Button", nil, nil, "InsecureActionButtonTemplate")
actionButton:SetAttribute("pressAndHoldAction", 1)
actionButton:SetAttribute("type", "toy")
actionButton:SetAttribute("typerelease", "toy")
actionButton:RegisterForClicks("LeftButtonUp")
actionButton:SetPropagateMouseClicks(true)
actionButton:SetPropagateMouseMotion(true)
actionButton:Hide()

local function generateFavoritesMenu(_, root)
    root:SetTag(ADDON_NAME.."-LDB-Favorites")
    root:SetScrollMode(GetScreenHeight() - 100)

    local _, _, favoredToys = ADDON.Api:GetFavoriteProfile()
    local sortedToys = CopyTable(favoredToys)
    sortedToys = tFilter(sortedToys, function(itemId)
        return PlayerHasToy(itemId)
    end, true)
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
                actionButton:SetFrameStrata("TOOLTIP")
                actionButton:Show()

                GameTooltip:SetOwner(frame, "ANCHOR_NONE")
                GameTooltip:ClearLines()
                GameTooltip:SetToyByItemID(itemId)
                local left, _, width = frame:GetRect()
                local remainingSpaceOnRight = GetScreenWidth() - left - width
                if remainingSpaceOnRight < GameTooltip:GetWidth() then
                    GameTooltip:SetPoint("TOPRIGHT", frame, "TOPLEFT") -- on left side
                else
                    GameTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT") -- on right side
                end
                GameTooltip:Show()
            end)
            element:SetOnLeave(function()
                GameTooltip:Hide()
                actionButton:Hide()
                actionButton:SetParent(nil)
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
    local ldb = LibStub and LibStub("LibDataBroker-1.1", true)
    if not ldb then
        return
    end

    local menu

    -- Use a proxy frame to get a proper tooltip position from the broker addon
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
                favoredToys = tFilter(favoredToys, function(itemId)
                    return PlayerHasToy(itemId)
                end, true)
                ADDON:LoadItemsIntoCache(favoredToys, function()
                    menu = OpenMenu(tooltipProxy, generateFavoritesMenu)
                end)
            end
        end
    end)
    tooltipProxy:HookScript("OnHide", function()
        if ADDON.Api:HasFavorites() and menu and not menu:IsMouseOver(10, -10, -10, 10) then
            menu:Close()
        else
            GameTooltip:Hide()
        end
    end)
    -- polyfill to use a regular frame as an tooltip
    -- https://warcraft.wiki.gg/wiki/API_GameTooltip_SetOwner
    tooltipProxy.SetOwner = function(self, owner, anchor, ofsX, ofsY)
        ofsX = ofsX or 0
        ofsY = ofsY or 0
        self:ClearAllPoints()
        self:SetParent(owner)
        if anchor == "ANCHOR_TOP" then
            self:SetPoint("BOTTOM", owner, "TOP", ofsX, ofsY)
        elseif anchor == "ANCHOR_RIGHT" then
            self:SetPoint("BOTTOMLEFT", owner, "TOPRIGHT", ofsX, ofsY)
        elseif anchor == "ANCHOR_BOTTOM" then
            self:SetPoint("TOP", owner, "BOTTOM", ofsX, ofsY)
        elseif anchor == "ANCHOR_LEFT" then
            self:SetPoint("BOTTOMRIGHT", owner, "TOPLEFT", ofsX, ofsY)
        elseif anchor == "ANCHOR_TOPRIGHT" then
            self:SetPoint("BOTTOMRIGHT", owner, "TOPRIGHT", ofsX, ofsY)
        elseif anchor == "ANCHOR_BOTTOMRIGHT" then
            self:SetPoint("TOPLEFT", owner, "BOTTOMRIGHT", ofsX, ofsY)
        elseif anchor == "ANCHOR_TOPLEFT" then
            self:SetPoint("BOTTOMLEFT", owner, "TOPLEFT", ofsX, ofsY)
        elseif anchor == "ANCHOR_BOTTOMLEFT" then
            self:SetPoint("TOPRIGHT", owner, "BOTTOMLEFT", ofsX, ofsY)
        end
    end

    local ldbName = ADDON_NAME.." Favorites"
    local _, profileName = ADDON.Api:GetFavoriteProfile()
    local ldbDataObject = ldb:NewDataObject( ldbName, {
        type = "data source",
        text = profileName,
        value = count(),
        label = ldbName, -- Titan Panel uses label as entry name in its plugin list.
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
    C_Timer.After(0, function()
        ldbDataObject.label = ADDON.L.FAVORITE_PROFILE
    end)

    ADDON.Events:RegisterCallback("OnFavoriteProfileChanged", function()
        local _, profileName = ADDON.Api:GetFavoriteProfile()
        ldbDataObject.text = profileName
    end, "ldb-favorites")
    ADDON.Events:RegisterFrameEventAndCallback("NEW_TOY_ADDED", function()
        ldbDataObject.value = count()
    end, 'new toy')

    -- force initial update for ElvUI
    -- since ElvUI is loaded before TBE and it doesn't update its panels during registration. :(
    -- https://github.com/tukui-org/ElvUI/issues/1640
    local _ = ElvUI and ElvUI[1]:GetModule('DataTexts'):LoadDataTexts()

end, "ldb-plugin")