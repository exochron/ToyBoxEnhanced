local _, ADDON = ...

-- todo: update with filter (like mje)

local function CreateCountFrame(text, counterFunc)
    local frame = CreateFrame("Frame", nil, ToyBox, "InsetFrameTemplate3")

    frame:ClearAllPoints()
    frame:SetPoint("TOPLEFT", ToyBox, 70, -22)
    frame:SetSize(130, 19)
    if frame.StripTextures and ToyBox.PagingFrame.NextPageButton.IsSkinned then
        frame:StripTextures()
    end

    local staticText = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    staticText:ClearAllPoints()
    staticText:SetPoint("LEFT", frame, 10, 0)
    staticText:SetText(text)

    local uniqueCount = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    uniqueCount:ClearAllPoints()
    uniqueCount:SetPoint("RIGHT", frame, -10, 0)
    uniqueCount:SetText(counterFunc())

    frame:RegisterEvent("TOYS_UPDATED")
    frame:SetScript("OnEvent", function()
        uniqueCount:SetText(counterFunc())
    end)

    return frame
end

local function GetUsableToysCount()
    local usableCount = 0
    for itemId in pairs(ADDON.db.ingameList) do
        if PlayerHasToy(itemId) and C_ToyBox.IsToyUsable(itemId) then
            usableCount = usableCount + 1
        end
    end

    return usableCount
end

ADDON.Events:RegisterCallback("OnLoadUI", function ()
    local L = ADDON.L
    CreateCountFrame(L["Toys"], C_ToyBox.GetNumLearnedDisplayedToys)
    CreateCountFrame(L["Usable"], GetUsableToysCount):SetPoint("TOPLEFT", ToyBox, 70, -41)
end, "count")
