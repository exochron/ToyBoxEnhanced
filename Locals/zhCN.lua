local ADDON_NAME, ADDON = ...

if (GetLocale() == 'zhCN') then
    local L = ADDON.L or {}

    L["Hidden"] = "已隐藏"
    L["Only usable"] = "只可用"
    L["Toys"] = "玩具"
    L["Usable"] = "可用"

    -- Settings

    -- Source
    L["Black Market"] = "黑市"
    L["Engineering"] = "工程学"
    L["Jewelcrafting"] = "珠宝加工"
    L["Pick Pocket"] = "偷窃"
    L["Treasure"] = "宝藏"

    -- World Event
    L["Brewfest"] = "美酒节"
    L["Children's Week"] = "儿童周"
    L["Feast of Winter Veil"] = "冬幕节"
    L["Hallow's End"] = "万圣节"
    L["Love is in the Air"] = "情人节"
    L["Lunar Festival"] = "春节"
    L["Midsummer Fire Festival"] = "仲夏节"
    L["Pilgrim's Bounty"] = "感恩节"

    ADDON.L = L
end