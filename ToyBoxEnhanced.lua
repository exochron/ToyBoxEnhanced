local ADDON_NAME = ...;

local TOYS_PER_PAGE = 18;
local COLLECTION_ACHIEVEMENT_CATEGORY = 15246;
local TOY_ACHIEVEMENT_CATEGORY = 15247;

local L = CoreFramework:GetModule("Localization", "1.1"):GetLocalization(ADDON_NAME);

local initialState = {
    settings = {
        debugMode = false,
        hiddenToys = { },
        filter = {
            collected = true,
            notCollected = true,
            onlyFavorites = false,
            onlyUsable = false,
            source = { },
            faction = {
                alliance = true,
                horde = true,
                noFaction = true,
            },
            profession = { },
            worldEvent = { },
            hidden = false,
        },
    },
};
for name, _ in pairs(ToyBoxEnhancedSource) do
    initialState.settings.filter.source[name] = true;
end
for name, _ in pairs(ToyBoxEnhancedProfession) do
    initialState.settings.filter.profession[name] = true;
end
for name, _ in pairs(ToyBoxEnhancedWorldEvent) do
    initialState.settings.filter.worldEvent[name] = true;
end
local dependencies = {
    function() return ToyBox or LoadAddOn("Blizzard_Collections"); end,
};
local private = CoreFramework:GetModule("Addon", "1.0"):NewAddon(ADDON_NAME, initialState, dependencies);

private.filteredToyList = { };
private.filterString = "";

-- overload some core functions
local org_GetNumFilteredToys = C_ToyBox.GetNumFilteredToys
C_ToyBox.GetNumFilteredToys = function()
    return #private.filteredToyList
end
local org_GetToyFromIndex = C_ToyBox.GetToyFromIndex
C_ToyBox.GetToyFromIndex = function(index)
    if (index > #private.filteredToyList) then
        return -1;
    end

    return private.filteredToyList[index];
end
C_ToyBox.ForceToyRefilter = function()
    return private:FilterToys()
end

function private:LoadUI()
    PetJournal:HookScript("OnShow", function() if (not PetJournalPetCard.petID) then PetJournal_ShowPetCard(1); end end);
    
    ToyBox.searchBox:SetScript("OnTextChanged", function(sender) self:ToyBox_OnSearchTextChanged(sender); end);

    hooksecurefunc(ToyBox.toyOptionsMenu, "initialize", function(sender, level) UIDropDownMenu_InitializeHelper(sender); self:ToyBoxOptionsMenu_Init(sender, level); end);
    hooksecurefunc(ToyBoxFilterDropDown, "initialize", function(sender, level) UIDropDownMenu_InitializeHelper(sender); self:ToyBoxFilterDropDown_Initialize(sender, level); end);
    hooksecurefunc("ToySpellButton_UpdateButton", function(sender) self:ToySpellButton_UpdateButton(sender) end);

    for i = 1, TOYS_PER_PAGE do
        local oldToyButton = ToyBox.iconsFrame["spellButton" .. i];
        oldToyButton:SetParent(nil);
        oldToyButton:SetShown(false);

        local newToyButton = CreateFrame("CheckButton", nil, ToyBox.iconsFrame, "ToyBoxEnhancedSpellButtonTemplate", i);
        newToyButton:HookScript("OnClick", function(sender, button) self:ToySpellButton_OnClick(sender, button); end);
        newToyButton:SetScript("OnShow", ToySpellButton_OnShow)
        newToyButton:SetScript("OnEnter", function(sender)
            ToySpellButton_OnEnter(sender)
            self:ToySpellButton_OnEnter(sender);
        end);
        newToyButton:SetScript("OnLeave", function(sender) self:ToySpellButton_OnLeave(sender); end);
        newToyButton.updateFunction = ToySpellButton_UpdateButton
        
        newToyButton.IsHidden = newToyButton:CreateTexture(nil, "OVERLAY");
        newToyButton.IsHidden:SetTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up");
        newToyButton.IsHidden:SetSize(36, 36);
        newToyButton.IsHidden:SetPoint("CENTER", newToyButton, "CENTER", 0, 0);
        newToyButton.IsHidden:SetDrawLayer("OVERLAY", 1);
        newToyButton.IsHidden:SetShown(false);
        
        ToyBox.iconsFrame["spellButton" .. i] = newToyButton;
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
    };
    for i = 1, TOYS_PER_PAGE do
        ToyBox.iconsFrame["spellButton" .. i]:SetPoint(positions[i][1], positions[i][2], positions[i][3], positions[i][4], positions[i][5]);    
    end

    self:CreateToyCountFrame();
    self:CreateUsableToyCountFrame();
    self:CreateAchievementFrame();

    self:FilterAndRefresh()
