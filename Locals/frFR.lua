local ADDON_NAME, ADDON = ...

if (GetLocale() == 'frFR') then
    local L = ADDON.L or {}

    --[[Translation missing --]]
    --[[ L["FAVOR_DISPLAYED"] = "All Displayed"--]]
    --[[Translation missing --]]
    --[[ L["FAVOR_PER_CHARACTER"] = "Per Character"--]]
    --[[Translation missing --]]
    --[[ L["Hidden"] = "Hidden"--]]
    L["Only usable"] = "Utilisable uniquement"
    --[[Translation missing --]]
    --[[ L["RANDOM_TOY_DESCRIPTION"] = "The toy will be chosen randomly from the favorites."--]]
    --[[Translation missing --]]
    --[[ L["RANDOM_TOY_TITLE"] = "Use Random Favorite Toy"--]]
    --[[Translation missing --]]
    --[[ L["Reset filters"] = "Reset filters"--]]
    --[[Translation missing --]]
    --[[ L["TASK_END"] = "[TBE] Phew! I'm done."--]]
    --[[Translation missing --]]
    --[[ L["TASK_FAVOR_START"] = "[TBE] Reapplying stars all over your toys. Please wait a few seconds until I'm finished."--]]
    L["Toys"] = "Jouets"
    L["Usable"] = "Utilisable"

    -- Settings
    --[[Translation missing --]]
    --[[ L["SETTING_CURSOR_KEYS"] = "Enable Left&Right keys to flip pages"--]]
    --[[Translation missing --]]
    --[[ L["SETTING_FAVORITE_PER_CHAR"] = "Favorite toys per character"--]]
    --[[Translation missing --]]
    --[[ L["SETTING_REPLACE_PROGRESSBAR"] = "Replace progress bar with achievement points"--]]

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
    L["Noblegarden"] = "Le Jardin des nobles"
    L["Pilgrim's Bounty"] = "Bienfaits du pèlerin"
    L["Pirates' Day"] = "Jour des pirates"

    ADDON.L = L
end