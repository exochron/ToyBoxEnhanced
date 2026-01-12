local _, ADDON = ...

local SETTING_COLLECTED = "collected"
local SETTING_ONLY_FAVORITES = "onlyFavorites"
local SETTING_NOT_COLLECTED = "notCollected"
local SETTING_ONLY_USEABLE = "onlyUsable"
local SETTING_ONLY_TRADABLE = "onlyTradable"
local SETTING_ONLY_RECENT = "onlyRecent"
local SETTING_HIDDEN = "hidden"
local SETTING_SECRET = "secret"
local SETTING_SOURCE = "source"
local SETTING_SORT = "sort"
local SETTING_PROFESSION = "profession"
local SETTING_WORLD_EVENT = "worldEvent"
local SETTING_FACTION = "faction"
local SETTING_EXPANSION = "expansion"
local SETTING_EFFECT = "effect"

local function setAllSettings(settings, switch)
    for key, value in pairs(settings) do
        if type(value) == "table" then
            for subKey, _ in pairs(value) do
                settings[key][subKey] = switch
            end
        else
            settings[key] = switch
        end
    end
end

local function CheckSetting(settings)
    local hasTrue, hasFalse = false, false
    for _, v in pairs(settings) do
        if (v == true) then
            hasTrue = true
        elseif v == false then
            hasFalse = true
        end
        if hasTrue and hasFalse then
            break
        end
    end

    return hasTrue, hasFalse
end

local function SetAllSubFilters(settings, switch)
    setAllSettings(settings, switch)
    ADDON:FilterToys()
end

local function HasUserHiddenToys()
    for _, value in pairs(ADDON.settings.hiddenToys) do
        if value == true then
            return true
        end
    end

    return false
end

local function AddIcon(menuButton, texture, width, height, left, right, top, bottom)
    menuButton:AddInitializer(function(button)
        width = width or 20
        height = height or width or 20

        if button.leftTexture1 and button.fontString then
            local icon = button:AttachTexture()
            icon:SetTexture(texture)
            icon:SetTexCoord(left or 0, right or 1, top or 0, bottom or 1)
            icon:SetSize(width, height)

            icon:ClearAllPoints()
            icon:SetPoint("LEFT", button.leftTexture1, "RIGHT", 3, 0)

            button.fontString:ClearAllPoints()
            button.fontString:SetPoint("LEFT", icon, "RIGHT", 3, -1)
        end
    end)
end

local function setupWithSubmenu(subMenu, settings)
    subMenu:AddInitializer(function(button)
        local settingHasTrue, settingHasFalse = CheckSetting(settings)
        if settingHasTrue and settingHasFalse then
            local dash
            if button.leftTexture2 then
                -- mainline style
                dash = button.leftTexture2
                dash:SetPoint("CENTER", button.leftTexture1, "CENTER", 0, 1)
            else
                -- classic style
                dash = button:AttachTexture()
                dash:SetPoint("CENTER", button.leftTexture1)
                button.leftTexture1:SetAtlas("common-dropdown-ticksquare-classic", true)
            end

            dash:SetAtlas("voicechat-icon-loudnessbar-2", true)
            dash:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
            dash:SetSize(16, 16)
        end
    end)
end

local function CreateFilter(root, text, filterKey, filterSettings, withOnly)
    if not filterSettings then
        filterSettings = ADDON.settings.filter
    end

    local button = root:CreateCheckbox(text, function()
        return filterSettings[filterKey]
    end, function(...)
        filterSettings[filterKey] = not filterSettings[filterKey]
        ADDON:FilterToys()

        return MenuResponse.Refresh
    end)
    if withOnly then
        local onlySettings = true == withOnly and filterSettings or withOnly

        local onlyButton
        button:AddInitializer(function(parentButton, elementDescription, menu)
            onlyButton = MenuTemplates.AttachAutoHideButton(parentButton, "")

            onlyButton:SetNormalFontObject("GameFontHighlight")
            onlyButton:SetHighlightFontObject("GameFontHighlight")
            onlyButton:SetText(" "..ADDON.L.FILTER_ONLY)
            onlyButton:SetSize(onlyButton:GetTextWidth(), parentButton.fontString:GetHeight())
            onlyButton:SetPoint("RIGHT")
            onlyButton:SetPoint("BOTTOM", parentButton.fontString)

            onlyButton:SetScript("OnClick", function()
                setAllSettings(onlySettings, false)
                filterSettings[filterKey] = true
                ADDON:FilterToys()
                menu:SendResponse(elementDescription, MenuResponse.Refresh)
            end)

            -- after click menu gets rerendered. by default the auto button is hidden.
            -- since the button itself isn't properly rendered yet, the mouse is also not yet over it.
            -- and so we wait...
            C_Timer.After(0, function()
                if parentButton:IsMouseOver() then
                    onlyButton:Show()
                end
            end)
        end)
        button:AddResetter(function()
            onlyButton:SetText()
            onlyButton:SetSize(0,0)
            onlyButton:ClearAllPoints()
            onlyButton:SetScript("OnClick", nil)
        end)
    end

    return button