end

function private:FilterAndRefresh()
    self:FilterToys();
    ToyBox_UpdatePages();
    ToyBox_UpdateButtons();
end

function private:CreateToyCountFrame()
    local frame = CreateFrame("frame", "TBEToyCount", ToyBox, "InsetFrameTemplate3");

    frame:ClearAllPoints();
    frame:SetPoint("TOPLEFT", ToyBox, 70, -22);
    frame:SetSize(130, 18);

    frame.staticText = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
    frame.staticText:ClearAllPoints();
    frame.staticText:SetPoint("LEFT", frame, 10, 0);
    frame.staticText:SetText(L["Toys"]);

    frame.uniqueCount = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
    frame.uniqueCount:ClearAllPoints();
    frame.uniqueCount:SetPoint("RIGHT", frame, -10, 0);
    frame.uniqueCount:SetText(0);

    self.toyCountFrame = frame;
end

function private:CreateUsableToyCountFrame()
    local frame = CreateFrame("frame", "TBEUsableToyCount", ToyBox, "InsetFrameTemplate3");

    frame:ClearAllPoints();
    frame:SetPoint("TOPLEFT", ToyBox, 70, -42);
    frame:SetSize(130, 18);

    frame.staticText = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
    frame.staticText:ClearAllPoints();
    frame.staticText:SetPoint("LEFT", frame, 10, 0);
    frame.staticText:SetText(L["Usable"]);

    frame.uniqueCount = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
    frame.uniqueCount:ClearAllPoints();
    frame.uniqueCount:SetPoint("RIGHT", frame, -10, 0);
    frame.uniqueCount:SetText(0);

    self.usableToyCountFrame = frame;
end

