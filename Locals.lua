local _, ADDON = ...

local locale = GetLocale()

ADDON.L = {}
local L = ADDON.L

L["COMPARTMENT_TOOLTIP"] = "|cffeda55fLeft-Click|r to toggle showing the Toy Box.\n|cffeda55fRight-Click|r to open addon options."
L["FAVOR_DISPLAYED"] = "All Displayed"
L["FAVOR_PER_CHARACTER"] = "Per Character"
L["RANDOM_TOY_DESCRIPTION"] = "The toy will be chosen randomly from your favorites."
L["RANDOM_TOY_TITLE"] = "Use Random Favorite Toy"
L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."
L["Reset filters"] = "Reset filters"
L["TASK_END"] = "[TBE] Phew! I'm done."
L["TASK_FAVOR_START"] = "[TBE] Reapplying stars all over your toys. Please wait a few seconds until I'm finished."
L["Toys"] = "Toys"
L["Usable"] = "Usable"
L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"
L["FILTER_ONLY_LATEST"] = "Only latest additions"
L["FILTER_ONLY_TRADABLE"] = "Only tradable"
L["FILTER_SECRET"] = "Hidden in game"
L["FILTER_ONLY"] = "only"
L["SORT_FAVORITES_FIRST"] = "Favorites First"
L["SORT_REVERSE"] = "Reverse Sort"
L["SORT_UNOWNED_AFTER"] = "Unowned at Last"

-- Settings
L["SETTING_CURSOR_KEYS"] = "Enable Left&Right keys to flip pages"
L["SETTING_FAVORITE_PER_CHAR"] = "Favorite toys per character"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Search also in toy description"

-- Source
L["Treasure"] = C_Spell.GetSpellInfo(225652).name
L["Drop"] = BATTLE_PET_SOURCE_1
L["Quest"] = BATTLE_PET_SOURCE_2
L["Vendor"] = BATTLE_PET_SOURCE_3
L["Instance"] = INSTANCE
L["Reputation"] = REPUTATION
L["Achievement"] = BATTLE_PET_SOURCE_6
L["PvP"] = PVP
L["Order Hall"] = "Order Hall"
L["Garrison"] = GARRISON_LOCATION_TOOLTIP
L["Pick Pocket"] = C_Spell.GetSpellInfo(921).name
L["Trading Post"] = BATTLE_PET_SOURCE_12
L["Black Market"] = BLACK_MARKET_AUCTION_HOUSE
L["Promotion"] = BATTLE_PET_SOURCE_10
L["Shop"] = BATTLE_PET_SOURCE_8

-- Professions
L["Archaeology"] = PROFESSIONS_ARCHAEOLOGY
L["Cooking"] = PROFESSIONS_COOKING
L["Enchanting"] = C_Spell.GetSpellInfo(7411).name
L["Engineering"] = C_Spell.GetSpellInfo(4036).name
L["Fishing"] = PROFESSIONS_FISHING
L["Inscription"] = INSCRIPTION
L["Jewelcrafting"] = C_Spell.GetSpellInfo(25229).name
L["Leatherworking"] = C_Spell.GetSpellInfo(2108).name
L["Tailoring"] = C_Spell.GetSpellInfo(3908).name

-- World events
L["Brewfest"] = GetCategoryInfo(162)
L["Children's Week"] = GetCategoryInfo(163)
L["Darkmoon Faire"] = CALENDAR_FILTER_DARKMOON
L["Day of the Dead"] = "Day of the Dead"
L["Feast of Winter Veil"] = GetCategoryInfo(156)
L["Hallow's End"] = GetCategoryInfo(158)
L["Love is in the Air"] = GetCategoryInfo(187)
L["Lunar Festival"] = GetCategoryInfo(160)
L["Midsummer Fire Festival"] = GetCategoryInfo(161)
L["Noblegarden"] = GetCategoryInfo(159)
L["Pilgrim's Bounty"] = GetCategoryInfo(14981)
L["Pirates' Day"] = "Pirates' Day"
L["Secrets of Azeroth"] = "Secrets of Azeroth"
L["Timewalking"] = PLAYER_DIFFICULTY_TIMEWALKER

