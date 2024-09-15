local _, ADDON = ...

local function generateText(num, total)
    if num < total then
        return num .. '/' .. total
    end

    return total
end

local function count()
    local total, owned, usable = 0, 0, 0, 0

    for itemId, valid in pairs(ADDON.db.ingameList) do
        if valid or ADDON.settings.filter.secret then
            total = total + 1

            if PlayerHasToy(itemId) then
                owned = owned + 1
                if C_ToyBox.IsToyUsable(itemId) then
                    usable = usable + 1
                end
            end
        end
    end

    return usable, owned, total
end

local function CreateCountFrame(text, counterFunc)
    local frame = CreateFrame("Frame", nil, ToyBox, "InsetFrameTemplate3")

    frame:ClearAllPoints()
    frame:SetPoint("TOPLEFT", ToyBox, 70, -22)
    frame:SetSize(130, 19)
    if frame.StripTextures and ToyBox.PagingFrame.NextPageButton.IsSkinned then
        frame:StripTextures()
    end

    frame.label = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    frame.label:ClearAllPoints()
    frame.label:SetPoint("LEFT", frame, 10, 0)
    frame.label:SetText(text)

    frame.counter = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    frame.counter:ClearAllPoints()
    frame.counter:SetPoint("RIGHT", frame, -10, 0)
    frame.counter:SetText(generateText(counterFunc(frame)))

    frame:RegisterEvent("TOYS_UPDATED")
    frame:SetScript("OnEvent", function()
        frame.counter:SetText(generateText(counterFunc(frame)))
    end)

    return frame
end

ADDON.Events:RegisterCallback("OnLoadUI", function ()
    local L = ADDON.L

    local updateToysFrame = function(frame)
        local dataProvider = ADDON.DataProvider
        local displayCount = dataProvider:GetSize()
        local _, owned, total = count()

        if displayCount == 0 or displayCount == total then
            frame.label:SetText(L["Toys"])
            return owned, total
        end

        local collectedFilter = 0
        dataProvider:ForEach(function(itemId)
            if PlayerHasToy(itemId) then
                collectedFilter = collectedFilter + 1
            end
        end)

        frame.label:SetText(FILTER)
        return collectedFilter, displayCount
    end
    local toysFrame = CreateCountFrame(L["Toys"], updateToysFrame)
    ADDON.Events:RegisterCallback("OnFiltered", function ()
        toysFrame.counter:SetText(generateText(updateToysFrame(toysFrame)))
    end, "filtered-count")

    CreateCountFrame(L["Usable"], count):SetPoint("TOPLEFT", ToyBox, 70, -41)

end, "count")