end

local function SetLeftPadding(elementData)
    elementData:AddInitializer(function(button)
        local pad = button:AttachTexture();
        pad:SetSize(18, 10);
        pad:SetPoint("LEFT");

        button.leftTexture1:SetPoint("LEFT", pad, "RIGHT");

        local width = pad:GetWidth() + button.leftTexture1:GetWidth() + button.fontString:GetUnboundedStringWidth()
        return width, button.fontString:GetHeight()
    end)
end

local function CenterDropdownButton(elementData)
    elementData:AddInitializer(function(button)
        button.fontString:ClearAllPoints()
        button.fontString:SetPoint("CENTER")
    end)
end

--region ALL and None
local function AddAllAndNone(root, settings)
    CenterDropdownButton(root:CreateButton(ALL, function()
        SetAllSubFilters(settings, true)
        return MenuResponse.Refresh
    end))
    CenterDropdownButton(root:CreateButton(NONE, function()
        SetAllSubFilters(settings, false)
        return MenuResponse.Refresh
    end))

    root:QueueSpacer()
end
local function registerVerticalLayoutHook()
    hooksecurefunc(AnchorUtil, "VerticalLayout", function(frames, initialAnchor, padding)
        if #frames > 3 and ToyBox and ToyBox:IsShown() then
            local first = frames[1]
            local second = frames[2]
            if first.fontString and first.fontString:GetText() == ALL and second.fontString and second.fontString:GetText() == NONE then
                first:SetSize(first:GetWidth() / 2, first:GetHeight())
                second:SetSize(second:GetWidth() / 2, second:GetHeight())

                second:SetPoint("TOPLEFT", first, "TOPRIGHT", padding, 0)
                frames[3]:SetPoint("TOPLEFT", first, "BOTTOMLEFT", 0, -padding)
            end
        end
    end)
end
--endregion

local function CreateSortRadio(root, text, sortValue)
    local sortSettings = ADDON.settings[SETTING_SORT]

    return root:CreateRadio(text, function()
        return sortSettings.by == sortValue
    end, function()
        sortSettings["by"] = sortValue
        ADDON.DataProvider:Sort()

        return MenuResponse.Refresh
    end)
end
local function CreateSortCheckbox(root, text, sortKey)
    local sortSettings = ADDON.settings[SETTING_SORT]

    return root:CreateCheckbox(text, function()
        return sortSettings[sortKey]
    end, function()
        sortSettings[sortKey] = not sortSettings[sortKey]
        ADDON.DataProvider:Sort()

        return MenuResponse.Refresh
    end)
end
local function SetupSortMenu(root)
    local L = ADDON.L

    CreateSortRadio(root, NAME, 'name')
    CreateSortRadio(root, EXPANSION_FILTER_TEXT, 'expansion')

    root:CreateSpacer()
    CreateSortCheckbox(root, L.SORT_REVERSE, 'descending')
    CreateSortCheckbox(root, L.SORT_FAVORITES_FIRST, 'favoritesFirst')
    CreateSortCheckbox(root, L.SORT_UNOWNED_AFTER, 'unownedAtLast')
    root:CreateSpacer()

    CenterDropdownButton(root:CreateButton(NEWBIE_TOOLTIP_STOPWATCH_RESETBUTTON, function()
        ADDON:ResetSortSettings()
        ADDON.DataProvider:Sort()

        return MenuResponse.CloseAll
    end))
end

