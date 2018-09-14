local ADDON_NAME, ADDON = ...

if (GetLocale() == 'ruRU') then
    local L = ADDON.L or {}

    L["Toys"] = "Игрушки"
    L["Usable"] = "Используемые"
    L["Hidden"] = "Скрытые"
    L["Only usable"] = "Только используемые"
    L["Reset filters"] = "Сбросить фильтры"

    -- Source
    L["Treasure"] = "Сокровище"
    L["Order Hall"] = "Оплот класса"
    L["Pick Pocket"] = "Обыскивание карманов"
    L["Black Market"] = "Черный рынок"

    -- Profession
    L["Jewelcrafting"] = "Ювелирное дело"
    L["Engineering"] = "Инженерное дело"
    L["Leatherworking"] = "Кожевничество"
    L["Enchanting"] = "Наложение чар"

    -- World Event
    L["Lunar Festival"] = "Лунный Фестиваль"
    L["Love is in the Air"] = "Любовная лихорадка"
    L["Children's Week"] = "Детская неделя"
    L["Midsummer Fire Festival"] = "Огненный солнцеворот"
    L["Brewfest"] = "Хмельной Фестиваль"
    L["Hallow's End"] = "Тыквовин"
    L["Day of the Dead"] = "День мертвых"
    L["Pilgrim's Bounty"] = "Пиршество странников"
    L["Pirates' Day"] = "День пиратов"
    L["Feast of Winter Veil"] = "Зимний Покров"

    ADDON.L = L
end