local ADDON_NAME, ADDON = ...

local function print(...)
    _G.print("[TBE]", ...)
end

local function FirstTableValue(table)
    for _, value in pairs(table) do
        return value
    end

    return nil
end

local function ContainsItem(data, itemId)
    for _, category in pairs(data) do
        if category[itemId] then
            return true
        end

        if type(FirstTableValue(category)) == "table" and ContainsItem(category, itemId) then
            return true
        end
    end

    return false
end

local function testExists(list, byName)
    for _, source in pairs(list) do
        for itemId, value in pairs(source) do
            if type(value) == "table" then
                testExists(source, byName)
                break
            else
                local id, name = C_ToyBox.GetToyInfo(itemId)
                if not id or not name then
                    print("Old toy (by " .. byName .. "): " .. itemId)
                end
            end
        end
    end
end

local function DatabaseTest()
    for itemId in pairs(ADDON.db.ingameList) do
        if not ContainsItem(ADDON.db.source, itemId)
                and not ContainsItem(ADDON.db.profession, itemId)
                and not ContainsItem(ADDON.db.worldEvent, itemId)
        then
            print("New toy (by Source): " .. itemId .. " " .. (GetItemInfo(itemId) or ''))
        end
        if not ContainsItem(ADDON.db.effect, itemId) then
            print("New toy (by Effect): " .. itemId .. " " .. (GetItemInfo(itemId) or ''))
        end
    end

    if GetExpansionLevel() >= 10 then
        testExists(ADDON.db.source, "Source")
        testExists(ADDON.db.profession, "Profession")
        testExists(ADDON.db.worldEvent, "World Event")
        testExists(ADDON.db.effect, "Effect")
    end
end

-- Test for https://www.curseforge.com/wow/addons/toy-box-enhanced/issues/16
local function UnusableTest()
    if (UnitLevel("player") < 80 and C_ToyBox.IsToyUsable(95589)) then
        print("TBE: C_ToyBox.IsToyUsable() has been fixed!?")
    end
end

ADDON.Events:RegisterCallback("OnLogin", function()
    UnusableTest()
end, "debug")
ADDON.Events:RegisterCallback("PostLoadUI", function()
    DatabaseTest()
end, "debug")
ADDON.Events:RegisterFrameEventAndCallback("PLAYER_ENTERING_WORLD", function(_, isLogin, isReload)
    if isLogin and not isReload then
        print("Thank you for participating in the development of "..ADDON_NAME.."! Your help is really appreciated!")
    end
end, 'hello dev')

-- After starting the client fresh the first character doesn't have a fully loaded C_ToyBox on PLAYER_LOGIN
-- (since at least 8.3)
--[[
local test = CreateFrame("Frame")
test:RegisterEvent("PLAYER_LOGIN")
test:SetScript("OnEvent", function(_, event)
    print(event, C_ToyBox.GetNumFilteredToys(), C_ToyBox.GetNumTotalDisplayedToys()) --prints 20
    C_Timer.After(0, function()
        print('after next frame', C_ToyBox.GetNumFilteredToys(), C_ToyBox.GetNumTotalDisplayedToys()) --prints 638
    end)
end)
--]]