local function SetupEffectMenu(root)
    local L = ADDON.L
    local settings = ADDON.settings.filter[SETTING_EFFECT]

    AddAllAndNone(root, settings)

    local sortedEffects, hasSubCategories = {}, {}
    for effect, mainConfig in pairs(ADDON.db.effect) do
        hasSubCategories[effect] = false
        for _, subConfig in pairs(mainConfig) do
            if type(subConfig) == "table" then
                hasSubCategories[effect] = true
            end
            break
        end
        table.insert(sortedEffects, effect)
    end
    table.sort(sortedEffects, function(a, b)
        return (L[a] or a) < (L[b] or b)
    end)

    for _, effect in pairs(sortedEffects) do
        if hasSubCategories[effect] then
            local subMenu = root:CreateCheckbox(L[effect] or effect, function()
                local settingHasTrue, settingHasFalse = CheckSetting(settings[effect])

                return settingHasTrue
            end, function(...)
                local _, settingHasFalse = CheckSetting(settings[effect])
                SetAllSubFilters(settings[effect], settingHasFalse)

                return MenuResponse.Refresh
            end)
            setupWithSubmenu(subMenu, settings[effect])
            local minItem = TableUtil.FindMin(GetKeysArray(select(2, next(ADDON.db.effect[effect]))), function(v) return v end)
            AddIcon(subMenu, C_Item.GetItemIconByID(minItem))

            local sortedSubEffects = {}
            for subeffect, effectIds in pairs(ADDON.db.effect[effect]) do
                table.insert(sortedSubEffects, subeffect)
            end
            table.sort(sortedSubEffects, function(a, b)
                return (L[a] or a) < (L[b] or b)
            end)
            for _, subEffect in pairs(sortedSubEffects) do
                minItem = TableUtil.FindMin(GetKeysArray(ADDON.db.effect[effect][subEffect]), function(v) return v end)
                AddIcon(CreateFilter(subMenu, L[subEffect] or subEffect, subEffect, settings[effect], settings), C_Item.GetItemIconByID(minItem))
            end

        else
            local minItem = TableUtil.FindMin(GetKeysArray(ADDON.db.effect[effect]), function(v) return v end)
            AddIcon(CreateFilter(root, L[effect] or effect, effect, settings, true), C_Item.GetItemIconByID(minItem))
        end
    end
end

