local ADDON_NAME, ADDON = ...

if (GetLocale() == 'zhTW') then
    local L = ADDON.L or {}

    L["Hidden"] = "已隱藏"
    L["Only usable"] = "只可用"
    L["Reset filters"] = "重設過濾"
    L["Toys"] = "玩具"
    L["Usable"] = "可用"

    -- Settings

    -- Source
    L["Black Market"] = "黑市"
    L["Enchanting"] = "附魔"
    L["Engineering"] = "工程學"
    L["Jewelcrafting"] = "珠寶設計"
    L["Leatherworking"] = "製皮"
    L["Order Hall"] = "職業大廳"
    L["Pick Pocket"] = "偷竊"
    L["Treasure"] = "寶藏"

    -- World Event
    L["Brewfest"] = "啤酒節"
    L["Children's Week"] = "兒童週"
    L["Day of the Dead"] = "亡者節"
    L["Feast of Winter Veil"] = "冬幕節"
    L["Hallow's End"] = "萬鬼節"
    L["Love is in the Air"] = "愛就在身邊"
    L["Lunar Festival"] = "新年節慶"
    L["Midsummer Fire Festival"] = "仲夏節"
    L["Pilgrim's Bounty"] = "旅人豐年祭"
    L["Pirates' Day"] = "海賊日"

    ADDON.L = L
end