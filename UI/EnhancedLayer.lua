local ADDON_NAME, ADDON = ...

function TBE_ToySpellButton_UpdateButton(self)

    local itemIndex = (ToyBox.EnhancedLayer.PagingFrame:GetCurrentPage() - 1) * ADDON.TOYS_PER_PAGE + self:GetID();
    self.itemID = ADDON.filteredToyList[itemIndex] or -1;
    self:SetAttribute("toy", self.itemID)

    local toyString = self.name;
    local toyNewString = self.new;
    local toyNewGlow = self.newGlow;
    local iconTexture = self.iconTexture;
    local iconTextureUncollected = self.iconTextureUncollected;
    local slotFrameCollected = self.slotFrameCollected;
    local slotFrameUncollected = self.slotFrameUncollected;
    local slotFrameUncollectedInnerGlow = self.slotFrameUncollectedInnerGlow;
    local iconFavoriteTexture = self.cooldownWrapper.slotFavorite;

    if (self.itemID == -1) then
        self:Hide();
        return;
    end

    self:Show();

    local itemID, toyName, icon = C_ToyBox.GetToyInfo(self.itemID);

    if (itemID == nil or toyName == nil) then
        return;
    end

    if string.len(toyName) == 0 then
        toyName = itemID;
    end

    iconTexture:SetTexture(icon);
    iconTextureUncollected:SetTexture(icon);
    iconTextureUncollected:SetDesaturated(true);
    toyString:SetText(toyName);
    toyString:Show();

    if (ToyBox.newToys[self.itemID] ~= nil) then
        toyNewString:Show();
        toyNewGlow:Show();
    else
        toyNewString:Hide();
        toyNewGlow:Hide();
    end

    if (C_ToyBox.GetIsFavorite(itemID)) then
        iconFavoriteTexture:Show();
    else
        iconFavoriteTexture:Hide();
    end

    if (PlayerHasToy(self.itemID)) then
        iconTexture:Show();
        iconTextureUncollected:Hide();
        toyString:SetTextColor(1, 0.82, 0, 1);
        toyString:SetShadowColor(0, 0, 0, 1);
        slotFrameCollected:Show();
        slotFrameUncollected:Hide();
        slotFrameUncollectedInnerGlow:Hide();
    else
        iconTexture:Hide();
        iconTextureUncollected:Show();
        toyString:SetTextColor(0.33, 0.27, 0.20, 1);
        toyString:SetShadowColor(0, 0, 0, 0.33);
        slotFrameCollected:Hide();
        slotFrameUncollected:Show();
        slotFrameUncollectedInnerGlow:Show();
    end

    CollectionsSpellButton_UpdateCooldown(self);


    self.slotFrameUncollectedInnerGlow:SetAlpha(0.18)
    self.iconTextureUncollected:SetAlpha(0.18)

    self.IsHidden:SetShown(ADDON.settings.hiddenToys[self.itemID])

    local alpha = 1.0
    if PlayerHasToy(self.itemID) and not C_ToyBox.IsToyUsable(self.itemID) then
        alpha = 0.25
    end
    self.name:SetAlpha(alpha)
    self.iconTexture:SetAlpha(alpha)
    self.slotFrameCollected:SetAlpha(alpha)
end

local function UpdateButttons()
    for i = 1, ADDON.TOYS_PER_PAGE do
        local button = ToyBox.EnhancedLayer["spellButton" .. i];
        TBE_ToySpellButton_UpdateButton(button);
    end
end

ADDON:RegisterLoadUICallback(function()

    local layer = CreateFrame("Frame", nil, ToyBox, "TBEButtonFrameTemplate")
    layer:SetFrameStrata("DIALOG")
    layer.OnPageChanged = function(userAction)
        PlaySound(SOUNDKIT.IG_ABILITY_PAGE_TURN)
        UpdateButttons()
    end

    layer:RegisterEvent("PLAYER_REGEN_ENABLED")
    layer:RegisterEvent("PLAYER_REGEN_DISABLED")
    layer:SetScript("OnEvent", function(self, event, arg1)
        self:SetShown(event == "PLAYER_REGEN_ENABLED")
    end)

    ToyBox:HookScript("OnMouseWheel", function(self, value)
        layer.PagingFrame:OnMouseWheel(value);
    end)

    for i = 1, ADDON.TOYS_PER_PAGE do
        local button = layer["spellButton" .. i]
        button:HookScript("OnClick", function(self, button)
            if (IsModifiedClick()) then
                ToySpellButton_OnModifiedClick(self, button)
            end
        end)
    end

    layer:SetShown(not ADDON.inCombat)
    ToyBox.EnhancedLayer = layer

    hooksecurefunc("ToyBox_UpdatePages", function()
        local maxPages = 1 + math.floor( math.max((#ADDON.filteredToyList - 1), 0) / ADDON.TOYS_PER_PAGE)
        ToyBox.EnhancedLayer.PagingFrame:SetMaxPages(maxPages)
    end)
    hooksecurefunc("ToyBox_UpdateButtons", UpdateButttons)

    -- hook for click on alert
    hooksecurefunc("ToyBox_FindPageForToyID", function (toyID)
        for i = 1, #ADDON.filteredToyList do
            if ADDON.filteredToyList[i] == toyID then
                local page = math.floor((i - 1) / ADDON.TOYS_PER_PAGE) + 1;
                ToyBox.EnhancedLayer.PagingFrame:SetCurrentPage(page);
            end
        end
    end)
end)