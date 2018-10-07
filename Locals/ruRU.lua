local ADDON_NAME, ADDON = ...

if (GetLocale() == 'ruRU') then
    local L = ADDON.L or {}

    L["Hidden"] = "Скрытые"
    L["Only usable"] = "Только используемые"
    L["Reset filters"] = "Сбросить фильтры"
    L["Toys"] = "Игрушки"
    L["Usable"] = "Используемые"

    -- Settings

    -- Source
    L["Black Market"] = "Черный рынок"
    L["Enchanting"] = "Наложение чар"
    L["Engineering"] = "Инженерное дело"
    L["Jewelcrafting"] = "Ювелирное дело"
    L["Leatherworking"] = "Кожевничество"
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
    L["Pilgrim's Bounty"] = "Пиршество странников"
    L["Pirates' Day"] = "День пиратов"

    ADDON.L = L
end