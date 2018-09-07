local ADDON_NAME, ADDON = ...

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
    usableToyCountFrame.uniqueCount:SetText(ADDON:GetUsableToysCount())
    usableToyCountFrame:RegisterEvent("TOYS_UPDATED")
    usableToyCountFrame:SetScript("OnEvent", function(self, event, arg1)
        usableToyCountFrame.uniqueCount:SetText(ADDON:GetUsableToysCount())
    end)
end

ADDON:RegisterLoadUICallback(CreateCountFrames)
