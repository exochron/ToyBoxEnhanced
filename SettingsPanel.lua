local ADDON_NAME, ADDON = ...

local categoryID

ADDON.Events:RegisterCallback("OnLogin", function()
    local L = ADDON.L

    local category = Settings.RegisterVerticalLayoutCategory(C_AddOns.GetAddOnMetadata(ADDON_NAME, "Title"))

    local enableCursorKeysSetting = Settings.RegisterAddOnSetting(category, ADDON_NAME.."_CURSOR_KEYS", "enableCursorKeys",
            ADDON.settings.ui, Settings.VarType.Boolean, L.SETTING_CURSOR_KEYS, Settings.Default.True)
    Settings.CreateCheckbox(category, enableCursorKeysSetting)

    local searchInDescriptionSetting = Settings.RegisterAddOnSetting(category, ADDON_NAME.."_SEARCH_DESCRIPTION", "searchInDescription",
            ADDON.settings.ui, Settings.VarType.Boolean, L.SETTING_SEARCH_IN_DESCRIPTION, Settings.Default.True)
    Settings.CreateCheckbox(category, searchInDescriptionSetting)

    Settings.RegisterAddOnCategory(category)
    categoryID = category.ID
end, "settings-panel")

function ADDON:OpenSettings()
    Settings.OpenToCategory(categoryID)
end