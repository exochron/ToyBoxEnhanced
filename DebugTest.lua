local ADDON_NAME, ADDON = ...

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

local function DebugTest()
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

    testExists(ADDON.db.source, "Source")
    testExists(ADDON.db.profession, "Profession")
    testExists(ADDON.db.worldEvent, "World Event")
    testExists(ADDON.db.effect, "Effect")
end

-- Test for https://www.curseforge.com/wow/addons/toy-box-enhanced/issues/16
local function UnusableTest()
    if (UnitLevel("player") < 50 and C_ToyBox.IsToyUsable(95589)) or C_ToyBox.IsToyUsable(85500) then
        print("TBE: C_ToyBox.IsToyUsable() has been fixed!?")
    end
end

ADDON:RegisterLoginCallback(function()
    if ADDON.settings.debugMode then
        UnusableTest()
    end
end)
ADDON:RegisterLoadUICallback(function()
    if ADDON.settings.debugMode then
        DebugTest()
    end
end)

-- After starting the client fresh the first character doesn't have a fully loaded C_ToyBox on PLAYER_LOGIN
-- (since at least 8.3)
--[[
local test = CreateFrame("Frame")
test:RegisterEvent("PLAYER_LOGIN")
test:SetScript("OnEvent", function(self, event, arg1, arg2)
    print(event, arg1, arg2, C_ToyBox.GetNumFilteredToys()) --prints 20
    C_Timer.After(0, function()
        print('after next frame', C_ToyBox.GetNumFilteredToys()) --prints 638
    end)
end)
]]