local ADDON_NAME, ADDON = ...

if (GetLocale() == 'deDE') then
    local L = ADDON.L or {}

    L["Toys"] = "Spielzeuge"
    L["Usable"] = "Benutzbar"
    L["Hidden"] = "Ausgeblendete"
    L["Only usable"] = "Nur benutzbare"
    L["Reset filters"] = "Filter zurücksetzen"

    -- Source
    L["Treasure"] = "Schatz"
    L["Order Hall"] = "Ordenshalle"
    L["Pick Pocket"] = "Taschendiebstahl"
    L["Black Market"] = "Schwarzmarkt"

    -- Profession
    L["Jewelcrafting"] = "Juwelierskunst"
    L["Engineering"] = "Ingenieurskunst"
    L["Leatherworking"] = "Lederverarbeitung"
    L["Enchanting"] = "Verzauberkunst"

    -- World Event
    L["Lunar Festival"] = "Mondfest"
    L["Love is in the Air"] = "Liebe liegt in der Luft"
    L["Children's Week"] = "Kinderwoche"
    L["Midsummer Fire Festival"] = "Sonnenwendfest"
    L["Brewfest"] = "Braufest"
    L["Hallow's End"] = "Schlotternächte"
    L["Day of the Dead"] = "Tag der Toten"
    L["Pilgrim's Bounty"] = "Pilgerfreudenfest"
    L["Pirates' Day"] = "Piratentag"
    L["Feast of Winter Veil"] = "Winterhauchfest"

    ADDON.L = L
end