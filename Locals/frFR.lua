local ADDON_NAME, ADDON = ...

if (GetLocale() == 'frFR') then
    local L = ADDON.L or {}

    L["Only usable"] = "Utilisable uniquement"
    L["Toys"] = "Jouets"
    L["Usable"] = "Utilisable"

    -- Settings

    -- Source
    L["Black Market"] = "Marché noir"
    L["Enchanting"] = "Enchantement"
    L["Engineering"] = "Ingénierie"
    L["Jewelcrafting"] = "Joaillerie"
    L["Leatherworking"] = "Travail du cuir"
    L["Order Hall"] = "Domaine de classe"
    L["Pick Pocket"] = "Vol à la tire"
    L["Treasure"] = "Trésor"

    -- World Event
    L["Brewfest"] = "Fête des Brasseurs"
    L["Children's Week"] = "Semaine des enfants"
    L["Day of the Dead"] = "Jour des morts"
    L["Feast of Winter Veil"] = "Voile d'hiver"
    L["Hallow's End"] = "Sanssaint"
    L["Love is in the Air"] = "De l'amour dans l'air"
    L["Lunar Festival"] = "Fête lunaire"
    L["Midsummer Fire Festival"] = "Fête du feu du solstice d'été"
    L["Pilgrim's Bounty"] = "Bienfaits du pèlerin"
    L["Pirates' Day"] = "Jour des pirates"

    ADDON.L = L
end