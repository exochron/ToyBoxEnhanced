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

    for index = 1, C_ToyBox.GetNumTotalDisplayedToys() do
        local itemId = C_ToyBox.GetToyFromIndex(index)
        local _, name, icon, isFavorite = C_ToyBox.GetToyInfo(itemId)
        if isFavorite and name and icon then
            local element = root:CreateButton("|T" .. icon .. ":0|t "..name)
            element:SetOnEnter(function(frame)
                actionButton:SetAttribute("toy", itemId)
                actionButton:SetParent(button)
                actionButton:SetAllPoints(button)
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
        else
            break
        end
    end

end

ADDON.Events:RegisterCallback("OnLogin", function()
    local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
    if not ldb then
        return
    end

    actionButton = buildActionButton()

    local function count()
        local owned = 0

        for itemId, valid in pairs(ADDON.db.ingameList) do
            if valid and PlayerHasToy(itemId) then
                owned = owned + 1
            end
        end

        return owned
    end

    local menu

    local ldbDataObject = ldb:NewDataObject( ADDON_NAME.." Favorites", {
        type = "data source",
        text = count(),
        label = COLLECTED,
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
            if C_ToyBox.HasFavorites() and MenuUtil and not InCombatLockdown() then
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
            end
        end,

        OnLeave = function()
            if menu and not menu:IsMouseOver() then
                menu:Close()
            end
        end
    } )

    actionButton:RegisterEvent("TOYS_UPDATED")
    actionButton:SetScript("OnEvent", function()
        ldbDataObject.text = count()
    end)

end, "ldb-plugin")