local function SetupSourceMenu(root)
    local L = ADDON.L

    local resetSettings = {ADDON.settings.filter[SETTING_SOURCE], ADDON.settings.filter[SETTING_PROFESSION], ADDON.settings.filter[SETTING_WORLD_EVENT]}

    AddAllAndNone(root, resetSettings)

    local professionRoot = root:CreateCheckbox(BATTLE_PET_SOURCE_4, function()
        local settingHasTrue, _ = CheckSetting(ADDON.settings.filter[SETTING_PROFESSION])
        return settingHasTrue
    end, function()
        local _, settingHasFalse = CheckSetting(ADDON.settings.filter[SETTING_PROFESSION])
        SetAllSubFilters(ADDON.settings.filter[SETTING_PROFESSION], settingHasFalse)
        return MenuResponse.Refresh
    end)
    AddIcon(professionRoot, 136241)
    setupWithSubmenu(professionRoot, ADDON.settings.filter[SETTING_PROFESSION])
    AddAllAndNone(professionRoot, ADDON.settings.filter[SETTING_PROFESSION])
    local professionIcons = {
        ["Jewelcrafting"] = 4620677,
        ["Enchanting"] = 4620672,
        ["Engineering"] = 4620673,
        ["Inscription"] = 4620676,
        ["Leatherworking"] = 4620678,
        ["Tailoring"] = 4620681,
        ["Archaeology"] = 441139,
        ["Cooking"] = 4620671,
        ["Fishing"] = 4620674,
    }
    if ADDON.isClassic then
        professionIcons["Engineering"] = 136243
        professionIcons["Fishing"] = 136245
    end
    local professions = GetKeysArray(professionIcons)
    table.sort(professions, function(a, b)
        return (L[a] or a) < (L[b] or b)
    end)
    for _, index in ipairs(professions) do
        if ADDON.db.profession[index] then
            AddIcon(CreateFilter(professionRoot, L[index] or index, index, ADDON.settings.filter[SETTING_PROFESSION], resetSettings), professionIcons[index])
        end
    end

    local worldEventsRoot = root:CreateCheckbox(BATTLE_PET_SOURCE_7, function()
        local settingHasTrue, _ = CheckSetting(ADDON.settings.filter[SETTING_WORLD_EVENT])
        return settingHasTrue
    end, function()
        local _, settingHasFalse = CheckSetting(ADDON.settings.filter[SETTING_WORLD_EVENT])
        SetAllSubFilters(ADDON.settings.filter[SETTING_WORLD_EVENT], settingHasFalse)
        return MenuResponse.Refresh
    end)
    setupWithSubmenu(worldEventsRoot, ADDON.settings.filter[SETTING_WORLD_EVENT])
    AddIcon(worldEventsRoot, 236552)
    AddAllAndNone(worldEventsRoot, ADDON.settings.filter[SETTING_WORLD_EVENT])
    local worldEventIcons = {
        ["Timewalking"] = 5228749,
        ["Darkmoon Faire"] = 134481,
        ["Lunar Festival"] = 236704,
        ["Love is in the Air"] = 368564,
        ["Noblegarden"] = 254858,
        ["Children's Week"] = 236702,
        ["Midsummer Fire Festival"] = 134469,
        ["Secrets of Azeroth"] = 237387,
        ["Brewfest"] = 133201,
        ["Hallow's End"] = 236552,
        ["Day of the Dead"] = 237569,
        ["Pilgrim's Bounty"] = 250626,
        ["Pirates' Day"] = 2055035,
        ["Feast of Winter Veil"] = 133202,
    }
    local worldEventOrder = {
        "Timewalking",
        "Darkmoon Faire",
        "Lunar Festival",
        "Love is in the Air",
        "Noblegarden",
        "Children's Week",
        "Midsummer Fire Festival",
        "Secrets of Azeroth",
        "Brewfest",
        "Hallow's End",
        "Day of the Dead",
        "Pilgrim's Bounty",
        "Pirates' Day",
        "Feast of Winter Veil",
    }
    for _, index in ipairs(worldEventOrder) do
        if ADDON.db.worldEvent[index] then
            AddIcon(CreateFilter(worldEventsRoot, L[index] or index, index, ADDON.settings.filter[SETTING_WORLD_EVENT], resetSettings), worldEventIcons[index])
        end
    end

    local sourceOrder = {
        "Treasure",
        "Drop",
        "Quest",
        "Vendor",
        "Instance",
        "Reputation",
        "Achievement",
        "PvP",
        "Order Hall",
        "Garrison",
        "Pick Pocket",
        "Black Market",
        "Trading Post",
        "Shop",
        "Promotion",
        "Unavailable",
    }
    local sourceIcons = {
        ["Treasure"] = 1064187,
        ["Drop"] = 133639,
        ["Quest"] = 236669,
        ["Vendor"] = 133784,
        ["Instance"] = 254650,
        ["Reputation"] = 236681,
        ["Achievement"] = 255347,
        ["PvP"] = 132487,
        ["Order Hall"] = 1397630,
        ["Garrison"] = 1005027,
        ["Pick Pocket"] = 133644,
        ["Black Market"] = 626190,
        ["Trading Post"] = 4696085,
        ["Shop"] = 1120721,
        ["Promotion"] = 1418621,
        ["Unavailable"] = 132293,
    }
    for _, index in ipairs(sourceOrder) do
        if ADDON.db.source[index] then
            AddIcon(CreateFilter(root, L[index] or index, index, ADDON.settings.filter[SETTING_SOURCE], resetSettings), sourceIcons[index])
        end
    end
end

local function setupExpansionMenu(root)
    local settings = ADDON.settings.filter[SETTING_EXPANSION]
    AddAllAndNone(root, settings)

    -- icons from: https://warcraft.wiki.gg/wiki/Expansion
    local icons = {
        [0] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\00_wow.png",
        [1] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\01_bc.png",
        [2] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\02_wrath.png",
        [3] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\03_cata.png",
        [4] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\04_mists.png",
        [5] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\05_wod.png",
        [6] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\06_legion.png",
        [7] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\07_bfa.png",
        [8] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\08_sl.png",
        [9] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\09_df.png",
        [10] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\10_tww.png",
        [11] = "Interface\\Addons\\ToyBoxEnhanced\\UI\\icons\\expansion\\11_mn.png",
    }
    for i = GetClientDisplayExpansionLevel(), 0,-1 do
        if _G["EXPANSION_NAME" .. i] then
            local button = CreateFilter(root, _G["EXPANSION_NAME" .. i], i, settings, true)
            AddIcon(button, icons[i] or 0, 50, 16, 0.109375, 0.890625, 0, 1)
        end
    end
end