-- Effects
L["Act"] = "Act"
L["Aircraft"] = "Aircraft"
L["Alcohol"] = "Alcohol"
L["Appearance"] = "Appearance"
L["Ashran"] = WORLD_PVP
L["Banner"] = "Banner"
L["Battle Pet"] = TOOLTIP_BATTLE_PET
L["Bigger"] = "Bigger"
L["Chair"] = "Chair"
L["Cinematics"] = CINEMATICS
L["Clickable"] = "Clickable"
L["Clone"] = "Clone"
L["Co-op"] = "Co-op"
L["Color"] = COLOR
L["Companion"] = COMPANIONS
L["Consumable"] = "Consumable"
L["Controller"] = "Controller"
L["Cooking"] = PROFESSIONS_COOKING
L["Corpse"] = CORPSE
L["Critter"] = BATTLE_PET_NAME_5
L["Dismount"] = BINDING_NAME_DISMOUNT
L["Effect"] = "Effect"
L["Emote"] = EMOTE
L["Environment"] = ENVIRONMENT_SUBHEADER
L["Firework"] = C_Spell.GetSpellInfo(25465).name
L["Fishing"] = PROFESSIONS_FISHING
L["Flight Path"] = FLIGHT_MAP
L["Fly/Fall"] = "Fly/Fall"
L["Food/Water"] = MINIMAP_TRACKING_VENDOR_FOOD
L["Full"] = LOC_TYPE_FULL
L["Game"] = GAME
L["Ground"] = "Ground"
L["Jump"] = NPE_JUMP
L["Hearthstone"] = C_Spell.GetSpellInfo(8690).name
L["Interactable"] = "Interactable"
L["Mail"] = MAIL_LABEL
L["Minor"] = "Minor"
L["Mount"] = MOUNT
L["Music"] = VOICE_MUSIC
L["NPC"] = "NPC"
L["Nearby"] = "Nearby"
L["Other"] = OTHER
L["PVP"] = PVP
L["Pennant"] = "Pennant"
L["Perception"] = ITEM_MOD_PERCEPTION_SHORT
L["Profession"] = BATTLE_PET_SOURCE_4
L["Roll"] = ROLL
L["Running"] = C_Spell.GetSpellInfo(114907).name
L["Skinning"] = C_Spell.GetSpellInfo(8613).name
L["Smaller"] = "Smaller"
L["Solo"] = SOLO
L["Sound"] = SOUND
L["Statue"] = C_Spell.GetSpellInfo(88640).name or C_Spell.GetSpellInfo(74890).name
L["Summon"] = SUMMON
L["Swimming"] = C_Spell.GetSpellInfo(333688).name
L["Target Dummy"] = C_Spell.GetSpellInfo(4071).name
L["Taunt"] = C_Spell.GetSpellInfo(355).name
L["Teleport"] = C_Spell.GetSpellInfo(53053).name
L["Tonk"] = "Tonk"
L["Transform"] = C_Spell.GetSpellInfo(39360).name
L["Transportation"] = "Transportation"
L["Vision"] = "Vision"
L["Voice"] = "Voice"
L["Water Walking"] = C_Spell.GetSpellInfo(546).name
L["Weather"] = PET_BATTLE_WEATHER_LABEL

if locale == "deDE" then
    L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLinksklick|r um Spielzeugsammlung anzuzeigen.
|cffeda55fRechtsklick|r um Addon-Optionen zu öffnen.]=]
L["Day of the Dead"] = "Tag der Toten"
L["FAVOR_DISPLAYED"] = "Alle Angezeigten Wählen"
L["FAVOR_PER_CHARACTER"] = "Pro Charakter"
L["FILTER_HIDDEN_MANUAL"] = "Ausgeblendet von mir"
L["FILTER_ONLY"] = "nur"
L["FILTER_ONLY_LATEST"] = "Nur Neuzugänge"
L["FILTER_ONLY_TRADABLE"] = "Nur handelbare"
L["FILTER_SECRET"] = "Ausgeblendet vom Spiel"
L["Pirates' Day"] = "Piratentag"
L["RANDOM_TOY_DESCRIPTION"] = "Das Spielzeug wird zufällig aus den Favoriten ausgewählt."
L["RANDOM_TOY_LOCKED"] = "Zum freischalten bitte mindestens ein gesammeltes Spielzeug als Favorit setzen."
L["RANDOM_TOY_TITLE"] = "Zufälliges Lieblingsspielzeug benutzen"
L["Reset filters"] = "Filter zurücksetzen"
L["Secrets of Azeroth"] = "Geheimnisse von Azeroth"
L["SORT_FAVORITES_FIRST"] = "Favoriten zuerst"
L["SORT_REVERSE"] = "Sortierung umkehren"
L["SORT_UNOWNED_AFTER"] = "Nicht gesammelt nach hinten"
L["TASK_END"] = "[TBE] Uff! Endlich geschafft."
L["TASK_FAVOR_START"] = "[TBE] Bitte warten. Deine Spielzeuge werden mit Sternen neu beklebt."
L["Toys"] = "Spielzeuge"
L["Usable"] = "Benutzbar"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "Aktiviere Links- und Rechtspfeiltaste zum Durchblättern"
L["SETTING_FAVORITE_PER_CHAR"] = "Speichere Favoriten pro Charakter"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Suche auch im Beschreibungstext"

    -- Source
L["Order Hall"] = "Ordenshalle"

    -- Effects
