local ADDON_NAME, ADDON = ...

local hideNew = {}

function TBE_ToySpellButton_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    if ( GameTooltip:SetToyByItemID(self.itemID) ) then
        self.UpdateTooltip = TBE_ToySpellButton_OnEnter
    else
        self.UpdateTooltip = nil;
    end
    -- replaced tainting set
    if ToyBox.newToys[self.itemID] ~= nil then
        hideNew[self.itemID] = true;
    end
    TBE_ToySpellButton_UpdateButton(self);
end

--local TOY_FANFARE_MODEL_SCENE = 253;
function TBE_ToySpellButton_UpdateButton(self)

    --region overwrite start
    local itemIndex = (ToyBox.EnhancedLayer.PagingFrame:GetCurrentPage() - 1) * ADDON.TOYS_PER_PAGE + self:GetID();
    self.itemID = ADDON.DataProvider:Find(itemIndex) or -1;
    self:SetAttribute("toy", self.itemID)
    --endregion

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

    local itemID, toyName, icon, isFavorite, hasFanfare = C_ToyBox.GetToyInfo(self.itemID);
	if (itemID == nil) or (toyName == nil) then
        return;
    end

    --[[ Disable tainting Fanfare
	if ToyBox.fanfareToys[itemID] == nil and hasFanfare then
		ToyBox.fanfareToys[itemID] = true;
		ToyBox.newToys[self.itemID] = true;-- if it has fanfare, we also want to treat it as new
	end
	--]]

    if string.len(toyName) == 0 then
        toyName = itemID;
    end

    -- use non tainting logic
	if hideNew[self.itemID] or not ToyBox.newToys[self.itemID] then
		toyNewString:Hide();
		toyNewGlow:Hide();
	else
		toyNewString:Show();
		toyNewGlow:Show();
	end

    iconTexture:SetTexture(icon);
    iconTextureUncollected:SetTexture(icon);
    iconTextureUncollected:SetDesaturated(true);

    --[[ Disable Fanfare
	if not ToyBox.fanfareToys[itemID] then
		if self.modelScene then
			ToyBox.fanfarePool:Release(self.modelScene);
			self.modelScene = nil;
		end
    --]]

        if (PlayerHasToy(self.itemID)) then
            iconTexture:Show();
            iconTextureUncollected:Hide();
            toyString:SetTextColor(1, 0.82, 0, 1);
            toyString:SetShadowColor(0, 0, 0, 1);
            slotFrameCollected:Show();
            slotFrameUncollected:Hide();
            slotFrameUncollectedInnerGlow:Hide();

            -- use non tainting logic
            if ToyBox.firstCollectedToyID == 0
                    and HelpTip.IsShowing
                    and not HelpTip:IsShowing(ToyBox, TOYBOX_FAVORITE_HELP)
                    and C_ToyBox.GetNumLearnedDisplayedToys() == 1
                    and not GetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE)
            then
				local helpTipInfo = {
					text = TOYBOX_FAVORITE_HELP,
					buttonStyle = HelpTip.ButtonStyle.Close,
					cvarBitfield = "closedInfoFrames",
					bitfieldFlag = LE_FRAME_TUTORIAL_TOYBOX_FAVORITE,
					targetPoint = HelpTip.Point.BottomEdgeCenter,
					alignment = HelpTip.Alignment.Left,
					offsetY = 0,
				};
				HelpTip:Show(ToyBox, helpTipInfo, self);
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

        if (ADDON.Api:GetIsFavorite(itemID)) then -- overwrite
            iconFavoriteTexture:Show();
        else
            iconFavoriteTexture:Hide();
        end
        CollectionsSpellButton_UpdateCooldown(self);

    --[[ Disable Fanfare
	else
		-- we are presenting fanfare
		if not self.modelScene then
			self.modelScene = ToyBox.fanfarePool:Acquire();
			self.modelScene:SetParent(self);
			self.modelScene:ClearAllPoints();
			self.modelScene:SetPoint("CENTER");
		end
		if self.modelScene then
			iconTexture:Hide();
			slotFrameCollected:Hide();
			slotFrameUncollected:Hide();
			iconTextureUncollected:Hide();
			toyString:SetTextColor(1, 0.82, 0, 1);
			self.cooldown:Hide();
			self.HighlightTexture:Hide();
			self.modelScene:TransitionToModelSceneID(TOY_FANFARE_MODEL_SCENE, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_MAINTAIN, true);
			self.modelScene:PrepareForFanfare(true);
			self.modelScene:Show();
		end
	end
	--]]

    --region overwrite start
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
    --endregion

    toyString:SetText(toyName);
    toyString:Show();
end

