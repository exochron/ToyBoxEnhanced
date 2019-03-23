local ADDON_NAME, ADDON = ...

if (GetLocale() == 'ruRU') then
    local L = ADDON.L or {}

    --[[Translation missing --]]
    --[[ L["FAVOR_DISPLAYED"] = "All Displayed"--]]
    --[[Translation missing --]]
    --[[ L["FAVOR_PER_CHARACTER"] = "Per Character"--]]
    L["Hidden"] = "Скрытые"
    L["Only usable"] = "Только используемые"
    --[[Translation missing --]]
    --[[ L["RANDOM_TOY_DESCRIPTION"] = "The toy will be chosen randomly from the favorites."--]]
    --[[Translation missing --]]
    --[[ L["RANDOM_TOY_TITLE"] = "Use Random Favorite Toy"--]]
    L["Reset filters"] = "Сбросить фильтры"
    --[[Translation missing --]]
    --[[ L["TASK_END"] = "[TBE] Phew! I'm done."--]]
    --[[Translation missing --]]
    --[[ L["TASK_FAVOR_START"] = "[TBE] Reapplying stars all over your toys. Please wait a few seconds until I'm finished."--]]
    L["Toys"] = "Игрушки"
    L["Usable"] = "Используемые"

    -- Settings
    --[[Translation missing --]]
    --[[ L["SETTING_CURSOR_KEYS"] = "Enable Left&Right keys to flip pages"--]]
    --[[Translation missing --]]
    --[[ L["SETTING_FAVORITE_PER_CHAR"] = "Favorite toys per character"--]]
    --[[Translation missing --]]
    --[[ L["SETTING_REPLACE_PROGRESSBAR"] = "Replace progress bar with achievement points"--]]

    -- Source
    L["Black Market"] = "Черный рынок"
    L["Enchanting"] = "Наложение чар"
    L["Engineering"] = "Инженерное дело"
    L["Jewelcrafting"] = "Ювелирное дело"
    L["Leatherworking"] = "Кожевничество"
    --[[Translation missing --]]
    --[[ L["Order Hall"] = "Order Hall"--]]
    L["Pick Pocket"] = "Обыскивание карманов"
    L["Treasure"] = "Сокровище"

    -- World Event
    L["Brewfest"] = "Хмельной Фестиваль"
    L["Children's Week"] = "Детская неделя"
    L["Day of the Dead"] = "День мертвых"
    L["Feast of Winter Veil"] = "Зимний Покров"
    L["Hallow's End"] = "Тыквовин"
    L["Love is in the Air"] = "Любовная лихорадка"
    L["Lunar Festival"] = "Лунный Фестиваль"
    L["Midsummer Fire Festival"] = "Огненный солнцеворот"
    L["Noblegarden"] = "Сад чудес"
    L["Pilgrim's Bounty"] = "Пиршество странников"
    L["Pirates' Day"] = "День пиратов"

    ADDON.L = L
end