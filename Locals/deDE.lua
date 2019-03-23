local ADDON_NAME, ADDON = ...

if (GetLocale() == 'deDE') then
    local L = ADDON.L or {}

    L["FAVOR_DISPLAYED"] = "Alle Angezeigten Wählen"
    L["FAVOR_PER_CHARACTER"] = "Pro Charakter"
    L["Hidden"] = "Ausgeblendete"
    L["Only usable"] = "Nur benutzbare"
    L["RANDOM_TOY_DESCRIPTION"] = "Das Spielzeug wird zufällig aus den Favoriten ausgewählt."
    L["RANDOM_TOY_TITLE"] = "Zufälliges Lieblingsspielzeug benutzen"
    L["Reset filters"] = "Filter zurücksetzen"
    L["TASK_END"] = "[TBE] Uff! Endlich geschafft."
    L["TASK_FAVOR_START"] = "[TBE] Bitte warten. Deine Spielzeuge werden mit Sternen neu beklebt."
    L["Toys"] = "Spielzeuge"
    L["Usable"] = "Benutzbar"

    -- Settings
    L["SETTING_CURSOR_KEYS"] = "Aktiviere Links- und Rechtspfeiltaste zum Durchblättern"
    L["SETTING_FAVORITE_PER_CHAR"] = "Speichere Favoriten pro Charakter"
    L["SETTING_REPLACE_PROGRESSBAR"] = "Ersetze Fortschrittsbalken mit Erfolgspunkten"

    -- Source
    L["Black Market"] = "Schwarzmarkt"
    L["Enchanting"] = "Verzauberkunst"
    L["Engineering"] = "Ingenieurskunst"
    L["Jewelcrafting"] = "Juwelierskunst"
    L["Leatherworking"] = "Lederverarbeitung"
    L["Order Hall"] = "Ordenshalle"
    L["Pick Pocket"] = "Taschendiebstahl"
    L["Treasure"] = "Schatz"

    -- World Event
    L["Brewfest"] = "Braufest"
    L["Children's Week"] = "Kinderwoche"
    L["Day of the Dead"] = "Tag der Toten"
    L["Feast of Winter Veil"] = "Winterhauchfest"
    L["Hallow's End"] = "Schlotternächte"
    L["Love is in the Air"] = "Liebe liegt in der Luft"
    L["Lunar Festival"] = "Mondfest"
    L["Midsummer Fire Festival"] = "Sonnenwendfest"
    L["Noblegarden"] = "Nobelgartenfest"
    L["Pilgrim's Bounty"] = "Pilgerfreudenfest"
    L["Pirates' Day"] = "Piratentag"

    ADDON.L = L
end