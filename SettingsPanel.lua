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

    local titleFont = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    titleFont:SetPoint("TOPLEFT", 22, -22)
    titleFont:SetText(GetAddOnMetadata(ADDON_NAME, "Title"))

    frame.replaceBarCheck = BuildCheckBox(frame, L.SETTING_REPLACE_PROGRESSBAR, titleFont, 10)
    frame.enableCursorKeysCheck = BuildCheckBox(frame, L.SETTING_CURSOR_KEYS, frame.replaceBarCheck)

    return frame
end

local function OKHandler(frame)
    local reload
    ADDON.settings.enableCursorKeys = frame.enableCursorKeysCheck:GetChecked()

    if (ADDON.settings.replaceProgressBar ~= frame.replaceBarCheck:GetChecked()) then
        ADDON.settings.replaceProgressBar = frame.replaceBarCheck:GetChecked()
        reload = true
    end
    if reload and ADDON.initialized then
        ReloadUI()
    end
end

ADDON:RegisterLoginCallback(function()
    local frame = BuildFrame()
    frame.name = GetAddOnMetadata(ADDON_NAME, "Title")
    frame.refresh = function(frame)
        frame.replaceBarCheck:SetChecked(ADDON.settings.replaceProgressBar)
        frame.enableCursorKeysCheck:SetChecked(ADDON.settings.enableCursorKeys)
    end
    frame.okay = OKHandler
    frame.default = ADDON.ResetUISettings
    InterfaceOptions_AddCategory(frame)
end)