function private:CreateAchievementFrame()
    ToyBox.progressBar:SetShown(false);

    self.achievementFrame = CreateFrame("Button", "TBEAchievement", ToyBox);

    local frame = self.achievementFrame;
    frame:ClearAllPoints();
    frame:SetPoint("TOP", ToyBox, 0, -21);
    frame:SetSize(60, 40);

    frame.bgLeft = frame:CreateTexture(nil, "BACKGROUND");
    frame.bgLeft:SetAtlas("PetJournal-PetBattleAchievementBG");
    frame.bgLeft:ClearAllPoints();
    frame.bgLeft:SetSize(46, 18);
    frame.bgLeft:SetPoint("Top", -56, -12);
    frame.bgLeft:SetVertexColor(1, 1, 1, 1);

    frame.bgRight = frame:CreateTexture(nil, "BACKGROUND");
    frame.bgRight:SetAtlas("PetJournal-PetBattleAchievementBG");
    frame.bgRight:ClearAllPoints();
    frame.bgRight:SetSize(46, 18);
    frame.bgRight:SetPoint("Top", 55, -12);
    frame.bgRight:SetVertexColor(1, 1, 1, 1);
    frame.bgRight:SetTexCoord(1, 0, 0, 1);

    frame.highlight = frame:CreateTexture(nil);
    frame.highlight:SetDrawLayer("BACKGROUND", 1);
    frame.highlight:SetAtlas("PetJournal-PetBattleAchievementGlow");
    frame.highlight:ClearAllPoints();
    frame.highlight:SetSize(210, 40);
    frame.highlight:SetPoint("CENTER", 0, 0);
    frame.highlight:SetShown(false);

    frame.icon = frame:CreateTexture(nil, "OVERLAY");
    frame.icon:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Shields-NoPoints");
    frame.icon:ClearAllPoints();
    frame.icon:SetSize(30, 30);
    frame.icon:SetPoint("RIGHT", 0, -5);
    frame.icon:SetTexCoord(0, 0.5, 0, 0.5);

    frame.staticText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
    frame.staticText:ClearAllPoints();
    frame.staticText:SetPoint("RIGHT", frame.icon, "LEFT", -4, 4);
    frame.staticText:SetSize(0, 0);
    frame.staticText:SetText(GetCategoryAchievementPoints(TOY_ACHIEVEMENT_CATEGORY, true));

    frame:SetScript("OnClick", function()
        ToggleAchievementFrame();
        local i = 1;
        local button = _G["AchievementFrameCategoriesContainerButton" .. i];
        while button do
            if (button.element.id == COLLECTION_ACHIEVEMENT_CATEGORY) then
                button:Click();
                button = nil;
            else
                i = i + 1;
                button = _G["AchievementFrameCategoriesContainerButton" .. i];
            end
        end

        i = 1;
        button = _G["AchievementFrameCategoriesContainerButton" .. i];
        while button do
            if (button.element.id == TOY_ACHIEVEMENT_CATEGORY) then
                button:Click();
                return;
            end

            i = i + 1;
            button = _G["AchievementFrameCategoriesContainerButton" .. i];
        end
    end);
    frame:SetScript("OnEnter", function() frame.highlight:SetShown(true); end);
    frame:SetScript("OnLeave", function() frame.highlight:SetShown(false); end);
end

function private:LoadDebugMode()
    if (self.settings.debugMode) then
        print("ToyBoxEnhanced: Debug mode activated");

        local toyCount = C_ToyBox.GetNumTotalDisplayedToys();
        for toyIndex = 1, toyCount do
            local itemId = C_ToyBox.GetToyInfo(org_GetToyFromIndex(toyIndex));
            if (not self:ContainsItem(ToyBoxEnhancedSource, itemId)) then
                print("New toy (by Source): " .. itemId);
            end
        end

        for _, source in pairs(ToyBoxEnhancedSource) do
            for itemId, _ in pairs(source) do
                if (not C_ToyBox.GetToyInfo(itemId)) then
                    print("Old toy (by Source): " .. itemId);
                end
            end
        end
    end
end

function private:ContainsItem(data, itemId)
    for _, category in pairs(data) do
        if (category[itemId]) then
            return true
        end
    end

    return false
end

function private:ToyBox_OnSearchTextChanged(sender)
    SearchBoxTemplate_OnTextChanged(sender);

    local oldText = self.filterString;
    self.filterString = string.lower(sender:GetText());

    if (oldText ~= self.filterString) then
        ToyBox.firstCollectedToyID = 0;
        self:FilterAndRefresh();
    end
end

function private:ToyBoxOptionsMenu_Init(sender, level)
    local info = UIDropDownMenu_CreateInfo();
    info.notCheckable = true;
    info.disabled = nil;

    if (ToyBox.menuItemID and PlayerHasToy(ToyBox.menuItemID)) then
        local isFavorite = ToyBox.menuItemID and C_ToyBox.GetIsFavorite(ToyBox.menuItemID);

        if (isFavorite) then
            info.text = BATTLE_PET_UNFAVORITE;
            info.func = function()
                C_ToyBox.SetIsFavorite(ToyBox.menuItemID, false);
                self:FilterAndRefresh();
            end
        else
            info.text = BATTLE_PET_FAVORITE;
            info.func = function()
                C_ToyBox.SetIsFavorite(ToyBox.menuItemID, true);
                SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE, true);
                ToyBox.favoriteHelpBox:Hide();
                self:FilterAndRefresh();
            end
        end

        UIDropDownMenu_AddButton(info, level);
        info.disabled = nil;
    end

    local itemId = ToyBox.menuItemID;
    local isHidden = itemId and self.settings.hiddenToys[itemId];
    if (isHidden) then
        info.text = L["Show"];
        info.func = function()
            self.settings.hiddenToys[itemId] = nil;
            self:FilterAndRefresh();
        end
    else
        info.text = L["Hide"];
        info.func = function()
            self.settings.hiddenToys[itemId] = true;
            self:FilterAndRefresh();
        end
    end

    UIDropDownMenu_AddButton(info, level);
    info.disabled = nil;

    info.text = CANCEL
    info.func = nil
    UIDropDownMenu_AddButton(info, level)
