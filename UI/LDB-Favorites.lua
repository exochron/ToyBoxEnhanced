local ADDON_NAME, ADDON = ...

local actionButton

local function buildActionButton()
    local button = CreateFrame("Button", "TBEActionButton", nil, "InsecureActionButtonTemplate")
    button:SetAttribute("pressAndHoldAction", 1)
    button:SetAttribute("type", "toy")
    button:SetAttribute("typerelease", "toy")
    button:RegisterForClicks("LeftButtonUp")
    button:SetPropagateMouseClicks(true)
    button:SetPropagateMouseMotion(true)
    button:Hide()

    return button
end

local function generateMenu(_, root)
    root:SetTag(ADDON_NAME.."-LDB")
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
        end
    end
end

ADDON.Events:RegisterCallback("OnLogin", function()
    local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
    if not ldb then
        return
    end

    actionButton = buildActionButton()

    local menu

    local _, profileName = ADDON.Api:GetFavoriteProfile()

    local ldbDataObject = ldb:NewDataObject( ADDON_NAME.." Favorites", {
        type = "data source",
        text = profileName,
        label = ADDON.L.FAVORITE_PROFILE,
        icon = "Interface\\Icons\\Trade_Archaeology_ChestofTinyGlassAnimals",

        OnClick = function(_, button)
            if button == "RightButton" then
                ADDON:OpenSettings()
            elseif not InCombatLockdown() then
                ToggleCollectionsJournal(COLLECTIONS_JOURNAL_TAB_INDEX_TOYS)
            end
        end,

        OnEnter = function(frame)
            menu = nil
            if ADDON.Api:HasFavorites() and MenuUtil and not InCombatLockdown() then
                local elementDescription = MenuUtil.CreateRootMenuDescription(MenuVariants.GetDefaultContextMenuMixin())

                Menu.PopulateDescription(generateMenu, frame, elementDescription)
                local anchor = CreateAnchor("TOP", frame, "BOTTOM", 0, 0)
                menu = Menu.GetManager():OpenMenu(frame, elementDescription, anchor)
                if menu then
                    menu:HookScript("OnLeave", function()
                        if not menu:IsMouseOver() then
                            menu:Close()
                        end
                    end) -- OnLeave gets reset every time
                end
            else
                -- todo show tooltip to setup favorites
            end
        end,

        OnLeave = function()
            if menu and not menu:IsMouseOver() then
                menu:Close()
            end
        end
    } )

    ADDON.Events:RegisterCallback("OnFavoriteProfileChanged", function()
        local _, profileName = ADDON.Api:GetFavoriteProfile()
        ldbDataObject.text = profileName
    end, "ldb-favorites")

end, "ldb-plugin")