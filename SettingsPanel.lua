local ADDON_NAME, ADDON = ...

-- LATER: use vertical Settings layout, when apis are same in classic and retail (e.g. Settings.RegisterAddOnSetting; Settings.CreateCheckBox != Settings.CreateCheckbox)

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
    titleFont:SetText(C_AddOns.GetAddOnMetadata(ADDON_NAME, "Title"))
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

    local category = Settings.RegisterCanvasLayoutCategory(frame, C_AddOns.GetAddOnMetadata(ADDON_NAME, "Title") )
    Settings.RegisterAddOnCategory(category)
    categoryID = category.ID
end, "settings-panel")

function ADDON:OpenSettings()
    Settings.OpenToCategory(categoryID)
end