L["Act"] = "Verhalten"
L["Aircraft"] = "Fluggerät"
L["Alcohol"] = "Alkohol"
L["Appearance"] = "Aussehen"
L["Banner"] = "Banner"
L["Bigger"] = "Größer"
L["Chair"] = "Sitz"
L["Clickable"] = "Anklickbar"
L["Clone"] = "Ebenbild"
L["Consumable"] = "Verbrauchsgut"
L["Controller"] = "Steuerung"
L["Co-op"] = "Kooperativ"
L["Effect"] = "Effekt"
L["Fly/Fall"] = "Flug/Fall"
L["Ground"] = "Bodenobjekt"
L["Interactable"] = "Interagierbar"
L["Minor"] = "Teilweise"
L["Nearby"] = "In der Nähe"
L["NPC"] = "NSC"
L["Pennant"] = "Banner"
L["Smaller"] = "Kleiner"
L["Tonk"] = "Bodenfahrzeug"
L["Transportation"] = "Transport"
L["Vision"] = "Sicht"
L["Voice"] = "Stimme"

elseif locale == "esES" then
    L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fClick-Izquierdo|r para ver/ocultar la colección de monturas.
|cffeda55fClick-Derecho|r para abrir las opciones del addon.]=]
L["Day of the Dead"] = "Día de los Muertos"
L["FAVOR_DISPLAYED"] = "Todo mostrado"
L["FAVOR_PER_CHARACTER"] = "Por jugador"
L["FILTER_HIDDEN_MANUAL"] = "Oculto por mi"
L["FILTER_ONLY"] = "sólo"
L["FILTER_ONLY_LATEST"] = "Sólo los últimos añadidos"
L["FILTER_ONLY_TRADABLE"] = "Sólo comerciable"
L["FILTER_SECRET"] = "Oculto en el juego"
L["Pirates' Day"] = "Día de los Piratas"
L["RANDOM_TOY_DESCRIPTION"] = "El juguete se elegirá al azar de tus favoritos."
L["RANDOM_TOY_LOCKED"] = "Marca al menos un juguete coleccionado para desbloquear."
L["RANDOM_TOY_TITLE"] = "Usa un juguete favorito al azar"
L["Reset filters"] = "Reiniciar Filtros"
L["Secrets of Azeroth"] = "Secretos de Azeroth"
L["SORT_FAVORITES_FIRST"] = "Los favoritos primero"
L["SORT_REVERSE"] = "Ordenación inversa"
L["SORT_UNOWNED_AFTER"] = "Los que no se tienen al final"
L["TASK_END"] = "[TBE] ¡Buff! Acabé."
L["TASK_FAVOR_START"] = "[TBE] Asignando estrellas a todos tus juguetes. Por favor, espera unos segundos hasta que acabe."
L["Toys"] = "Juguetes"
L["Usable"] = "Utilizable"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "Activa los cursores Izquierdo y Derecho para pasar páginas"
L["SETTING_FAVORITE_PER_CHAR"] = "Juguetes favoritos por jugador"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Buscar también en la descripción del juguete"

    -- Source
L["Order Hall"] = "Sede de la Orden"

    -- Effects
L["Act"] = "Actos"
L["Aircraft"] = "Aeronaves"
L["Alcohol"] = "Alcohol"
L["Appearance"] = "Apariencia"
L["Banner"] = "Bandera"
L["Bigger"] = "Mayor"
L["Chair"] = "Sillas"
L["Clickable"] = "Clickables"
L["Clone"] = "Clones"
L["Consumable"] = "Consumibles"
L["Controller"] = "Controladores"
L["Co-op"] = "Co-operativos"
L["Effect"] = "Efecto"
L["Fly/Fall"] = "Voladores"
L["Ground"] = "Terrestres"
L["Interactable"] = "Interactibables"
L["Minor"] = "Menor"
L["Nearby"] = "Cercanos"
L["NPC"] = "NPC"
L["Pennant"] = "Pendiente"
L["Smaller"] = "Más pequeño"
L["Tonk"] = "Tanques"
L["Transportation"] = "Transportes"
L["Vision"] = "Visiones"
L["Voice"] = "Voces"

elseif locale == "esMX" then
    --[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
--[[Translation missing --]]
--[[ L["Day of the Dead"] = "Day of the Dead"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_DISPLAYED"] = "All Displayed"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_PER_CHARACTER"] = "Per Character"--]] 
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_TRADABLE"] = "Only tradable"--]] 
--[[Translation missing --]]
--[[ L["FILTER_SECRET"] = "Hidden in game"--]] 
--[[Translation missing --]]
--[[ L["Pirates' Day"] = "Pirates' Day"--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_DESCRIPTION"] = "The toy will be chosen randomly from your favorites."--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_TITLE"] = "Use Random Favorite Toy"--]] 
--[[Translation missing --]]
--[[ L["Reset filters"] = "Reset filters"--]] 
--[[Translation missing --]]
--[[ L["Secrets of Azeroth"] = "Secrets of Azeroth"--]] 
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_AFTER"] = "Unowned at Last"--]] 
--[[Translation missing --]]
--[[ L["TASK_END"] = "[TBE] Phew! I'm done."--]] 
--[[Translation missing --]]
--[[ L["TASK_FAVOR_START"] = "[TBE] Reapplying stars all over your toys. Please wait a few seconds until I'm finished."--]] 
--[[Translation missing --]]
--[[ L["Toys"] = "Toys"--]] 
--[[Translation missing --]]
--[[ L["Usable"] = "Usable"--]] 

    -- Settings