end

function private:ToyBoxFilterDropDown_Initialize(sender, level)
    local info = UIDropDownMenu_CreateInfo();
    info.keepShownOnClick = true;

    if level == 1 then
        info.text = COLLECTED
        info.func = function(_, _, _, value)
                        ToyBox.firstCollectedToyID = 0;
                        self.settings.filter.collected = value;
                        self:FilterAndRefresh();

                        if (value) then
                            UIDropDownMenu_EnableButton(1,2);
                        else
                            UIDropDownMenu_DisableButton(1,2);
                        end;
                    end
        info.checked = function() return self.settings.filter.collected; end;
        info.isNotRadio = true;
        UIDropDownMenu_AddButton(info, level)

        info.text = FAVORITES_FILTER;
        info.leftPadding = 16;
        info.disabled = not self.settings.filter.collected;
        info.checked = self.settings.filter.onlyFavorites;
        info.isNotRadio = true;
        info.notCheckable = false;
        info.hasArrow = false;
        info.func = function(_, _, _, value)
            self.settings.filter.onlyFavorites = value;
            self:FilterAndRefresh();
         end
        UIDropDownMenu_AddButton(info, level);

        info.leftPadding = 0;
        info.disabled = false;

        info.text = NOT_COLLECTED
        info.func = function(_, _, _, value)
                        ToyBox.firstCollectedToyID = 0;
                        self.settings.filter.notCollected = value;
                        self:FilterAndRefresh();
                    end
        info.checked = function() return self.settings.filter.notCollected; end;
        info.isNotRadio = true;
        UIDropDownMenu_AddButton(info, level)

        info.text = L["Only usable"];
        info.func = function(_, _, _, value)
            self.settings.filter.onlyUsable = value;
            self:FilterAndRefresh();
        end
        info.checked = self.settings.filter.onlyUsable;
        info.isNotRadio = true;
        info.notCheckable = false;
        info.hasArrow = false;
        UIDropDownMenu_AddButton(info, level);

        info.checked =     nil;
        info.isNotRadio = nil;
        info.func =  nil;
        info.hasArrow = true;
        info.notCheckable = true;

        info.text = SOURCES
        info.value = 1;
        UIDropDownMenu_AddButton(info, level)

        info.text = FACTION;
        info.isNotRadio = true;
        info.notCheckable = true;
        info.hasArrow = true;
        info.value = 2;
        UIDropDownMenu_AddButton(info, level);

        info.text = L["Profession"];
        info.isNotRadio = true;
        info.notCheckable = true;
        info.hasArrow = true;
        info.value = 3;
        UIDropDownMenu_AddButton(info, level);

        info.text = L["World Event"];
        info.isNotRadio = true;
        info.notCheckable = true;
        info.hasArrow = true;
        info.value = 4;
        UIDropDownMenu_AddButton(info, level);

        info.text = L["Hidden"];
        info.checked = self.settings.filter.hidden;
        info.isNotRadio = true;
        info.notCheckable = false;
        info.hasArrow = false;
        info.func = function(_, _, _, value)
            self.settings.filter.hidden = value;
            self:FilterAndRefresh();
         end
        UIDropDownMenu_AddButton(info, level);
        
        info.text = L["Reset filters"];
        info.keepShownOnClick = false;
        info.notCheckable = true;
        info.hasArrow = false;
        info.func = function(_, _, _, value)
            ToyBox.firstCollectedToyID = 0;
            self.settings.filter.collected = true;
            self.settings.filter.onlyFavorites = false;
            self.settings.filter.notCollected = true;
            self.settings.filter.onlyUsable = false;
            self.settings.filter.hidden = false;
            
            for sourceName, _ in pairs(ToyBoxEnhancedSource) do
                self.settings.filter.source[sourceName] = true;
            end
            
            self.settings.filter.faction.alliance = true;
            self.settings.filter.faction.horde = true;
            self.settings.filter.faction.noFaction = true;
            
            for professionName, _ in pairs(ToyBoxEnhancedProfession) do
                self.settings.filter.profession[professionName] = true;
            end
            
            for eventName, _ in pairs(ToyBoxEnhancedWorldEvent) do
                self.settings.filter.worldEvent[eventName] = true;
            end
            
            self:FilterAndRefresh();
        end
        UIDropDownMenu_AddButton(info, level);
    else
        if (UIDROPDOWNMENU_MENU_VALUE == 1) then
            info.hasArrow = false;
            info.isNotRadio = true;
            info.notCheckable = true;

            info.text = CHECK_ALL
            info.func = function()
                            ToyBox.firstCollectedToyID = 0;
                            for sourceName, _ in pairs(ToyBoxEnhancedSource) do
                                self.settings.filter.source[sourceName] = true;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 1, 2);
                            self:FilterAndRefresh();
                        end
            UIDropDownMenu_AddButton(info, level)

            info.text = UNCHECK_ALL
            info.func = function()
                            ToyBox.firstCollectedToyID = 0;
                            for sourceName in pairs(ToyBoxEnhancedSource) do
                                self.settings.filter.source[sourceName] = false;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 1, 2);
                            self:FilterAndRefresh();
                        end
            UIDropDownMenu_AddButton(info, level)

            for sourceName in pairs(ToyBoxEnhancedSource) do
                info.text = L[sourceName] or sourceName;
                info.func = function(_, _, _, value)
                    self.settings.filter.source[sourceName] = value;
                    self:FilterAndRefresh();
                end
                info.checked = function() return self.settings.filter.source[sourceName] ~= false; end;
                info.isNotRadio = true;
                info.notCheckable = false;
                info.hasArrow = false;
                UIDropDownMenu_AddButton(info, level);
            end
        end

        if (UIDROPDOWNMENU_MENU_VALUE == 2) then
            info.text = FACTION_ALLIANCE;
            info.func = function(_, _, _, value)
                self.settings.filter.faction.alliance = value;
                self:FilterAndRefresh();
            end
            info.checked = self.settings.filter.faction.alliance;
            info.isNotRadio = true;
            info.notCheckable = false;
            info.hasArrow = false;
            UIDropDownMenu_AddButton(info, level);

            info.text = FACTION_HORDE;
            info.func = function(_, _, _, value)
                self.settings.filter.faction.horde = value;
                self:FilterAndRefresh();
            end
            info.checked = self.settings.filter.faction.horde;
            info.isNotRadio = true;
            info.notCheckable = false;
            info.hasArrow = false;
            UIDropDownMenu_AddButton(info, level);

            info.text = NPC_NAMES_DROPDOWN_NONE;
            info.func = function(_, _, _, value)
                self.settings.filter.faction.noFaction = value;
                self:FilterAndRefresh();
            end
            info.checked = self.settings.filter.faction.noFaction;
            info.isNotRadio = true;
            info.notCheckable = false;
            info.hasArrow = false;
            UIDropDownMenu_AddButton(info, level);
        end

        if (UIDROPDOWNMENU_MENU_VALUE == 3) then
            info.hasArrow = false;
            info.isNotRadio = true;
            info.notCheckable = true;

            info.text = CHECK_ALL
            info.func = function()
                            ToyBox.firstCollectedToyID = 0;
                            for professionName, _ in pairs(ToyBoxEnhancedProfession) do
                                self.settings.filter.profession[professionName] = true;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 3, 2);
                            self:FilterAndRefresh();
                        end
            UIDropDownMenu_AddButton(info, level)

            info.text = UNCHECK_ALL
            info.func = function()
                            ToyBox.firstCollectedToyID = 0;
                            for professionName, _ in pairs(ToyBoxEnhancedProfession) do
                                self.settings.filter.profession[professionName] = false;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 3, 2);
                            self:FilterAndRefresh();
                        end
            UIDropDownMenu_AddButton(info, level)

            for professionName, _ in pairs(ToyBoxEnhancedProfession) do
                info.text = L[professionName] or professionName;
                info.func = function(_, _, _, value)
                    self.settings.filter.profession[professionName] = value;
                    self:FilterAndRefresh();
                end
                info.checked = function() return self.settings.filter.profession[professionName] ~= false; end;
                info.isNotRadio = true;
                info.notCheckable = false;
                info.hasArrow = false;
                UIDropDownMenu_AddButton(info, level);
            end
        end

        if (UIDROPDOWNMENU_MENU_VALUE == 4) then
            info.hasArrow = false;
            info.isNotRadio = true;
            info.notCheckable = true;

            info.text = CHECK_ALL
            info.func = function()
                            ToyBox.firstCollectedToyID = 0;
                            for eventName, _ in pairs(ToyBoxEnhancedWorldEvent) do
                                self.settings.filter.worldEvent[eventName] = true;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 4, 2);
                            self:FilterAndRefresh();
                        end
            UIDropDownMenu_AddButton(info, level)

            info.text = UNCHECK_ALL
            info.func = function()
                            ToyBox.firstCollectedToyID = 0;
                            for eventName, _ in pairs(ToyBoxEnhancedWorldEvent) do
                                self.settings.filter.worldEvent[eventName] = false;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 4, 2);
                            self:FilterAndRefresh();
                        end
            UIDropDownMenu_AddButton(info, level)

            for eventName, _ in pairs(ToyBoxEnhancedWorldEvent) do
                info.text = L[eventName] or eventName;
                info.func = function(_, _, _, value)
                    self.settings.filter.worldEvent[eventName] = value;
                    self:FilterAndRefresh();
                end
                info.checked = function() return self.settings.filter.worldEvent[eventName] ~= false; end;
                info.isNotRadio = true;
                info.notCheckable = false;
                info.hasArrow = false;
                UIDropDownMenu_AddButton(info, level);
            end
        end
    end
