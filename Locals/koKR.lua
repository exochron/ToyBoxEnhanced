local ADDON_NAME, ADDON = ...

if (GetLocale() ~= "koKR") then
    return
end

local L = ADDON.L or {}

L["FAVOR_DISPLAYED"] = "모두 표시"
L["FAVOR_PER_CHARACTER"] = "캐릭터별 표시"
L["Hidden"] = "숨기기"
L["RANDOM_TOY_DESCRIPTION"] = "장난감이 즐겨찾기 중 랜덤으로 표시됩니다."
L["RANDOM_TOY_TITLE"] = "장난감 즐겨찾기 랜덤 사용"
L["Reset filters"] = "분류 초기화"
L["TASK_END"] = "완료!"
L["TASK_FAVOR_START"] = "모든 장난감에 적용합니다. 약간의 시간이 소요됩니다."
L["Toys"] = "장난감"
L["Usable"] = "사용가능"

-- Settings
L["SETTING_CURSOR_KEYS"] = "왼쪽 오른쪽 키로 페이지를 넘깁니다."
L["SETTING_FAVORITE_PER_CHAR"] = "캐릭터마다 즐겨찾기 설정"
L["SETTING_REPLACE_PROGRESSBAR"] = "업적 점수와 진행바를 대체합니다."

-- Source
L["Black Market"] = "암시장 경매장"
L["Enchanting"] = "마법부여"
L["Engineering"] = "기계공학"
L["Jewelcrafting"] = "보석세공"
L["Leatherworking"] = "가죽세공"
L["Order Hall"] = "연맹 전당"
L["Pick Pocket"] = "훔치기"
L["Treasure"] = "보물"

-- World Event
L["Brewfest"] = "가을 축제"
L["Children's Week"] = "어린이 주간"
L["Day of the Dead"] = "망자의 날"
L["Feast of Winter Veil"] = "겨울맞이 축제"
L["Hallow's End"] = "할로윈 축제"
L["Love is in the Air"] = "온누리에 사랑을"
L["Lunar Festival"] = "달의 축제"
L["Midsummer Fire Festival"] = "한여름 불꽃축제"
L["Noblegarden"] = "귀족의 정원"
L["Pilgrim's Bounty"] = "순례자의 감사절"
L["Pirates' Day"] = "해적의 날"