--[[Translation missing --]]
--[[ L["SETTING_CURSOR_KEYS"] = "Enable Left&Right keys to flip pages"--]] 
--[[Translation missing --]]
--[[ L["SETTING_FAVORITE_PER_CHAR"] = "Favorite toys per character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_IN_DESCRIPTION"] = "Search also in toy description"--]] 

    -- Source
--[[Translation missing --]]
--[[ L["Order Hall"] = "Order Hall"--]] 

    -- Effects
--[[Translation missing --]]
--[[ L["Act"] = "Act"--]] 
--[[Translation missing --]]
--[[ L["Aircraft"] = "Aircraft"--]] 
--[[Translation missing --]]
--[[ L["Alcohol"] = "Alcohol"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Banner"] = "Banner"--]] 
--[[Translation missing --]]
--[[ L["Bigger"] = "Bigger"--]] 
--[[Translation missing --]]
--[[ L["Chair"] = "Chair"--]] 
--[[Translation missing --]]
--[[ L["Clickable"] = "Clickable"--]] 
--[[Translation missing --]]
--[[ L["Clone"] = "Clone"--]] 
--[[Translation missing --]]
--[[ L["Consumable"] = "Consumable"--]] 
--[[Translation missing --]]
--[[ L["Controller"] = "Controller"--]] 
--[[Translation missing --]]
--[[ L["Co-op"] = "Co-op"--]] 
--[[Translation missing --]]
--[[ L["Effect"] = "Effect"--]] 
--[[Translation missing --]]
--[[ L["Fly/Fall"] = "Fly/Fall"--]] 
--[[Translation missing --]]
--[[ L["Ground"] = "Ground"--]] 
--[[Translation missing --]]
--[[ L["Interactable"] = "Interactable"--]] 
--[[Translation missing --]]
--[[ L["Minor"] = "Minor"--]] 
--[[Translation missing --]]
--[[ L["Nearby"] = "Nearby"--]] 
--[[Translation missing --]]
--[[ L["NPC"] = "NPC"--]] 
--[[Translation missing --]]
--[[ L["Pennant"] = "Pennant"--]] 
--[[Translation missing --]]
--[[ L["Smaller"] = "Smaller"--]] 
--[[Translation missing --]]
--[[ L["Tonk"] = "Tonk"--]] 
--[[Translation missing --]]
--[[ L["Transportation"] = "Transportation"--]] 
--[[Translation missing --]]
--[[ L["Vision"] = "Vision"--]] 
--[[Translation missing --]]
--[[ L["Voice"] = "Voice"--]] 

elseif locale == "frFR" then
    --[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
L["Day of the Dead"] = "Jour des morts"
L["FAVOR_DISPLAYED"] = "Tous les affichés"
L["FAVOR_PER_CHARACTER"] = "Par personnage"
L["FILTER_HIDDEN_MANUAL"] = "Caché par moi"
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
L["FILTER_ONLY_LATEST"] = "Uniquement les derniers ajouts"
L["FILTER_ONLY_TRADABLE"] = "Uniquement échangeable"
L["FILTER_SECRET"] = "Caché dans le jeu"
L["Pirates' Day"] = "Jour des pirates"
L["RANDOM_TOY_DESCRIPTION"] = "Le jouet sera choisi au hasard parmi vos favoris."
L["RANDOM_TOY_LOCKED"] = "Marquez au moins un jouet collecté comme favori pour débloquer le bouton."
L["RANDOM_TOY_TITLE"] = "Utiliser un jouet favori au hasard"
L["Reset filters"] = "Réinitialiser les filtres"
L["Secrets of Azeroth"] = "Secrets d’Azeroth"
L["SORT_FAVORITES_FIRST"] = "Favoris en premier"
L["SORT_REVERSE"] = "Tri inversé"
L["SORT_UNOWNED_AFTER"] = "Non possédés en dernier"
L["TASK_END"] = "[MJE] Ouf ! J’ai terminé."
L["TASK_FAVOR_START"] = "[TBE] Ré-application des étoiles sur l’ensemble de vos jouets. Veuillez patienter quelques secondes jusqu’à ce que j’aie terminé."
L["Toys"] = "Jouets"
L["Usable"] = "Utilisable"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "Activer les touches Gauche et Droite pour tourner les pages"
L["SETTING_FAVORITE_PER_CHAR"] = "Jouets préférés par personnage"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Rechercher également dans la description du jouet"

    -- Source
L["Order Hall"] = "Domaine de classe"

    -- Effects
L["Act"] = "Action"
L["Aircraft"] = "Avion"
L["Alcohol"] = "Alcool"
L["Appearance"] = "Apparence"
L["Banner"] = "Bannière"
L["Bigger"] = "Plus gros"
L["Chair"] = "Siège"
L["Clickable"] = "Cliquable"
L["Clone"] = "Clone"
L["Consumable"] = "Consommable"
L["Controller"] = "Manette"
L["Co-op"] = "Coopératif"
L["Effect"] = "Effet"
L["Fly/Fall"] = "Voler/Tomber"
L["Ground"] = "Sol"
L["Interactable"] = "Interactable"
L["Minor"] = "Mineure"
L["Nearby"] = "Proche"
L["NPC"] = "PNJ"
L["Pennant"] = "Pennon"
L["Smaller"] = "Plus petit"
L["Tonk"] = "Tank"
L["Transportation"] = "Transport"
L["Vision"] = "Vision"
L["Voice"] = "Voix"

elseif locale == "itIT" then
    --[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
--[[Translation missing --]]
--[[ L["Day of the Dead"] = "Day of the Dead"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_DISPLAYED"] = "All Displayed"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_PER_CHARACTER"] = "Per Character"--]] 
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_TRADABLE"] = "Only tradable"--]] 
--[[Translation missing --]]
--[[ L["FILTER_SECRET"] = "Hidden in game"--]] 
--[[Translation missing --]]
--[[ L["Pirates' Day"] = "Pirates' Day"--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_DESCRIPTION"] = "The toy will be chosen randomly from your favorites."--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_TITLE"] = "Use Random Favorite Toy"--]] 
--[[Translation missing --]]
--[[ L["Reset filters"] = "Reset filters"--]] 
L["Secrets of Azeroth"] = "Segreti di Azeroth"
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_AFTER"] = "Unowned at Last"--]] 
--[[Translation missing --]]
--[[ L["TASK_END"] = "[TBE] Phew! I'm done."--]] 
--[[Translation missing --]]
--[[ L["TASK_FAVOR_START"] = "[TBE] Reapplying stars all over your toys. Please wait a few seconds until I'm finished."--]] 
--[[Translation missing --]]
--[[ L["Toys"] = "Toys"--]] 
--[[Translation missing --]]
--[[ L["Usable"] = "Usable"--]] 

    -- Settings
--[[Translation missing --]]
--[[ L["SETTING_CURSOR_KEYS"] = "Enable Left&Right keys to flip pages"--]] 
--[[Translation missing --]]
--[[ L["SETTING_FAVORITE_PER_CHAR"] = "Favorite toys per character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_IN_DESCRIPTION"] = "Search also in toy description"--]] 

    -- Source
--[[Translation missing --]]
--[[ L["Order Hall"] = "Order Hall"--]] 

    -- Effects
--[[Translation missing --]]
--[[ L["Act"] = "Act"--]] 
--[[Translation missing --]]
--[[ L["Aircraft"] = "Aircraft"--]] 
--[[Translation missing --]]
--[[ L["Alcohol"] = "Alcohol"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Banner"] = "Banner"--]] 
--[[Translation missing --]]
--[[ L["Bigger"] = "Bigger"--]] 
--[[Translation missing --]]
--[[ L["Chair"] = "Chair"--]] 
--[[Translation missing --]]
--[[ L["Clickable"] = "Clickable"--]] 
--[[Translation missing --]]
--[[ L["Clone"] = "Clone"--]] 
--[[Translation missing --]]
--[[ L["Consumable"] = "Consumable"--]] 
--[[Translation missing --]]
--[[ L["Controller"] = "Controller"--]] 
--[[Translation missing --]]
--[[ L["Co-op"] = "Co-op"--]] 
--[[Translation missing --]]
--[[ L["Effect"] = "Effect"--]] 
--[[Translation missing --]]
--[[ L["Fly/Fall"] = "Fly/Fall"--]] 
--[[Translation missing --]]
--[[ L["Ground"] = "Ground"--]] 
--[[Translation missing --]]
--[[ L["Interactable"] = "Interactable"--]] 
--[[Translation missing --]]
--[[ L["Minor"] = "Minor"--]] 
--[[Translation missing --]]
--[[ L["Nearby"] = "Nearby"--]] 
--[[Translation missing --]]
--[[ L["NPC"] = "NPC"--]] 
--[[Translation missing --]]
--[[ L["Pennant"] = "Pennant"--]] 
--[[Translation missing --]]
--[[ L["Smaller"] = "Smaller"--]] 
--[[Translation missing --]]
--[[ L["Tonk"] = "Tonk"--]] 
--[[Translation missing --]]
--[[ L["Transportation"] = "Transportation"--]] 
--[[Translation missing --]]
--[[ L["Vision"] = "Vision"--]] 
--[[Translation missing --]]
--[[ L["Voice"] = "Voice"--]] 

elseif locale == "koKR" then
    --[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
L["Day of the Dead"] = "망자의 날"
L["FAVOR_DISPLAYED"] = "모두 표시"
L["FAVOR_PER_CHARACTER"] = "캐릭터별 표시"
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_TRADABLE"] = "Only tradable"--]] 
--[[Translation missing --]]
--[[ L["FILTER_SECRET"] = "Hidden in game"--]] 
L["Pirates' Day"] = "해적의 날"
L["RANDOM_TOY_DESCRIPTION"] = "장난감이 즐겨찾기 중 랜덤으로 표시됩니다."
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
L["RANDOM_TOY_TITLE"] = "장난감 즐겨찾기 랜덤 사용"
L["Reset filters"] = "분류 초기화"
L["Secrets of Azeroth"] = "아제로스의 비밀"
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_AFTER"] = "Unowned at Last"--]] 
L["TASK_END"] = "완료!"
L["TASK_FAVOR_START"] = "모든 장난감에 적용합니다. 약간의 시간이 소요됩니다."
L["Toys"] = "장난감"
L["Usable"] = "사용가능"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "왼쪽 오른쪽 키로 페이지를 넘깁니다."
L["SETTING_FAVORITE_PER_CHAR"] = "캐릭터마다 즐겨찾기 설정"
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_IN_DESCRIPTION"] = "Search also in toy description"--]] 

    -- Source
L["Order Hall"] = "연맹 전당"

    -- Effects
--[[Translation missing --]]
--[[ L["Act"] = "Act"--]] 
--[[Translation missing --]]
--[[ L["Aircraft"] = "Aircraft"--]] 
--[[Translation missing --]]
--[[ L["Alcohol"] = "Alcohol"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Banner"] = "Banner"--]] 
--[[Translation missing --]]
--[[ L["Bigger"] = "Bigger"--]] 
--[[Translation missing --]]
--[[ L["Chair"] = "Chair"--]] 
--[[Translation missing --]]
--[[ L["Clickable"] = "Clickable"--]] 
--[[Translation missing --]]
--[[ L["Clone"] = "Clone"--]] 
--[[Translation missing --]]
--[[ L["Consumable"] = "Consumable"--]] 
--[[Translation missing --]]
--[[ L["Controller"] = "Controller"--]] 
--[[Translation missing --]]
--[[ L["Co-op"] = "Co-op"--]] 
--[[Translation missing --]]
--[[ L["Effect"] = "Effect"--]] 
--[[Translation missing --]]
--[[ L["Fly/Fall"] = "Fly/Fall"--]] 
--[[Translation missing --]]
--[[ L["Ground"] = "Ground"--]] 
--[[Translation missing --]]
--[[ L["Interactable"] = "Interactable"--]] 
--[[Translation missing --]]
--[[ L["Minor"] = "Minor"--]] 
--[[Translation missing --]]
--[[ L["Nearby"] = "Nearby"--]] 
--[[Translation missing --]]
--[[ L["NPC"] = "NPC"--]] 
--[[Translation missing --]]
--[[ L["Pennant"] = "Pennant"--]] 
--[[Translation missing --]]
--[[ L["Smaller"] = "Smaller"--]] 
--[[Translation missing --]]
--[[ L["Tonk"] = "Tonk"--]] 
--[[Translation missing --]]
--[[ L["Transportation"] = "Transportation"--]] 
--[[Translation missing --]]
--[[ L["Vision"] = "Vision"--]] 
--[[Translation missing --]]
--[[ L["Voice"] = "Voice"--]] 

elseif locale == "ptBR" then
    --[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
L["Day of the Dead"] = "Dia dos Mortos"
L["FAVOR_DISPLAYED"] = "Tudo Visível"
L["FAVOR_PER_CHARACTER"] = "Por personagem"
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_TRADABLE"] = "Only tradable"--]] 
L["FILTER_SECRET"] = "Oculto no jogo"
L["Pirates' Day"] = "Dia dos Piratas"
L["RANDOM_TOY_DESCRIPTION"] = "O brinquedo será escolhido aleatoriamente entre os favoritos."
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
L["RANDOM_TOY_TITLE"] = "Use um brinquedo favorito aleatório"
L["Reset filters"] = "Redefinir filtros"
L["Secrets of Azeroth"] = "Segredos de Azeroth"
L["SORT_FAVORITES_FIRST"] = "Favoritos primeiro"
L["SORT_REVERSE"] = "Ordem Inversa"
L["SORT_UNOWNED_AFTER"] = "Finalmente sem dono"
L["TASK_END"] = "[TBE] Ufa! Terminei."
L["TASK_FAVOR_START"] = "[TBE] Reaplicando estrelas em todos os seus brinquedos. Por favor, espere alguns segundos até eu terminar."
L["Toys"] = "Brinquedos"
L["Usable"] = "Utilizável"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "Habilite as teclas Esquerda&Direita para virar as páginas"
L["SETTING_FAVORITE_PER_CHAR"] = "Brinquedos favoritos por personagem"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Pesquise também na descrição do brinquedo"

    -- Source
L["Order Hall"] = "Salão de Classe"

    -- Effects
L["Act"] = "Agir"
L["Aircraft"] = "Voar"
L["Alcohol"] = "Álcool"
L["Appearance"] = "Aparência"
L["Banner"] = "Bandeira"
L["Bigger"] = "Maior"
L["Chair"] = "Cadeira"
L["Clickable"] = "Clicável"
L["Clone"] = "Clone"
L["Consumable"] = "Consumível"
L["Controller"] = "Controle"
L["Co-op"] = "Cooperativo"
L["Effect"] = "Efeito"
L["Fly/Fall"] = "Voar/Cair"
L["Ground"] = "Terrestre"
L["Interactable"] = "Interativo"
L["Minor"] = "Menor"
L["Nearby"] = "Próximo"
--[[Translation missing --]]
--[[ L["NPC"] = "NPC"--]] 
L["Pennant"] = "Pingente"
L["Smaller"] = "Pequeno"
L["Tonk"] = "Tonque"
L["Transportation"] = "Transporte"
L["Vision"] = "Visão"
L["Voice"] = "Voz"

elseif locale == "ruRU" then
    --[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
L["Day of the Dead"] = "День мертвых"
L["FAVOR_DISPLAYED"] = "Отображать все"
L["FAVOR_PER_CHARACTER"] = "Для персонажа"
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
L["FILTER_ONLY_LATEST"] = "Только последний патч"
L["FILTER_ONLY_TRADABLE"] = "Только передающиеся"
L["FILTER_SECRET"] = "Скрыто в игре"
L["Pirates' Day"] = "День пиратов"
L["RANDOM_TOY_DESCRIPTION"] = "Игрушка будет выбрана случайно из избранных игрушек"
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
L["RANDOM_TOY_TITLE"] = "Использовать случайную избранную игрушку."
L["Reset filters"] = "Сбросить фильтры"
L["Secrets of Azeroth"] = "Тайны Азерота"
L["SORT_FAVORITES_FIRST"] = "Избранное в первую очередь"
L["SORT_REVERSE"] = "Обратная сортировка"
L["SORT_UNOWNED_AFTER"] = "Бесхозный на последнем месте"
L["TASK_END"] = "[TBE] Дело сделано!"
L["TASK_FAVOR_START"] = "[TBE] Добавление в избранное всех ваших игрушек. Подождите несколько секунд, пока я не закончу."
L["Toys"] = "Игрушки"
L["Usable"] = "Используемые"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "Включить использование кнопок Влево/Вправо для перемещения по страницам"
L["SETTING_FAVORITE_PER_CHAR"] = "Избранные игрушки персонажа"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Искать также в описании игрушки"

    -- Source
L["Order Hall"] = "Классовый оплот"

    -- Effects
L["Act"] = "Действие"
L["Aircraft"] = "Самолет"
L["Alcohol"] = "Алкоголь"
L["Appearance"] = "Внешность"
L["Banner"] = "Баннер"
L["Bigger"] = "Больше"
L["Chair"] = "Стул"
L["Clickable"] = "Кликабельно"
L["Clone"] = "Клон"
L["Consumable"] = "Расходный материал"
L["Controller"] = "Контроллер"
L["Co-op"] = "Кооператив"
L["Effect"] = "Эффект"
L["Fly/Fall"] = "Полет/Падение"
L["Ground"] = "Земля"
L["Interactable"] = "Интерактивный"
L["Minor"] = "Незначительный"
L["Nearby"] = "Рядом"
L["NPC"] = "NPC"
L["Pennant"] = "Вымпел"
L["Smaller"] = "Меньше"
L["Tonk"] = "Тонк"
L["Transportation"] = "Транспорт"
L["Vision"] = "Зрение"
L["Voice"] = "Голос"

elseif locale == "zhCN" then
    --[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
L["Day of the Dead"] = "悼念日"
L["FAVOR_DISPLAYED"] = "所有显示的"
L["FAVOR_PER_CHARACTER"] = "每角色"
L["FILTER_HIDDEN_MANUAL"] = "被我隐藏了"
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
L["FILTER_ONLY_LATEST"] = "仅最新添加"
L["FILTER_ONLY_TRADABLE"] = "只能交易"
L["FILTER_SECRET"] = "隐藏在游戏中"
L["Pirates' Day"] = "海盗日"
L["RANDOM_TOY_DESCRIPTION"] = "玩具将从收藏中随机选择。"
L["RANDOM_TOY_LOCKED"] = "请至少支持一件已收集的玩具来解锁。"
L["RANDOM_TOY_TITLE"] = "使用随机收藏玩具"
L["Reset filters"] = "重置过滤器"
L["Secrets of Azeroth"] = "艾泽拉斯的秘密"
L["SORT_FAVORITES_FIRST"] = "收藏优先"
L["SORT_REVERSE"] = "反向排序"
L["SORT_UNOWNED_AFTER"] = "最后无结果"
L["TASK_END"] = "[TBE] 唷！完成了。"
L["TASK_FAVOR_START"] = "[TBE] 正在给你的玩具重新标星收藏。请等待一会儿直到完成。"
L["Toys"] = "玩具"
L["Usable"] = "可用"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "启用左右键翻页"
L["SETTING_FAVORITE_PER_CHAR"] = "每角色玩具收藏"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "也在玩具描述中搜索"

    -- Source
L["Order Hall"] = "职业大厅"

    -- Effects
L["Act"] = "动作"
L["Aircraft"] = "飞机"
L["Alcohol"] = "酒精"
L["Appearance"] = "外形"
L["Banner"] = "旗帜"
L["Bigger"] = "变大"
L["Chair"] = "椅子"
L["Clickable"] = "可点击"
L["Clone"] = "复制"
L["Consumable"] = "消耗品"
L["Controller"] = "控制器"
L["Co-op"] = "合作模式"
L["Effect"] = "效果"
L["Fly/Fall"] = "飞行/降落"
L["Ground"] = "地面"
L["Interactable"] = "可互动"
L["Minor"] = "轻微的"
L["Nearby"] = "附近的"
L["NPC"] = "NPC"
L["Pennant"] = "三角旗"
L["Smaller"] = "变小"
L["Tonk"] = "坦克"
L["Transportation"] = "交通工具"
L["Vision"] = "视野"
L["Voice"] = "语音"

elseif locale == "zhTW" then
    --[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
L["Day of the Dead"] = "亡者節"
L["FAVOR_DISPLAYED"] = "全部顯示"
L["FAVOR_PER_CHARACTER"] = "每個角色"
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_TRADABLE"] = "Only tradable"--]] 
--[[Translation missing --]]
--[[ L["FILTER_SECRET"] = "Hidden in game"--]] 
L["Pirates' Day"] = "海賊日"
L["RANDOM_TOY_DESCRIPTION"] = "玩具將從最愛中隨機選擇。"
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
L["RANDOM_TOY_TITLE"] = "使用隨機最愛玩具"
L["Reset filters"] = "重設過濾"
--[[Translation missing --]]
--[[ L["Secrets of Azeroth"] = "Secrets of Azeroth"--]] 
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_AFTER"] = "Unowned at Last"--]] 
L["TASK_END"] = "[TBE] 齁我受夠了。"
L["TASK_FAVOR_START"] = "[TBE] 在玩具上重新套上星星。請等待幾秒鐘，直到完成為止。"
L["Toys"] = "玩具"
L["Usable"] = "可用"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "啟用左右鍵可翻轉頁面"
L["SETTING_FAVORITE_PER_CHAR"] = "每個角色最愛的玩具"
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_IN_DESCRIPTION"] = "Search also in toy description"--]] 

    -- Source
L["Order Hall"] = "職業大廳"

    -- Effects
--[[Translation missing --]]
--[[ L["Act"] = "Act"--]] 
--[[Translation missing --]]
--[[ L["Aircraft"] = "Aircraft"--]] 
--[[Translation missing --]]
--[[ L["Alcohol"] = "Alcohol"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Banner"] = "Banner"--]] 
--[[Translation missing --]]
--[[ L["Bigger"] = "Bigger"--]] 
--[[Translation missing --]]
--[[ L["Chair"] = "Chair"--]] 
--[[Translation missing --]]
--[[ L["Clickable"] = "Clickable"--]] 
--[[Translation missing --]]
--[[ L["Clone"] = "Clone"--]] 
--[[Translation missing --]]
--[[ L["Consumable"] = "Consumable"--]] 
--[[Translation missing --]]
--[[ L["Controller"] = "Controller"--]] 
--[[Translation missing --]]
--[[ L["Co-op"] = "Co-op"--]] 
--[[Translation missing --]]
--[[ L["Effect"] = "Effect"--]] 
--[[Translation missing --]]
--[[ L["Fly/Fall"] = "Fly/Fall"--]] 
--[[Translation missing --]]
--[[ L["Ground"] = "Ground"--]] 
--[[Translation missing --]]
--[[ L["Interactable"] = "Interactable"--]] 
--[[Translation missing --]]
--[[ L["Minor"] = "Minor"--]] 
--[[Translation missing --]]
--[[ L["Nearby"] = "Nearby"--]] 
--[[Translation missing --]]
--[[ L["NPC"] = "NPC"--]] 
--[[Translation missing --]]
--[[ L["Pennant"] = "Pennant"--]] 
--[[Translation missing --]]
--[[ L["Smaller"] = "Smaller"--]] 
--[[Translation missing --]]
--[[ L["Tonk"] = "Tonk"--]] 
--[[Translation missing --]]
--[[ L["Transportation"] = "Transportation"--]] 
--[[Translation missing --]]
--[[ L["Vision"] = "Vision"--]] 
--[[Translation missing --]]
--[[ L["Voice"] = "Voice"--]] 

end
