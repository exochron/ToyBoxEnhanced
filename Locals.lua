local _, ADDON = ...

local locale = GetLocale()

ADDON.L = {}
local L = ADDON.L
local GetSpellName = C_Spell.GetSpellName or GetSpellInfo

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
L["Treasure"] = GetSpellName(225652)
L["Drop"] = BATTLE_PET_SOURCE_1
L["Quest"] = BATTLE_PET_SOURCE_2
L["Vendor"] = BATTLE_PET_SOURCE_3
L["Instance"] = INSTANCE
L["Reputation"] = REPUTATION
L["Achievement"] = BATTLE_PET_SOURCE_6
L["PvP"] = PVP
L["Order Hall"] = "Order Hall"
L["Garrison"] = GARRISON_LOCATION_TOOLTIP
L["Pick Pocket"] = GetSpellName(921)
L["Trading Post"] = BATTLE_PET_SOURCE_12
L["Black Market"] = BLACK_MARKET_AUCTION_HOUSE
L["Promotion"] = BATTLE_PET_SOURCE_10
L["Shop"] = BATTLE_PET_SOURCE_8

-- Professions
L["Archaeology"] = PROFESSIONS_ARCHAEOLOGY
L["Cooking"] = PROFESSIONS_COOKING
L["Enchanting"] = GetSpellName(7411)
L["Engineering"] = GetSpellName(4036)
L["Fishing"] = PROFESSIONS_FISHING
L["Inscription"] = INSCRIPTION
L["Jewelcrafting"] = GetSpellName(25229)
L["Leatherworking"] = GetSpellName(2108)
L["Tailoring"] = GetSpellName(3908)

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
L["Firework"] = GetSpellName(25465)
L["Fishing"] = PROFESSIONS_FISHING
L["Fly/Fall"] = "Fly/Fall"
L["Food/Water"] = MINIMAP_TRACKING_VENDOR_FOOD
L["Full"] = LOC_TYPE_FULL
L["Game"] = GAME
L["Ground"] = "Ground"
L["Jump"] = NPE_JUMP
L["Hearthstone"] = GetSpellName(8690)
L["Interactable"] = "Interactable"
L["Mail"] = MAIL_LABEL
L["Maps"] = "Maps"
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
L["Running"] = GetSpellName(114907)
L["Skinning"] = GetSpellName(8613)
L["Smaller"] = "Smaller"
L["Solo"] = SOLO
L["Sound"] = SOUND
L["Statue"] = GetSpellName(88640) or GetSpellName(74890)
L["Summon"] = SUMMON
L["Swimming"] = GetSpellName(333688)
L["Target Dummy"] = GetSpellName(4071)
L["Taunt"] = GetSpellName(355)
L["Teleport"] = GetSpellName(53053)
L["Tonk"] = "Tonk"
L["Transform"] = GetSpellName(39360)
L["Transportation"] = "Transportation"
L["Vision"] = "Vision"
L["Voice"] = "Voice"
L["Water Walking"] = GetSpellName(546)
L["Weather"] = PET_BATTLE_WEATHER_LABEL

if locale == "deDE" then
    --@localization(locale="deDE", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="deDE", namespace="Settings", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="deDE", namespace="Source", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="deDE", namespace="Effects", format="lua_additive_table", handle-unlocalized=comment)@
elseif locale == "esES" then
    --@localization(locale="esES", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="esES", namespace="Settings", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="esES", namespace="Source", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="esES", namespace="Effects", format="lua_additive_table", handle-unlocalized=comment)@
elseif locale == "esMX" then
    --@localization(locale="esMX", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="esMX", namespace="Settings", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="esMX", namespace="Source", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="esMX", namespace="Effects", format="lua_additive_table", handle-unlocalized=comment)@
elseif locale == "frFR" then
    --@localization(locale="frFR", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="frFR", namespace="Settings", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="frFR", namespace="Source", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="frFR", namespace="Effects", format="lua_additive_table", handle-unlocalized=comment)@
elseif locale == "itIT" then
    --@localization(locale="itIT", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="itIT", namespace="Settings", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="itIT", namespace="Source", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="itIT", namespace="Effects", format="lua_additive_table", handle-unlocalized=comment)@
elseif locale == "koKR" then
    --@localization(locale="koKR", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="koKR", namespace="Settings", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="koKR", namespace="Source", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="koKR", namespace="Effects", format="lua_additive_table", handle-unlocalized=comment)@
elseif locale == "ptBR" then
    --@localization(locale="ptBR", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="ptBR", namespace="Settings", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="ptBR", namespace="Source", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="ptBR", namespace="Effects", format="lua_additive_table", handle-unlocalized=comment)@
elseif locale == "ruRU" then
    --@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="ruRU", namespace="Settings", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="ruRU", namespace="Source", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="ruRU", namespace="Effects", format="lua_additive_table", handle-unlocalized=comment)@
elseif locale == "zhCN" then
    --@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="zhCN", namespace="Settings", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="zhCN", namespace="Source", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="zhCN", namespace="Effects", format="lua_additive_table", handle-unlocalized=comment)@
elseif locale == "zhTW" then
    --@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="zhTW", namespace="Settings", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="zhTW", namespace="Source", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="zhTW", namespace="Effects", format="lua_additive_table", handle-unlocalized=comment)@
end