local function toggleLayer(show)
    show = show and not InCombatLockdown()

    ToyBox.EnhancedLayer:SetShown(show)

    if not InCombatLockdown() then
        ToyBox.PagingFrame:SetShown(not show)
        for i = 1, 18 do
            ToyBox.iconsFrame["spellButton"..i]:SetShown(not show)
        end
    end
end

local function updateButtons()
    HelpTip:Hide(ToyBox, TOYBOX_FAVORITE_HELP);
    for i = 1, ADDON.TOYS_PER_PAGE do
        local button = ToyBox.EnhancedLayer["spellButton" .. i];
        TBE_ToySpellButton_UpdateButton(button);
    end
    toggleLayer(ToyBox.EnhancedLayer:IsShown())
end
local function updatePages()
    local maxPages = 1 + math.floor( math.max((ADDON.DataProvider:GetSize() - 1), 0) / ADDON.TOYS_PER_PAGE)
    ToyBox.EnhancedLayer.PagingFrame:SetMaxPages(maxPages)
end

-- see: https://github.com/tukui-org/ElvUI/blob/main/ElvUI/Mainline/Modules/Skins/Collectables.lua ::SkinToyFrame()
local function SkinElvUI(layer)
    if ElvUI and ToyBox.PagingFrame.NextPageButton.IsSkinned then
        local E = unpack(ElvUI)
        local S = E:GetModule('Skins')

        layer:StripTextures()

        S:HandleNextPrevButton(layer.PagingFrame.NextPageButton, nil, nil, true)
        S:HandleNextPrevButton(layer.PagingFrame.PrevPageButton, nil, nil, true)

        local function toyTextColor(text, r, g, b)
            if r == 0.33 and g == 0.27 and b == 0.2 then
                text:SetTextColor(0.4, 0.4, 0.4)
            elseif r == 1 and g == 0.82 and b == 0 then
                text:SetTextColor(0.9, 0.9, 0.9)
            end
        end

        for i = 1, ADDON.TOYS_PER_PAGE do
            local button = layer["spellButton" .. i]
            S:HandleItemButton(button, true)

            button.iconTextureUncollected:SetTexCoord(unpack(E.TexCoords))
            button.iconTextureUncollected:SetInside(button)
            button.hover:SetAllPoints(button.iconTexture)
            button.pushed:SetAllPoints(button.iconTexture)
            button.cooldown:SetAllPoints(button.iconTexture)

            hooksecurefunc(button.name, 'SetTextColor', toyTextColor)
            hooksecurefunc(button.new, 'SetTextColor', toyTextColor)

            E:RegisterCooldown(button.cooldown)
        end
    end
end

ADDON.Events:RegisterCallback("PreLoadUI", function()

    local layer = CreateFrame("Frame", nil, ToyBox, "TBEButtonFrameTemplate")
    layer:SetFrameStrata("DIALOG")
    layer:SetFrameLevel(555)
    layer:SetPoint("TOPLEFT", 4, -60)
    layer:SetPoint("BOTTOMRIGHT", -6, 5)

    SkinElvUI(layer)

    layer.OnPageChanged = function()
        PlaySound(SOUNDKIT.IG_ABILITY_PAGE_TURN)
        updateButtons()
    end

    layer:RegisterEvent("PLAYER_REGEN_ENABLED")
    layer:RegisterEvent("PLAYER_REGEN_DISABLED")
    layer:SetScript("OnEvent", function(_, event)
        toggleLayer(event == "PLAYER_REGEN_ENABLED")
    end)

    ToyBox:HookScript("OnMouseWheel", function(_, value)
        layer.PagingFrame:OnMouseWheel(value);
    end)

    for i = 1, ADDON.TOYS_PER_PAGE do
        local button = layer["spellButton" .. i]
        button:HookScript("OnClick", function(self, clickButton)
            if IsModifiedClick() then
                ToySpellButton_OnModifiedClick(self, clickButton)
            end
        end)
    end

    toggleLayer(true)

    hooksecurefunc("ToyBox_UpdatePages", updatePages)
    hooksecurefunc("ToyBox_UpdateButtons", updateButtons)

    ADDON.DataProvider:RegisterCallback("OnSizeChanged", function()
        if not InCombatLockdown() then
            updatePages()
            updateButtons()
        end
    end, ADDON_NAME)
    ADDON.DataProvider:RegisterCallback("OnSort", function()
        if not InCombatLockdown() then
            updateButtons()
        end
    end, ADDON_NAME)

    -- hook for click on alert
    hooksecurefunc("ToyBox_FindPageForToyID", function (toyID)
        local i = ADDON.DataProvider:FindIndex(toyID) or 0
        if i > 0 then
            local page = math.floor((i - 1) / ADDON.TOYS_PER_PAGE) + 1;
            ToyBox.EnhancedLayer.PagingFrame:SetCurrentPage(page);
        end
    end)
end, "EnhancedLayer")