end

function private:ToySpellButton_OnClick(sender, button)
    if (IsModifiedClick()) then
        ToySpellButton_OnModifiedClick(sender, button)
    elseif (not sender.isPassive and button ~= "LeftButton") then
        ToyBox_ShowToyDropdown(sender.itemID, sender, 0, 0);
    end
end

function private:ToySpellButton_OnEnter(sender)
    if (not InCombatLockdown()) then
        sender:SetAttribute("type1", "toy");
        sender:SetAttribute("toy", sender.itemID);
        sender:SetAttribute("shift-action1", ATTRIBUTE_NOOP);
    end
end

function private:ToySpellButton_OnLeave(sender)
    if (not InCombatLockdown()) then
        sender:SetAttribute("type1", nil);
        sender:SetAttribute("toy", nil);
        sender:SetAttribute("shift-action1", ATTRIBUTE_NOOP);
    end

    GameTooltip_Hide();
end

function private:ToySpellButton_UpdateButton(sender)

    if (sender.itemID == -1) then
        return;
    end

    local itemID, toyName, icon = C_ToyBox.GetToyInfo(sender.itemID);
    if (itemID == nil or toyName == nil) then
        return;
    end

    sender.slotFrameUncollectedInnerGlow:SetAlpha(0.18);
    sender.iconTextureUncollected:SetAlpha(0.18);

    sender.IsHidden:SetShown(self.settings.hiddenToys[itemID]);

    local alpha = 1.0
    if (PlayerHasToy(sender.itemID) and (InCombatLockdown() or not C_ToyBox.IsToyUsable(itemID))) then
        alpha = 0.25
    end

    sender.name:SetAlpha(alpha);
    sender.iconTexture:SetAlpha(alpha);
    sender.slotFrameCollected:SetAlpha(alpha);
