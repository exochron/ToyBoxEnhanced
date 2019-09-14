local ADDON_NAME, ADDON = ...

local doStrip = false

local function GetUsableToysCount()
    local usableCount = 0
    for _, itemId in pairs(ADDON.db.ingameList) do
        if PlayerHasToy(itemId) and C_ToyBox.IsToyUsable(itemId) then
            usableCount = usableCount + 1
        end
    end

    return usableCount
end

local function CreateCountFrames()
    local L = ADDON.L

    local toyCountFrame = CreateFrame("Frame", nil, ToyBox, "TBEToyCountTemplate")
    toyCountFrame.staticText:SetText(L["Toys"])
    toyCountFrame.uniqueCount:SetText(C_ToyBox.GetNumLearnedDisplayedToys())
    toyCountFrame:RegisterEvent("TOYS_UPDATED")
    toyCountFrame:SetScript("OnEvent", function(self, event, arg1)
        toyCountFrame.uniqueCount:SetText(C_ToyBox.GetNumLearnedDisplayedToys())
    end)

    local usableToyCountFrame = CreateFrame("Frame", nil, ToyBox, "TBEToyUsableCountTemplate")
    usableToyCountFrame.staticText:SetText(L["Usable"])
    usableToyCountFrame.uniqueCount:SetText(GetUsableToysCount())
    usableToyCountFrame:RegisterEvent("TOYS_UPDATED")
    usableToyCountFrame:SetScript("OnEvent", function(self, event, arg1)
        usableToyCountFrame.uniqueCount:SetText(GetUsableToysCount())
    end)

    if doStrip then
        toyCountFrame:StripTextures()
        usableToyCountFrame:StripTextures()
    end
end

ADDON:RegisterLoadUICallback(CreateCountFrames)

ADDON.UI:RegisterUIOverhaulCallback(function(self)
    if (self == ToyBox.iconsFrame) then
        doStrip = true
    end
end)