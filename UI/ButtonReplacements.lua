local ADDON_NAME, ADDON = ...

local TOYS_PER_PAGE = 18

local function UpdateButtonCooldown(self)
    if (self.TBEitemID == -1 or self.TBEitemID == nil) then
        return;
    end

    local cooldown = self.cooldown;
    local start, duration, enable = GetItemCooldown(self.TBEitemID);
    if (cooldown and start and duration) then
        if (enable) then
            cooldown:Hide();
        else
            cooldown:Show();
        end
        CooldownFrame_Set(cooldown, start, duration, enable);
    else
        cooldown:Hide();
    end
end

local function UpdateButton(self)

    if not InCombatLockdown() then
        local itemIndex = (ToyBox.PagingFrame:GetCurrentPage() - 1) * TOYS_PER_PAGE + self:GetID();
        self.TBEitemID = ADDON.filteredToyList[itemIndex] or -1;
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

        if (self.TBEitemID == -1) then
            self:Hide();
            return;
        end

        self:Show();

        local itemID, toyName, icon = C_ToyBox.GetToyInfo(self.TBEitemID);

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

        if (ToyBox.newToys[self.TBEitemID] ~= nil) then
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

        if (PlayerHasToy(self.TBEitemID)) then
            iconTexture:Show();
            iconTextureUncollected:Hide();
            toyString:SetTextColor(1, 0.82, 0, 1);
            toyString:SetShadowColor(0, 0, 0, 1);
            slotFrameCollected:Show();
            slotFrameUncollected:Hide();
            slotFrameUncollectedInnerGlow:Hide();

            if (ToyBox.firstCollectedToyID == 0) then
                ToyBox.firstCollectedToyID = self.TBEitemID;
            end

            if (ToyBox.firstCollectedToyID == self.TBEitemID and not ToyBox.favoriteHelpBox:IsVisible() and not GetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE)) then
                ToyBox.favoriteHelpBox:Show();
                ToyBox.favoriteHelpBox:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -5, -20);
            end
        else
            iconTexture:Hide();
            iconTextureUncollected:Show();
            toyString:SetTextColor(0.33, 0.27, 0.20, 1);
            toyString:SetShadowColor(0, 0, 0, 0.33);
            slotFrameCollected:Hide();
            slotFrameUncollected:Show();
            slotFrameUncollectedInnerGlow:Show();
        end

        UpdateButtonCooldown(self);
    end
end

local function HandleOnDrag(self)
    if not InCombatLockdown() then
        C_ToyBox.PickupToyBoxItem(self.TBEitemID);
    end
end

local function ReplaceSpellButtons()
    for i = 1, TOYS_PER_PAGE do
        local oldToyButton = ToyBox.iconsFrame["spellButton" .. i]
        oldToyButton:SetParent(nil)
        oldToyButton:SetShown(false)

        local button = CreateFrame("CheckButton", nil, ToyBox.iconsFrame, "ToyBoxEnhancedSpellButtonTemplate", i)
        button:HookScript("OnDragStart", HandleOnDrag)
        button:HookScript("OnReceiveDrag", HandleOnDrag)
        button:HookScript("OnEnter", function(sender)
            if (not InCombatLockdown()) then
                local itemId = sender.TBEitemID
                GameTooltip:SetOwner(sender, "ANCHOR_RIGHT")
                GameTooltip:SetToyByItemID(itemId)
                sender:SetAttribute("toy", itemId)
            end
        end)
        button:HookScript("OnLeave", function(sender)
            if (not InCombatLockdown()) then
                sender:SetAttribute("toy", sender.itemID)
            end
        end)
        button:HookScript("OnClick", function(sender)
            if IsModifiedClick() and IsModifiedClick("CHATLINK") then
                local itemId = sender.itemID
                if (not InCombatLockdown()) then
                    itemId = sender.TBEitemID
                end
                local itemLink = C_ToyBox.GetToyLink(itemId);
                if ( itemLink ) then
                    ChatEdit_InsertLink(itemLink);
                end
            end
        end)

        ToyBox.iconsFrame["spellButton" .. i] = button
    end

    local positions = {
        { "TOPLEFT", ToyBox.iconsFrame, "TOPLEFT", 40, -46 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton1, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton2, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton1, "BOTTOMLEFT", 0, -16 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton4, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton5, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton4, "BOTTOMLEFT", 0, -16 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton7, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton8, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton7, "BOTTOMLEFT", 0, -16 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton10, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton11, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton10, "BOTTOMLEFT", 0, -16 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton13, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton14, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton13, "BOTTOMLEFT", 0, -16 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton16, "TOPLEFT", 208, 0 },
        { "TOPLEFT", ToyBox.iconsFrame.spellButton17, "TOPLEFT", 208, 0 },
    }
    for i = 1, TOYS_PER_PAGE do
        ToyBox.iconsFrame["spellButton" .. i]:SetPoint(positions[i][1], positions[i][2], positions[i][3], positions[i][4], positions[i][5])
    end
end

local function EnhanceButton(sender)
    local itemId = sender.itemID
    if not InCombatLockdown() then
        itemId = sender.TBEitemID
    end

    if (itemId == -1) then
        return
    end

    local itemId, toyName = C_ToyBox.GetToyInfo(itemId)
    if (itemId == nil or toyName == nil) then
        return
    end

    sender.slotFrameUncollectedInnerGlow:SetAlpha(0.18)
    sender.iconTextureUncollected:SetAlpha(0.18)

    sender.IsHidden:SetShown(ADDON.settings.hiddenToys[itemId])

    local alpha = 1.0
    if PlayerHasToy(itemId) and not C_ToyBox.IsToyUsable(itemId) then
        alpha = 0.25
    end
    sender.name:SetAlpha(alpha)
    sender.iconTexture:SetAlpha(alpha)
    sender.slotFrameCollected:SetAlpha(alpha)
end

ADDON:RegisterLoadUICallback(function()
    hooksecurefunc("ToySpellButton_UpdateButton", function(button)
        UpdateButton(button)
        EnhanceButton(button)
    end)
    ReplaceSpellButtons()
end)