end

-- region filter functions

function private:FilterToys()
    local toyCount = C_ToyBox.GetNumTotalDisplayedToys();
    if (org_GetNumFilteredToys() ~= toyCount) then
        C_ToyBox.SetAllSourceTypeFilters(true);
        C_ToyBox.SetFilterString("");
        C_ToyBox.SetCollectedShown(true);
        C_ToyBox.SetUncollectedShown(true);
    end

    self.filteredToyList = {}

    local doNameFilter = false
    if (self.filterString and string.len(self.filterString) > 0) then
        doNameFilter = true
    end

    for toyIndex = 1, toyCount do
        local itemId, name, icon, favorited = C_ToyBox.GetToyInfo(org_GetToyFromIndex(toyIndex));
        local collected = PlayerHasToy(itemId);

        if ((doNameFilter and self:FilterToysByName(name))
            or (not doNameFilter and
                self:FilterHiddenToys(itemId) and
                self:FilterCollectedToys(collected) and
                self:FilterFavoriteToys(favorited) and
                self:FilterUsableToys(itemId) and
                self:FilterToysBySource(itemId) and
                self:FilterToysByFaction(itemId) and
                self:FilterToysByProfession(itemId) and
                self:FilterToysByWorldEvent(name, itemId, collected)))
        then
            table.insert(self.filteredToyList, itemId);
        end
    end

    if (self.toyCountFrame) then
        self.toyCountFrame.uniqueCount:SetText(C_ToyBox.GetNumLearnedDisplayedToys());
    end

    if (self.usableToyCountFrame) then
        self.usableToyCountFrame.uniqueCount:SetText(self:GetUsableToysCount());
    end
