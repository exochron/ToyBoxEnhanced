local ADDON_NAME, ADDON = ...

local function CreateAchievementPoints()
    local COLLECTION_ACHIEVEMENT_CATEGORY = 15246
    local TOY_ACHIEVEMENT_CATEGORY = 15247

    ToyBox.progressBar:SetShown(false)

    local frame = CreateFrame("Button", nil, ToyBox)

    frame:ClearAllPoints()
    frame:SetPoint("TOP", MountJournal, -50, -21)
    frame:SetSize(60, 40)

    frame.bgLeft = frame:CreateTexture(nil, "BACKGROUND")
    frame.bgLeft:SetAtlas("PetJournal-PetBattleAchievementBG")
    frame.bgLeft:ClearAllPoints()
    frame.bgLeft:SetSize(46, 18)
    frame.bgLeft:SetPoint("Top", -56, -12)
    frame.bgLeft:SetVertexColor(1, 1, 1, 1)

    frame.bgRight = frame:CreateTexture(nil, "BACKGROUND")
    frame.bgRight:SetAtlas("PetJournal-PetBattleAchievementBG")
    frame.bgRight:ClearAllPoints()
    frame.bgRight:SetSize(46, 18)
    frame.bgRight:SetPoint("Top", 55, -12)
    frame.bgRight:SetVertexColor(1, 1, 1, 1)
    frame.bgRight:SetTexCoord(1, 0, 0, 1)

    frame.highlight = frame:CreateTexture(nil)
    frame.highlight:SetDrawLayer("BACKGROUND", 1)
    frame.highlight:SetAtlas("PetJournal-PetBattleAchievementGlow")
    frame.highlight:ClearAllPoints()
    frame.highlight:SetSize(210, 40)
    frame.highlight:SetPoint("CENTER", 0, 0)
    frame.highlight:SetShown(false)

    frame.icon = frame:CreateTexture(nil, "OVERLAY")
    frame.icon:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Shields-NoPoints")
    frame.icon:ClearAllPoints()
    frame.icon:SetSize(30, 30)
    frame.icon:SetPoint("RIGHT", 0, -5)
    frame.icon:SetTexCoord(0, 0.5, 0, 0.5)

    frame.staticText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.staticText:ClearAllPoints()
    frame.staticText:SetPoint("RIGHT", frame.icon, "LEFT", -4, 4)
    frame.staticText:SetSize(0, 0)
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