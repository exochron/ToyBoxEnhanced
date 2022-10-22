local ADDON_NAME, ADDON = ...

local categoryId

local function register(category, setting, name, default)
    return Settings.CreateCheckBox(
            category,
            Settings.RegisterProxySetting(category, setting, ADDON.settings, Settings.VarType.Boolean, name, default)
    )
end

ADDON.Events:RegisterCallback("OnLogin", function()
    local L = ADDON.L
    local category = Settings.RegisterVerticalLayoutCategory(GetAddOnMetadata(ADDON_NAME, "Title"))

    register(category, "enableCursorKeys", L.SETTING_CURSOR_KEYS, Settings.Default.True)
    register(category, "favoritesPerCharCheck", L.SETTING_FAVORITE_PER_CHAR, Settings.Default.False):SetSettingIntercept(function(value)
        if value then
            ADDON:CollectFavoredToys()
        end
        return false
    end)
    register(category, "searchInSpellCheck", L.SETTING_SEARCH_IN_DESCRIPTION, Settings.Default.True)

    Settings.RegisterAddOnCategory(category)
    categoryId = category.ID

end, "settings-panel")

function ADDON:OpenSettings()
    Settings.OpenToCategory(categoryId)
end