end

function private:FilterToysByName(name)
    if (string.find(string.lower(name), self.filterString, 1, true)) then
        return true
    else
        return false
    end
end

function private:FilterHiddenToys(itemId)
    return self.settings.filter.hidden or not self.settings.hiddenToys[itemId]
end

function private:FilterCollectedToys(collected)
    return (self.settings.filter.collected and collected) or (self.settings.filter.notCollected and not collected)
end

function private:FilterFavoriteToys(isFavorite)
    return not self.settings.filter.onlyFavorites or isFavorite or not self.settings.filter.collected
end

function private:FilterUsableToys(itemId)
    return not self.settings.filter.onlyUsable or C_ToyBox.IsToyUsable(itemId)
end

function private:CheckAllSettings(settings)
    local allDisabled = true
    local allEnabled = true
    for _, value in pairs(settings) do
        if (value) then
            allDisabled = false
        else
            allEnabled = false
        end
    end

    if allEnabled then
        return true
    elseif allDisabled then
        return false
    end

    return nil
end

function private:FilterToysBySource(itemId)

    local allSettings = self:CheckAllSettings(self.settings.filter.source)
    if allSettings then
        return true
    end

    local notContainded = true

    for source, value in pairs(self.settings.filter.source) do
        if (ToyBoxEnhancedSource[source] and ToyBoxEnhancedSource[source][itemId]) then
            if (value) then
                return true
            else
                notContainded = false
            end
        end
    end

    return notContainded and allSettings == false
end

function private:FilterToysByFaction(itemId)

    local allSettings = self:CheckAllSettings(self.settings.filter.faction)
    if allSettings then
        return true
    end

    local notContainded = true;
    if (ToyBoxEnhancedFaction.alliance[itemId]) then
        if (self.settings.filter.faction.alliance) then
            return true
        end
        notContainded = false
    end

    if (ToyBoxEnhancedFaction.horde[itemId]) then
        if (self.settings.filter.faction.horde) then
            return true
        end
        notContainded = false
    end

    return self.settings.filter.faction.noFaction and notContainded
