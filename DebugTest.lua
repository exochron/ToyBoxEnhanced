local ADDON_NAME, ADDON = ...

local function ContainsItem(data, itemId)
    for _, category in pairs(data) do
        if (category[itemId]) then
            return true
        end
    end

    return false
end

local function DebugTest()
    for _, itemId in pairs(ADDON.db.ingameList) do
        if (not ContainsItem(ADDON.db.source, itemId)
            and not ContainsItem(ADDON.db.profession, itemId)
            and not ContainsItem(ADDON.db.worldEvent, itemId)
        ) then
            print("New toy (by Source): " .. itemId)
        end
    end

    for _, source in pairs(ADDON.db.source) do
        for itemId, _ in pairs(source) do
            if (not C_ToyBox.GetToyInfo(itemId)) then
                print("Old toy (by Source): " .. itemId)
            end
        end
    end
    for _, source in pairs(ADDON.db.profession) do
        for itemId, _ in pairs(source) do
            if (not C_ToyBox.GetToyInfo(itemId)) then
                print("Old toy (by Profession): " .. itemId)
            end
        end
    end
    for _, source in pairs(ADDON.db.worldEvent) do
        for itemId, _ in pairs(source) do
            if (not C_ToyBox.GetToyInfo(itemId)) then
                print("Old toy (by World Event): " .. itemId)
            end
        end
    end
end

ADDON:RegisterLoadUICallback(function()
    if (ADDON.settings.debugMode) then
        DebugTest()
    end
end)