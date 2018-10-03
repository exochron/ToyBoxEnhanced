local ADDON_NAME, ADDON = ...

local function CreateAchievementPoints()
    local COLLECTION_ACHIEVEMENT_CATEGORY = 15246
    local TOY_ACHIEVEMENT_CATEGORY = 15247

    ToyBox.progressBar:SetShown(false)

    local frame = CreateFrame("Button", nil, ToyBox, "TBEAchievementButtonTemplate")
    frame.staticText:SetText(GetCategoryAchievementPoints(TOY_ACHIEVEMENT_CATEGORY, true))
    frame:SetScript("OnClick", function()
        ToggleAchievementFrame()

        local clickChain = { COLLECTION_ACHIEVEMENT_CATEGORY, TOY_ACHIEVEMENT_CATEGORY }
        for _, achievementId in pairs(clickChain) do
            local i = 1
            local button = _G["AchievementFrameCategoriesContainerButton" .. i]
            while button do
                if (button.element.id == achievementId) then
                    button:Click()
                    break
                else
                    i = i + 1
                    button = _G["AchievementFrameCategoriesContainerButton" .. i]
                end
            end
        end
    end)
    frame:SetScript("OnEnter", function(sender) sender.highlight:SetShown(true) end)
    frame:SetScript("OnLeave", function(sender) sender.highlight:SetShown(false) end)

    frame:RegisterEvent("ACHIEVEMENT_EARNED")
    frame:SetScript("OnEvent", function(self, event, arg1)
        frame.staticText:SetText(GetCategoryAchievementPoints(TOY_ACHIEVEMENT_CATEGORY, true))
    end)
end

ADDON:RegisterLoadUICallback(function()
    if ADDON.settings.replaceProgressBar then
        CreateAchievementPoints()
    end
end)