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

        button:AddInitializer(function(button, elementDescription, menu)
            local onlyButton = MenuTemplates.AttachAutoHideButton(button, "")

            onlyButton:SetNormalFontObject("GameFontHighlight")
            onlyButton:SetHighlightFontObject("GameFontHighlight")
            onlyButton:SetText(ADDON.L.FILTER_ONLY)
            onlyButton:SetSize(onlyButton:GetTextWidth(), 20)
            onlyButton:SetPoint("RIGHT")

            onlyButton:SetScript("OnClick", function(self, ...)
                setAllSettings(onlySettings, false)
                filterSettings[filterKey] = true
                ADDON:FilterToys()
                menu:SendResponse(elementDescription, MenuResponse.Refresh)
            end)

            -- after click menu gets rerendered. by default the auto button is hidden.
            -- since the button itself isn't properly rendered yet, the mouse is also not yet over it.
            -- and so we wait...
            C_Timer.After(0, function()
                if button:IsMouseOver() then
                    onlyButton:Show()
                end
            end)
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
            subMenu:AddInitializer(function(button)
                if button.leftTexture2 then
                    local settingHasTrue, settingHasFalse = CheckSetting(settings[effect])
                    if settingHasTrue and settingHasFalse then
                        -- TODO: proper indeterminate icon. like: https://css-tricks.com/indeterminate-checkboxes/
                        button.leftTexture2:SetAtlas("common-dropdown-icon-radialtick-yellow-classic", TextureKitConstants.UseAtlasSize)
                        button.leftTexture2:SetAtlas("common-dropdown-icon-radialtick-yellow", TextureKitConstants.UseAtlasSize)
                    else
                        button.leftTexture2:SetAtlas("common-dropdown-icon-checkmark-yellow-classic", TextureKitConstants.UseAtlasSize)
                        button.leftTexture2:SetAtlas("common-dropdown-icon-checkmark-yellow", TextureKitConstants.UseAtlasSize)
                    end
                end
            end)
            local sortedSubEffects = {}
            for subeffect, effectIds in pairs(ADDON.db.effect[effect]) do
                table.insert(sortedSubEffects, subeffect)
            end
            table.sort(sortedSubEffects, function(a, b)
                return (L[a] or a) < (L[b] or b)
            end)
            for _, subfamily in pairs(sortedSubEffects) do
                CreateFilter(subMenu, L[subfamily] or subfamily, subfamily, settings[effect], settings)
            end

        else
            CreateFilter(root, L[effect] or effect, effect, settings, true)
        end
    end
end

local function SetupSourceMenu(root)
    local resetSettings = {ADDON.settings.filter[SETTING_SOURCE], ADDON.settings.filter[SETTING_PROFESSION], ADDON.settings.filter[SETTING_WORLD_EVENT]}

    AddAllAndNone(root, resetSettings)

    local professions = root:CreateCheckbox(BATTLE_PET_SOURCE_4, function()
        local settingHasTrue, settingHasFalse = CheckSetting(ADDON.settings.filter[SETTING_PROFESSION])
        return settingHasTrue
    end, function()
        local _, settingHasFalse = CheckSetting(ADDON.settings.filter[SETTING_PROFESSION])
        SetAllSubFilters(ADDON.settings.filter[SETTING_PROFESSION], settingHasFalse)
        return MenuResponse.Refresh
    end)
    professions:AddInitializer(function(button)
        if button.leftTexture2 then
            local settingHasTrue, settingHasFalse = CheckSetting(ADDON.settings.filter[SETTING_PROFESSION])
            if settingHasTrue and settingHasFalse then
                -- TODO: proper indeterminate icon. like: https://css-tricks.com/indeterminate-checkboxes/
                button.leftTexture2:SetAtlas("common-dropdown-icon-radialtick-yellow-classic", TextureKitConstants.UseAtlasSize)
                button.leftTexture2:SetAtlas("common-dropdown-icon-radialtick-yellow", TextureKitConstants.UseAtlasSize)
            else
                button.leftTexture2:SetAtlas("common-dropdown-icon-checkmark-yellow-classic", TextureKitConstants.UseAtlasSize)
                button.leftTexture2:SetAtlas("common-dropdown-icon-checkmark-yellow", TextureKitConstants.UseAtlasSize)
            end
        end
    end)
    AddAllAndNone(professions, ADDON.settings.filter[SETTING_PROFESSION])
    local professionOrder = {
        "Jewelcrafting",
        "Enchanting",
        "Engineering",
        "Inscription",
        "Leatherworking",
        "Tailoring",
        "Archaeology",
        "Cooking",
        "Fishing",
    }
    for _, index in ipairs(professionOrder) do
        CreateFilter(professions, ADDON.L[index], index, ADDON.settings.filter[SETTING_PROFESSION], resetSettings)
    end

    local worldEvents = root:CreateCheckbox(BATTLE_PET_SOURCE_7, function()
        local settingHasTrue, settingHasFalse = CheckSetting(ADDON.settings.filter[SETTING_WORLD_EVENT])
        return settingHasTrue
    end, function()
        local _, settingHasFalse = CheckSetting(ADDON.settings.filter[SETTING_WORLD_EVENT])
        SetAllSubFilters(ADDON.settings.filter[SETTING_WORLD_EVENT], settingHasFalse)
        return MenuResponse.Refresh
    end)
    worldEvents:AddInitializer(function(button)
        if button.leftTexture2 then
            local settingHasTrue, settingHasFalse = CheckSetting(ADDON.settings.filter[SETTING_WORLD_EVENT])
            if settingHasTrue and settingHasFalse then
                -- TODO: proper indeterminate icon. like: https://css-tricks.com/indeterminate-checkboxes/
                button.leftTexture2:SetAtlas("common-dropdown-icon-radialtick-yellow-classic", TextureKitConstants.UseAtlasSize)
                button.leftTexture2:SetAtlas("common-dropdown-icon-radialtick-yellow", TextureKitConstants.UseAtlasSize)
            else
                button.leftTexture2:SetAtlas("common-dropdown-icon-checkmark-yellow-classic", TextureKitConstants.UseAtlasSize)
                button.leftTexture2:SetAtlas("common-dropdown-icon-checkmark-yellow", TextureKitConstants.UseAtlasSize)
            end
        end
    end)
    AddAllAndNone(worldEvents, ADDON.settings.filter[SETTING_WORLD_EVENT])
    local eventOrder = {
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
    for _, index in ipairs(eventOrder) do
        CreateFilter(worldEvents, ADDON.L[index], index, ADDON.settings.filter[SETTING_WORLD_EVENT], resetSettings)
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
        "Trading Post",
        "Black Market",
        "Promotion",
        "Shop",
    }
    for _, index in ipairs(sourceOrder) do
        CreateFilter(root, ADDON.L[index], index, ADDON.settings.filter[SETTING_SOURCE], resetSettings)
    end
end

local function SetupFilterMenu(dropdown, root)
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
    SetLeftPadding(hiddenIngame)

    CreateFilter(root, L.FILTER_ONLY_LATEST, SETTING_ONLY_RECENT)
    CreateFilter(root, L.FILTER_ONLY_TRADABLE, SETTING_ONLY_TRADABLE)
    if ADDON.settings.filter[SETTING_HIDDEN] or HasUserHiddenToys() then
        CreateFilter(root, L["FILTER_HIDDEN_MANUAL"], SETTING_HIDDEN)
    end

    root:CreateSpacer()

    SetupEffectMenu(root:CreateButton(L["Effect"]))
    SetupSourceMenu(root:CreateButton(SOURCES))

    local faction = root:CreateButton(FACTION)
    CreateFilter(faction, FACTION_ALLIANCE, "alliance", ADDON.settings.filter[SETTING_FACTION])
    CreateFilter(faction, FACTION_HORDE, "horde", ADDON.settings.filter[SETTING_FACTION])
    CreateFilter(faction, NPC_NAMES_DROPDOWN_NONE, "noFaction", ADDON.settings.filter[SETTING_FACTION])

    local expansions = root:CreateButton(EXPANSION_FILTER_TEXT)
    AddAllAndNone(expansions, ADDON.settings.filter[SETTING_EXPANSION])
    --todo: use expansion icons/textures
    for i = GetClientDisplayExpansionLevel(), 0,-1 do
        if _G["EXPANSION_NAME" .. i] then
            CreateFilter(expansions, _G["EXPANSION_NAME" .. i], i, ADDON.settings.filter[SETTING_EXPANSION], true)
        end
    end

    root:CreateSpacer()

    CenterDropdownButton(root:CreateButton(L["Reset filters"], function()
        ADDON:ResetFilterSettings()
        ADDON:FilterToys()

        return MenuResponse.CloseAll
    end))
end

ADDON.Events:RegisterCallback("OnLoadUI", function()

    ToyBox.FilterDropdown:SetIsDefaultCallback(function()
        return ADDON.IsUsingDefaultFilters()
    end)
    ToyBox.FilterDropdown:SetDefaultCallback(function()
        ADDON:ResetFilterSettings()
        ADDON:FilterToys()
    end)
    ToyBox.FilterDropdown:SetupMenu(SetupFilterMenu)

    registerVerticalLayoutHook()

end, "filter-menu")