end

function private:FilterToysByProfession(itemId)

    local allSettings = self:CheckAllSettings(self.settings.filter.profession)
    if allSettings then
        return true
    end

    local notContainded = true
    for profession, value in pairs(self.settings.filter.profession) do
        if ToyBoxEnhancedProfession[profession] and ToyBoxEnhancedProfession[profession][itemId] then
            if value then
                return true
            else
                notContainded = false
            end
        end
    end

    if not notContainded then
        return false
    end

    local isProfessionItem = false
    if ToyBoxEnhancedSource["Profession"][itemId] then
        isProfessionItem = true
    end

    return isProfessionItem and allSettings == false
end

function private:FilterToysByWorldEvent(name, itemId, collected)
    local notContainded = true;

    local allSettings = self:CheckAllSettings(self.settings.filter.worldEvent)
    if allSettings then
        return true
    end

    for worldEvent, value in pairs(self.settings.filter.worldEvent) do
        if ToyBoxEnhancedWorldEvent[worldEvent] and ToyBoxEnhancedWorldEvent[worldEvent][itemId] then
            if value then
                return true
            else
                notContainded = false
            end
        end
    end

    if not notContainded then
        return false
    end

    local isWorldEventItem = false;
    if ToyBoxEnhancedSource["World Event"][itemId] then
        isWorldEventItem = true
    end

    return isWorldEventItem and allSettings == false
end

-- endregion

function private:GetUsableToysCount()
    local toyCount = C_ToyBox.GetNumTotalDisplayedToys();
    if (org_GetNumFilteredToys() ~= toyCount) then
        C_ToyBox.SetAllSourceTypeFilters(true);
        C_ToyBox.SetFilterString("");
        C_ToyBox.SetCollectedShown(true);
        C_ToyBox.SetUncollectedShown(true);
    end

    local usableCount = 0;

    local toyCount = C_ToyBox.GetNumTotalDisplayedToys();
    for toyIndex = 1, toyCount do
        local itemId = C_ToyBox.GetToyInfo(org_GetToyFromIndex(toyIndex));
        if (PlayerHasToy(itemId) and C_ToyBox.IsToyUsable(itemId)) then
            usableCount = usableCount + 1;
        end
    end

    return usableCount;
end

function private:Load()
    self:LoadUI();
    self:LoadDebugMode();

    self:AddEventHandler("TOYS_UPDATED", function(...) self:OnToysUpdated(...); end);
    self:AddEventHandler("ACHIEVEMENT_EARNED", function() self:OnAchievement(); end);
    self:AddEventHandler("PLAYER_REGEN_ENABLED", function() self:OnCombatStateChanged(); end);
    self:AddEventHandler("PLAYER_REGEN_DISABLED", function() self:OnCombatStateChanged(); end);

    self:AddSlashCommand("TOYBOXENHANCED", function(...) self:OnSlashCommand(...) end, 'toyboxenhanced', 'tbe');
end

function private:OnToysUpdated(event, ...)
    local itemID, new = ...;

    if (ToyBox:IsVisible()) then
        self:FilterAndRefresh();
    end
end

function private:OnAchievement()
    self.achievementFrame.staticText:SetText(GetCategoryAchievementPoints(TOY_ACHIEVEMENT_CATEGORY, true));
end

function private:OnCombatStateChanged()
    if (ToyBox:IsVisible()) then
        self:FilterAndRefresh();
    end
end

function private:OnSlashCommand(command, parameter1, parameter2)
    if (command == "debug") then
        if (parameter1 == "on") then
            self.settings.debugMode = true;
            print("ToyBoxEnhanced: Debug mode activated.");
        elseif (parameter1 == "off") then
            self.settings.debugMode = false;
            print("ToyBoxEnhanced: Debug mode deactivated.");
        end
    else
        print("Syntax:");
        print("/tbe debug (on | off)");
    end
end