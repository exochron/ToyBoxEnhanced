local ADDON_NAME, ADDON = ...

if (GetLocale() == 'zhCN') then
    local L = ADDON.L or {}

    --[[Translation missing --]]
    --[[ L["FAVOR_DISPLAYED"] = "All Displayed"--]]
    --[[Translation missing --]]
    --[[ L["FAVOR_PER_CHARACTER"] = "Per Character"--]]
    L["Hidden"] = "已隐藏"
    L["Only usable"] = "只可用"
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
    L["Toys"] = "玩具"
    L["Usable"] = "可用"

    -- Settings
    --[[Translation missing --]]
    --[[ L["SETTING_CURSOR_KEYS"] = "Enable Left&Right keys to flip pages"--]]
    --[[Translation missing --]]
    --[[ L["SETTING_FAVORITE_PER_CHAR"] = "Favorite toys per character"--]]
    --[[Translation missing --]]
    --[[ L["SETTING_REPLACE_PROGRESSBAR"] = "Replace progress bar with achievement points"--]]

    -- Source
    L["Black Market"] = "黑市"
    --[[Translation missing --]]
    --[[ L["Enchanting"] = "Enchanting"--]]
    L["Engineering"] = "工程学"
    L["Jewelcrafting"] = "珠宝加工"
    --[[Translation missing --]]
    --[[ L["Leatherworking"] = "Leatherworking"--]]
    --[[Translation missing --]]
    --[[ L["Order Hall"] = "Order Hall"--]]
    L["Pick Pocket"] = "偷窃"
    L["Treasure"] = "宝藏"

    -- World Event
    L["Brewfest"] = "美酒节"
    L["Children's Week"] = "儿童周"
    L["Day of the Dead"] = "悼念日"
    L["Feast of Winter Veil"] = "冬幕节"
    L["Hallow's End"] = "万圣节"
    L["Love is in the Air"] = "情人节"
    L["Lunar Festival"] = "春节"
    L["Midsummer Fire Festival"] = "仲夏节"
    L["Noblegarden"] = "复活节"
    L["Pilgrim's Bounty"] = "感恩节"
    L["Pirates' Day"] = "海盗日"

    ADDON.L = L
end