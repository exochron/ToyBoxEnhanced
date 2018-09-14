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
    local toyCount = C_ToyBox.GetNumTotalDisplayedToys()
    for toyIndex = 1, toyCount do
        local itemId = ADDON:GetToyInfoOfOriginalIndex(toyIndex)
        if (not ContainsItem(ADDON.ToyBoxEnhancedSource, itemId)
                and not ContainsItem(ADDON.ToyBoxEnhancedProfession, itemId)
                and not ContainsItem(ADDON.ToyBoxEnhancedWorldEvent, itemId)) then
            print("New toy (by Source): " .. itemId)
        end
    end

    for _, source in pairs(ADDON.ToyBoxEnhancedSource) do
        for itemId, _ in pairs(source) do
            if (not C_ToyBox.GetToyInfo(itemId)) then
                print("Old toy (by Source): " .. itemId)
            end
        end
    end
    for _, source in pairs(ADDON.ToyBoxEnhancedProfession) do
        for itemId, _ in pairs(source) do
            if (not C_ToyBox.GetToyInfo(itemId)) then
                print("Old toy (by Profession): " .. itemId)
            end
        end
    end
    for _, source in pairs(ADDON.ToyBoxEnhancedWorldEvent) do
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