local function SetupFilterMenu(_, root)
    local L = ADDON.L

    root:SetTag("MENU_TOYBOX_FILTER")

    SetupSortMenu(root:CreateButton(RAID_FRAME_SORT_LABEL))

    root:CreateSpacer()

    CreateFilter(root, COLLECTED, SETTING_COLLECTED)
    local favorites = CreateFilter(root, FAVORITES_FILTER, SETTING_ONLY_FAVORITES)
    favorites:SetEnabled(function()
        return ADDON.settings.filter.collected
    end)
    SetLeftPadding(favorites)
    local onlyUsable = CreateFilter(root, PET_JOURNAL_FILTER_USABLE_ONLY, SETTING_ONLY_USEABLE)
    onlyUsable:SetEnabled(function()
        return ADDON.settings.filter.collected
    end)
    SetLeftPadding(onlyUsable)

    CreateFilter(root, NOT_COLLECTED, SETTING_NOT_COLLECTED)
    local hiddenIngame = CreateFilter(root, L.FILTER_SECRET, SETTING_SECRET)
    hiddenIngame:SetEnabled(function()
        return ADDON.settings.filter.notCollected
    end)

    CreateFilter(root, L.FILTER_ONLY_LATEST, SETTING_ONLY_RECENT)
    CreateFilter(root, L.FILTER_ONLY_TRADABLE, SETTING_ONLY_TRADABLE)
    if ADDON.settings.filter[SETTING_HIDDEN] or HasUserHiddenToys() then
        CreateFilter(root, L["FILTER_HIDDEN_MANUAL"], SETTING_HIDDEN)
    end

    root:CreateSpacer()

    SetupEffectMenu(root:CreateButton(L["Effect"]))
    SetupSourceMenu(root:CreateButton(SOURCES))

    local faction = root:CreateButton(FACTION)
    AddIcon(CreateFilter(faction, FACTION_ALLIANCE, "alliance", ADDON.settings.filter[SETTING_FACTION]), ADDON.isRetail and 2173919 or 463450)
    AddIcon(CreateFilter(faction, FACTION_HORDE, "horde", ADDON.settings.filter[SETTING_FACTION]), ADDON.isRetail and 2173920 or 463451)
    AddIcon(CreateFilter(faction, NPC_NAMES_DROPDOWN_NONE, "noFaction", ADDON.settings.filter[SETTING_FACTION]), 0)

    setupExpansionMenu(root:CreateButton(EXPANSION_FILTER_TEXT))

    root:CreateSpacer()

    CenterDropdownButton(root:CreateButton(L["Reset filters"], function()
        ADDON:ResetFilterSettings()
        ADDON:FilterToys()

        return MenuResponse.CloseAll
    end))
end

local function skinElvUI(filterDropdown)
    if ElvUI and ToyBox.PagingFrame.NextPageButton.IsSkinned then
        local E = unpack(ElvUI)
        local S = E:GetModule('Skins')

        S:HandleButton(filterDropdown, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true, 'right')
        filterDropdown:Point('LEFT', ToyBox.searchBox, 'RIGHT', 2, 0)
        S:HandleCloseButton(filterDropdown.ResetButton)
        filterDropdown.ResetButton:ClearAllPoints()
        filterDropdown.ResetButton:Point('CENTER', filterDropdown, 'TOPRIGHT', 0, 0)
    end
end

ADDON.Events:RegisterCallback("OnLoadUI", function()

    local filterDropdown = CreateFrame("DropdownButton", nil, ToyBox, "WowStyle1FilterDropdownTemplate")
    filterDropdown.resizeToText = false

    filterDropdown:SetAllPoints(ToyBox.FilterDropdown)
    filterDropdown:Raise()

    filterDropdown:RegisterEvent("PLAYER_REGEN_ENABLED")
    filterDropdown:RegisterEvent("PLAYER_REGEN_DISABLED")
    filterDropdown:HookScript("OnEvent", function(self, event)
        if event == "PLAYER_REGEN_ENABLED" then
            self:Show()
            ToyBox.FilterDropdown:Hide()
        elseif event == "PLAYER_REGEN_DISABLED" then
            self:Hide()
            ToyBox.FilterDropdown:Show()
        end
    end)
    filterDropdown:SetShown(not InCombatLockdown())
    ToyBox.FilterDropdown:SetShown(InCombatLockdown())

    filterDropdown:SetIsDefaultCallback(function()
        return ADDON.IsUsingDefaultFilters()
    end)
    filterDropdown:SetDefaultCallback(function()
        ADDON:ResetFilterSettings()
        ADDON:FilterToys()
    end)
    filterDropdown:SetupMenu(SetupFilterMenu)

    skinElvUI(filterDropdown)

    ADDON.UI.FilterDropdown = filterDropdown

    registerVerticalLayoutHook()

end, "filter-menu")
