local ADDON_NAME, ADDON = ...

-- WARNING: Also look into ResetUISettings() on new elements

local function BuildCheckBox(parentFrame, text, relativeTo, yOffset)

    local button = CreateFrame("CheckButton", nil, parentFrame, "ChatConfigCheckButtonTemplate")
    button:SetPoint("LEFT", relativeTo, "LEFT", 0, -20 - (yOffset or 0))
    button.Text:SetText("  " .. text)

    return button
end

local function BuildFrame()
    local frame = CreateFrame("Frame")
    local L = ADDON.L

    local titleFont = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    titleFont:SetPoint("TOPLEFT", 10, -15)
    titleFont:SetText(GetAddOnMetadata(ADDON_NAME, "Title"))
    titleFont:SetJustifyH("LEFT")
    titleFont:SetJustifyV("TOP")

    frame.enableCursorKeysCheck = BuildCheckBox(frame, L.SETTING_CURSOR_KEYS, titleFont, 10)
    frame.favoritesPerCharCheck = BuildCheckBox(frame, L.SETTING_FAVORITE_PER_CHAR, frame.enableCursorKeysCheck)
    frame.searchInSpellCheck = BuildCheckBox(frame, L.SETTING_SEARCH_IN_DESCRIPTION, frame.favoritesPerCharCheck)

    return frame
end

local function OKHandler(frame)
    ADDON.settings.enableCursorKeys = frame.enableCursorKeysCheck:GetChecked()
    ADDON.settings.searchInDescription = frame.searchInSpellCheck:GetChecked()

    if ADDON.settings.favoritePerChar ~= frame.favoritesPerCharCheck:GetChecked() then
        ADDON.settings.favoritePerChar = frame.favoritesPerCharCheck:GetChecked()
        if ADDON.settings.favoritePerChar then
            ADDON:CollectFavoredToys()
        end
    end
end

local categoryID

ADDON.Events:RegisterCallback("OnLogin", function()
    local frame = BuildFrame()
    frame.OnRefresh = function()
        frame.enableCursorKeysCheck:SetChecked(ADDON.settings.enableCursorKeys)
        frame.favoritesPerCharCheck:SetChecked(ADDON.settings.favoritePerChar)
        frame.searchInSpellCheck:SetChecked(ADDON.settings.searchInDescription)
    end
    frame.OnCommit = OKHandler
    frame.OnDefault = ADDON.ResetUISettings

    if Settings then
        local category = Settings.RegisterCanvasLayoutCategory(frame, GetAddOnMetadata(ADDON_NAME, "Title") )
        Settings.RegisterAddOnCategory(category)
        categoryID = category.ID
    else
        -- TODO: remove after 10.0 launch
        frame.name = GetAddOnMetadata(ADDON_NAME, "Title")
        frame.refresh = frame.OnRefresh
        frame.okay = frame.OnCommit
        frame.default = frame.OnDefault
        InterfaceOptions_AddCategory(frame)
    end
end, "settings-panel")

function ADDON:OpenSettings()
    if Settings then
        Settings.OpenToCategory(categoryID)
    else
        local title = GetAddOnMetadata(ADDON_NAME, "Title")
        InterfaceOptionsFrame_OpenToCategory(title)
        InterfaceOptionsFrame_OpenToCategory(title)
    end
end