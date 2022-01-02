local _, ADDON = ...

local locale = GetLocale()

ADDON.L = {}
local L = ADDON.L

L["FAVOR_DISPLAYED"] = "All Displayed"
L["FAVOR_PER_CHARACTER"] = "Per Character"
L["Hidden"] = "Hidden"
L["RANDOM_TOY_DESCRIPTION"] = "The toy will be chosen randomly from the favorites."
L["RANDOM_TOY_TITLE"] = "Use Random Favorite Toy"
L["Reset filters"] = "Reset filters"
L["TASK_END"] = "[TBE] Phew! I'm done."
L["TASK_FAVOR_START"] = "[TBE] Reapplying stars all over your toys. Please wait a few seconds until I'm finished."
L["Toys"] = "Toys"
L["Usable"] = "Usable"
L["Day of the Dead"] = "Day of the Dead"
L["Pirates' Day"] = "Pirates' Day"
L["SORT_FAVORITES_FIRST"] = "Favorites First"
L["SORT_REVERSE"] = "Reverse Sort"
L["SORT_UNOWNED_AFTER"] = "Unowned at Last"
L["FILTER_SECRET"] = "Hidden in game"
L["FILTER_ONLY_TRADABLE"] = "Only tradable"
L["FILTER_ONLY_LATEST"] = "Only latest additions"

-- Settings
L["SETTING_CURSOR_KEYS"] = "Enable Left&Right keys to flip pages"
L["SETTING_FAVORITE_PER_CHAR"] = "Favorite toys per character"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Search also in toy description"

-- Source
L["Black Market"] = "Black Market"
L["Order Hall"] = "Order Hall"

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
L["Clickable"] = "Clickable"
L["Clone"] = "Clone"
L["Co-op"] = "Co-op"
L["Color"] = COLOR
L["Consumable"] = "Consumable"
L["Controller"] = "Controller"
L["Cooking"] = PROFESSIONS_COOKING
L["Corpse"] = CORPSE
L["Critter"] = BATTLE_PET_NAME_5
L["Dismount"] = BINDING_NAME_DISMOUNT
L["Effect"] = "Effect"
L["Emote"] = EMOTE
L["Environment"] = ENVIRONMENT_SUBHEADER
L["Firework"] = GetSpellInfo(25465)
L["Fishing"] = PROFESSIONS_FISHING
L["Flight Path"] = "Flight Path"
L["Fly/Fall"] = "Fly/Fall"
L["Food/Water"] = MINIMAP_TRACKING_VENDOR_FOOD
L["Full"] = LOC_TYPE_FULL
L["Game"] = GAME
L["Ground"] = "Ground"
L["Jump"] = NPE_JUMP
L["Hearthstone"] = GetSpellInfo(8690)
L["Interactable"] = "Interactable"
L["Mail"] = MAIL_LABEL
L["Minor"] = "Minor"
L["Music"] = VOICE_MUSIC
L["NPC"] = "NPC"
L["Nearby"] = "Nearby"
L["Other"] = OTHER
L["PVP"] = PVP
L["Pennant"] = "Pennant"
L["Perception"] = "Perception"
L["Profession"] = BATTLE_PET_SOURCE_4
L["Roll"] = ROLL
L["Running"] = GetSpellInfo(114907)
L["Skinning"] = GetSpellInfo(8613)
L["Smaller"] = "Smaller"
L["Solo"] = SOLO
L["Sound"] = SOUND
L["Statue"] = GetSpellInfo(88640)
L["Summon"] = SUMMON
L["Swimming"] = GetSpellInfo(333688)
L["Target Dummy"] = GetSpellInfo(4071)
L["Taunt"] = GetSpellInfo(355)
L["Teleport"] = GetSpellInfo(343127)
L["Tonk"] = "Tonk"
L["Transform"] = GetSpellInfo(39360)
L["Transportation"] = "Transportation"
L["Vision"] = "Vision"
L["Voice"] = "Voice"
L["Water Walking"] = GetSpellInfo(546)
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
elseif locale == "frFR" then
    --@localization(locale="frFR", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="frFR", namespace="Settings", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="frFR", namespace="Source", format="lua_additive_table", handle-unlocalized=comment)@
    --@localization(locale="frFR", namespace="Effects", format="lua_additive_table", handle-unlocalized=comment)@
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