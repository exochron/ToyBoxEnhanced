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
for _, category in pairs(ToyBoxEnhancedSource) do
    initialState.settings.filter.source[category.Name] = true;
end
for _, category in pairs(ToyBoxEnhancedProfession) do
    initialState.settings.filter.profession[category.Name] = true;
end
for _, category in pairs(ToyBoxEnhancedWorldEvent) do
    initialState.settings.filter.worldEvent[category.Name] = true;
end
local dependencies = {
    function() return ToyBox or LoadAddOn("Blizzard_Collections"); end,
};
local private = CoreFramework:GetModule("Addon", "1.0"):NewAddon(ADDON_NAME, initialState, dependencies);

private.filteredToyList = { };
private.filterString = "";

function private:LoadUI()
    PetJournal:HookScript("OnShow", function() if (not PetJournalPetCard.petID) then PetJournal_ShowPetCard(1); end end);
    
    ToyBox:SetScript("OnEvent", nil);
    ToyBox:SetScript("OnShow", function(sender) self:ToyBox_OnShow(sender); end);
    ToyBox:SetScript("OnMouseWheel", function(sender, value, scrollBar) self:ToyBox_OnMouseWheel(sender, value, scrollBar); end);
    ToyBox.searchBox:SetScript("OnTextChanged", function(sender) self:ToyBox_OnSearchTextChanged(sender); end);
    ToyBox.PagingFrame.PrevPageButton:SetScript("OnClick", function() self:ToyBoxPrevPageButton_OnClick(); end);
    ToyBox.PagingFrame.NextPageButton:SetScript("OnClick", function() self:ToyBoxNextPageButton_OnClick(); end);

    hooksecurefunc(ToyBox.toyOptionsMenu, "initialize", function(sender, level) UIDropDownMenu_InitializeHelper(sender); self:ToyBoxOptionsMenu_Init(sender, level); end);
    hooksecurefunc(ToyBoxFilterDropDown, "initialize", function(sender, level) UIDropDownMenu_InitializeHelper(sender); self:ToyBoxFilterDropDown_Initialize(sender, level); end);

    for i = 1, TOYS_PER_PAGE do
        local oldToyButton = ToyBox.iconsFrame["spellButton" .. i];
        oldToyButton:SetParent(nil);
        oldToyButton:SetShown(false);

        local newToyButton = CreateFrame("CheckButton", nil, ToyBox.iconsFrame, "ToyBoxEnhancedSpellButtonTemplate", i);
        newToyButton:HookScript("OnClick", function(sender, button) self:ToySpellButton_OnClick(sender, button); end);
        newToyButton:SetScript("OnShow", function(sender) self:ToySpellButton_OnShow(sender); end);
        newToyButton:SetScript("OnEnter", function(sender) self:ToySpellButton_OnEnter(sender); end);
        newToyButton:SetScript("OnLeave", function(sender) self:ToySpellButton_OnLeave(sender); end);
        newToyButton.updateFunction = function(sender) self:ToySpellButton_UpdateButton(sender) end;
        
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

    self:FilterToys();
    self:ToyBox_UpdatePages();
    self:ToyBox_UpdateButtons();
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
        local items = {};
        for toyIndex = 1, toyCount do
            local itemId = C_ToyBox.GetToyInfo(C_ToyBox.GetToyFromIndex(toyIndex));
            items[itemId] = true;
        end

        for itemId, _ in pairs(items) do
            local contained = self:ContainsItem(ToyBoxEnhancedSource, itemId);
            if (not contained) then
                print("New toy (by Source): " .. itemId);
            end
        end

        local professionItems = self:GetItemsFromCategory(ToyBoxEnhancedSource, "Profession");
        for itemId, itemName in pairs(professionItems) do
            local contained = self:ContainsItem(ToyBoxEnhancedProfession, itemId);
            if (not contained) then
                print("New toy (by Profession): " .. itemId);
            end
        end

        local worldEventItems = self:GetItemsFromCategory(ToyBoxEnhancedSource, "World Event");
        for itemId, itemName in pairs(worldEventItems) do
            local contained = self:ContainsItem(ToyBoxEnhancedWorldEvent, itemId);
            if (not contained) then
                print("New toy (by World Event): " .. itemId);
            end
        end

        local ignoredItems = {
            [97921] = true,
            [33079] = true,
            [49704] = true,
            [89205] = true,
        };
        for _, source in pairs(ToyBoxEnhancedSource) do
            for itemId, _ in pairs(source.Data) do
                if (not items[itemId] and not ignoredItems[itemId]) then
                    print("Old toy (by Source): " .. itemId);
                end
            end
        end
    end
end

function private:ContainsItem(data, itemId)
    local contained = false;

    for _, category in pairs(data) do
        for id, name in pairs(category.Data) do
            if (itemId == id) then
                contained = true;
                break;
            end
        end

        if (contained) then
            break;
        end
    end

    return contained;
end

function private:GetItemsFromCategory(data, name)
    for _, category in pairs(data) do
        if (category.Name == name) then
            return category.Data;
        end
    end

    return nil;
end

function private:ToyBox_OnShow(sender)
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX, true);

	if(C_ToyBox.HasFavorites()) then 
		SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE, true);
		ToyBox.favoriteHelpBox:Hide();
	end

    SetPortraitToTexture(CollectionsJournalPortrait,"Interface\\Icons\\Trade_Archaeology_ChestofTinyGlassAnimals");
    
    self:FilterToys();
    self:ToyBox_UpdatePages();
    self:ToyBox_UpdateButtons();
end

function private:ToyBox_OnSearchTextChanged(sender)
    SearchBoxTemplate_OnTextChanged(sender);

    local oldText = self.filterString;
    self.filterString = string.lower(sender:GetText());

    if (oldText ~= self.filterString) then
        ToyBox.firstCollectedToyID = 0;
        self:FilterToys();
        self:ToyBox_UpdatePages();
        self:ToyBox_UpdateButtons();
    end
end

function private:ToyBox_OnMouseWheel(sender, value, scrollBar)
    SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_MOUSEWHEEL_PAGING, true);
    ToyBox.mousewheelPagingHelpBox:Hide();
    if(value > 0) then
        self:ToyBoxPrevPageButton_OnClick()
    else
        self:ToyBoxNextPageButton_OnClick()
    end
end

function private:ToyBox_UpdateButtons()
    ToyBox.favoriteHelpBox:Hide();
    for i = 1,TOYS_PER_PAGE do
        local button = ToyBox.iconsFrame["spellButton" .. i];
        self:ToySpellButton_UpdateButton(button);
    end
end

function private:ToyBox_UpdatePages()
    local maxPages = 1 + math.floor(math.max((#self.filteredToyList - 1), 0) / TOYS_PER_PAGE);
    if (maxPages == nil or maxPages == 0) then
        return;
    end

    local paging = ToyBox.PagingFrame;
    local currentPage = paging:GetCurrentPage();

    if (currentPage > maxPages) then
        paging:SetCurrentPage(maxPages);
        currentPage = maxPages;
    end
    if (currentPage == 1) then
        paging.PrevPageButton:Disable();
    else
        paging.PrevPageButton:Enable();
    end
    if (currentPage == maxPages) then
        paging.NextPageButton:Disable();
    else
        paging.NextPageButton:Enable();
    end

    paging.PageText:SetFormattedText(COLLECTION_PAGE_NUMBER, currentPage, maxPages);
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
                self:FilterToys();
                self:ToyBox_UpdatePages();
                self:ToyBox_UpdateButtons();
            end
        else
            info.text = BATTLE_PET_FAVORITE;
            info.func = function()
                C_ToyBox.SetIsFavorite(ToyBox.menuItemID, true);
                SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE, true);
                ToyBox.favoriteHelpBox:Hide();
                self:FilterToys();
                self:ToyBox_UpdatePages();
                self:ToyBox_UpdateButtons();
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
            self:FilterToys();
            self:ToyBox_UpdatePages();
            self:ToyBox_UpdateButtons();
        end
    else
        info.text = L["Hide"];
        info.func = function()
            self.settings.hiddenToys[itemId] = true;
            self:FilterToys();
            self:ToyBox_UpdatePages();
            self:ToyBox_UpdateButtons();
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
                        self:FilterToys();
                        self:ToyBox_UpdatePages();
                        self:ToyBox_UpdateButtons();

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
            self:FilterToys();
            self:ToyBox_UpdatePages();
            self:ToyBox_UpdateButtons();
         end
        UIDropDownMenu_AddButton(info, level);

        info.leftPadding = 0;
        info.disabled = false;

        info.text = NOT_COLLECTED
        info.func = function(_, _, _, value)
                        ToyBox.firstCollectedToyID = 0;
                        self.settings.filter.notCollected = value;
                        self:FilterToys();
                        self:ToyBox_UpdatePages();
                        self:ToyBox_UpdateButtons();
                    end
        info.checked = function() return self.settings.filter.notCollected; end;
        info.isNotRadio = true;
        UIDropDownMenu_AddButton(info, level)

        info.text = L["Only usable"];
        info.func = function(_, _, _, value)
            self.settings.filter.onlyUsable = value;
            self:FilterToys();
            self:ToyBox_UpdatePages();
            self:ToyBox_UpdateButtons();
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
            self:FilterToys();
            self:ToyBox_UpdatePages();
            self:ToyBox_UpdateButtons();
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
            
            for _, source in pairs(ToyBoxEnhancedSource) do
                self.settings.filter.source[source.Name] = true;
            end
            
            self.settings.filter.faction.alliance = true;
            self.settings.filter.faction.horde = true;
            self.settings.filter.faction.noFaction = true;
            
            for _, profession in pairs(ToyBoxEnhancedProfession) do
                self.settings.filter.profession[profession.Name] = true;
            end
            
            for _, worldEvent in pairs(ToyBoxEnhancedWorldEvent) do
                self.settings.filter.worldEvent[worldEvent.Name] = true;
            end
            
            self:FilterToys();
            self:ToyBox_UpdatePages();
            self:ToyBox_UpdateButtons();
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
                            for _, source in pairs(ToyBoxEnhancedSource) do
                                self.settings.filter.source[source.Name] = true;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 1, 2);
                            self:FilterToys();
                            self:ToyBox_UpdatePages();
                            self:ToyBox_UpdateButtons();
                        end
            UIDropDownMenu_AddButton(info, level)

            info.text = UNCHECK_ALL
            info.func = function()
                            ToyBox.firstCollectedToyID = 0;
                            for _, source in pairs(ToyBoxEnhancedSource) do
                                self.settings.filter.source[source.Name] = false;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 1, 2);
                            self:FilterToys();
                            self:ToyBox_UpdatePages();
                            self:ToyBox_UpdateButtons();
                        end
            UIDropDownMenu_AddButton(info, level)

            for _, source in pairs(ToyBoxEnhancedSource) do
                info.text = L[source.Name] or source.Name;
                info.func = function(_, _, _, value)
                    self.settings.filter.source[source.Name] = value;
                    self:FilterToys();
                    self:ToyBox_UpdatePages();
                    self:ToyBox_UpdateButtons();
                end
                info.checked = function() return self.settings.filter.source[source.Name] ~= false; end;
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
                self:FilterToys();
                self:ToyBox_UpdatePages();
                self:ToyBox_UpdateButtons();
            end
            info.checked = self.settings.filter.faction.alliance;
            info.isNotRadio = true;
            info.notCheckable = false;
            info.hasArrow = false;
            UIDropDownMenu_AddButton(info, level);

            info.text = FACTION_HORDE;
            info.func = function(_, _, _, value)
                self.settings.filter.faction.horde = value;
                self:FilterToys();
                self:ToyBox_UpdatePages();
                self:ToyBox_UpdateButtons();
            end
            info.checked = self.settings.filter.faction.horde;
            info.isNotRadio = true;
            info.notCheckable = false;
            info.hasArrow = false;
            UIDropDownMenu_AddButton(info, level);

            info.text = NPC_NAMES_DROPDOWN_NONE;
            info.func = function(_, _, _, value)
                self.settings.filter.faction.noFaction = value;
                self:FilterToys();
                self:ToyBox_UpdatePages();
                self:ToyBox_UpdateButtons();
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
                            for _, profession in pairs(ToyBoxEnhancedProfession) do
                                self.settings.filter.profession[profession.Name] = true;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 3, 2);
                            self:FilterToys();
                            self:ToyBox_UpdatePages();
                            self:ToyBox_UpdateButtons();
                        end
            UIDropDownMenu_AddButton(info, level)

            info.text = UNCHECK_ALL
            info.func = function()
                            ToyBox.firstCollectedToyID = 0;
                            for _, profession in pairs(ToyBoxEnhancedProfession) do
                                self.settings.filter.profession[profession.Name] = false;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 3, 2);
                            self:FilterToys();
                            self:ToyBox_UpdatePages();
                            self:ToyBox_UpdateButtons();
                        end
            UIDropDownMenu_AddButton(info, level)

            for _, profession in pairs(ToyBoxEnhancedProfession) do
                info.text = L[profession.Name] or profession.Name;
                info.func = function(_, _, _, value)
                    self.settings.filter.profession[profession.Name] = value;
                    self:FilterToys();
                    self:ToyBox_UpdatePages();
                    self:ToyBox_UpdateButtons();
                end
                info.checked = function() return self.settings.filter.profession[profession.Name] ~= false; end;
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
                            for _, worldEvent in pairs(ToyBoxEnhancedWorldEvent) do
                                self.settings.filter.worldEvent[worldEvent.Name] = true;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 4, 2);
                            self:FilterToys();
                            self:ToyBox_UpdatePages();
                            self:ToyBox_UpdateButtons();
                        end
            UIDropDownMenu_AddButton(info, level)

            info.text = UNCHECK_ALL
            info.func = function()
                            ToyBox.firstCollectedToyID = 0;
                            for _, worldEvent in pairs(ToyBoxEnhancedWorldEvent) do
                                self.settings.filter.worldEvent[worldEvent.Name] = false;
                            end
                            UIDropDownMenu_Refresh(ToyBoxFilterDropDown, 4, 2);
                            self:FilterToys();
                            self:ToyBox_UpdatePages();
                            self:ToyBox_UpdateButtons();
                        end
            UIDropDownMenu_AddButton(info, level)

            for _, worldEvent in pairs(ToyBoxEnhancedWorldEvent) do
                info.text = L[worldEvent.Name] or worldEvent.Name;
                info.func = function(_, _, _, value)
                    self.settings.filter.worldEvent[worldEvent.Name] = value;
                    self:FilterToys();
                    self:ToyBox_UpdatePages();
                    self:ToyBox_UpdateButtons();
                end
                info.checked = function() return self.settings.filter.worldEvent[worldEvent.Name] ~= false; end;
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
        if (IsModifiedClick("CHATLINK")) then
            local itemLink = C_ToyBox.GetToyLink(sender.itemID);
            if (itemLink) then
                ChatEdit_InsertLink(itemLink);
            end
        end
    else
        if (sender.isPassive) then
            return
        end;
        if (button ~= "LeftButton") then
            ToyBox_ShowToyDropdown(sender.itemID, sender, 0, 0);
        end
    end
end

function private:ToySpellButton_OnShow(sender)
    sender:RegisterEvent("SPELLS_CHANGED");
    sender:RegisterEvent("SPELL_UPDATE_COOLDOWN");
    sender:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
    sender:RegisterEvent("TOYS_UPDATED");

    self:ToySpellButton_UpdateButton(sender);
end

function private:ToySpellButton_OnEnter(sender)
    GameTooltip:SetOwner(sender, "ANCHOR_RIGHT");
    if ( GameTooltip:SetToyByItemID(sender.itemID) ) then
        sender.UpdateTooltip = function(sender) self:ToySpellButton_OnEnter(sender); end;
    else
        sender.UpdateTooltip = nil;
    end

    if(ToyBox.newToys[sender.itemID] ~= nil) then
        ToyBox.newToys[sender.itemID] = nil;
        self:ToySpellButton_UpdateButton(sender);
    end

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
    local itemIndex = (ToyBox.PagingFrame:GetCurrentPage() - 1) * TOYS_PER_PAGE + sender:GetID();
    sender.itemID = self:GetToyFromIndex(itemIndex);

    local name = sender:GetName();
    local toyString = sender.name;
    local toyNewString = sender.new;
    local toyNewGlow = sender.newGlow;
    local iconTexture = sender.iconTexture;
    local iconTextureUncollected = sender.iconTextureUncollected;
    local slotFrameCollected = sender.slotFrameCollected;
    local slotFrameUncollected = sender.slotFrameUncollected;
    local slotFrameUncollectedInnerGlow = sender.slotFrameUncollectedInnerGlow;
    local iconFavoriteTexture = sender.cooldownWrapper.slotFavorite;

    if (sender.itemID == -1) then
        sender:SetAlpha(0.0);
        sender.cooldown:Hide();
        return;
    end

    sender:SetAlpha(1.0);

    local itemID, toyName, icon = C_ToyBox.GetToyInfo(sender.itemID);
    if (itemID == nil) then
        return;
    end

    if (not toyName or string.len(toyName) == 0) then
        toyName = itemID;
    end

    iconTexture:SetTexture(icon);
    iconTextureUncollected:SetTexture(icon);
    iconTextureUncollected:SetDesaturated(true);
    slotFrameUncollectedInnerGlow:SetAlpha(0.18);
    iconTextureUncollected:SetAlpha(0.18);
    toyString:SetText(toyName);
    toyString:Show();

    if (ToyBox.newToys[sender.itemID] ~= nil) then
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

    if (PlayerHasToy(sender.itemID)) then
        iconTexture:Show();
        iconTextureUncollected:Hide();
        toyString:SetTextColor(1, 0.82, 0, 1);
        toyString:SetShadowColor(0, 0, 0, 1);
        slotFrameCollected:Show();
        slotFrameUncollected:Hide();
        slotFrameUncollectedInnerGlow:Hide();

        if(ToyBox.firstCollectedToyID == 0) then
            ToyBox.firstCollectedToyID = sender.itemID;
        end

        if (ToyBox.firstCollectedToyID == sender.itemID and not ToyBox.favoriteHelpBox:IsVisible() and not GetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE)) then
            ToyBox.favoriteHelpBox:Show();
            ToyBox.favoriteHelpBox:SetPoint("TOPLEFT", sender, "BOTTOMLEFT", -5, -20);
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

    sender.IsHidden:SetShown(self.settings.hiddenToys[itemID]);

    if (PlayerHasToy(sender.itemID)) then
        if (self:IsToyUsable(itemID)) then
            if (InCombatLockdown()) then
                toyString:SetAlpha(0.25);
                iconTexture:SetAlpha(0.25);
                slotFrameCollected:SetAlpha(0.25);
            else
                toyString:SetAlpha(1.0);
                iconTexture:SetAlpha(1.0);
                slotFrameCollected:SetAlpha(1.0);
            end
        else
            toyString:SetAlpha(0.25);
            iconTexture:SetAlpha(0.25);
            slotFrameCollected:SetAlpha(0.25);
        end
    else
        toyString:SetAlpha(1.0);
        iconTexture:SetAlpha(1.0);
        slotFrameCollected:SetAlpha(1.0);
    end

    CollectionsSpellButton_UpdateCooldown(sender);
end

function private:ToyBoxPrevPageButton_OnClick()
    local currentPage = ToyBox.PagingFrame:GetCurrentPage();
    if (currentPage > 1) then
        PlaySound("igAbiliityPageTurn");
        ToyBox.PagingFrame:SetCurrentPage(math.max(1, currentPage - 1), true);
        self:ToyBox_UpdatePages();
        self:ToyBox_UpdateButtons();
    end
end

function private:ToyBoxNextPageButton_OnClick()
    local maxPages = 1 + math.floor( math.max((#self.filteredToyList - 1), 0)/ TOYS_PER_PAGE);
    if (ToyBox.PagingFrame:GetCurrentPage() < maxPages) then
        -- show the mousewheel tip after the player's advanced a few pages
        if(ToyBox.PagingFrame:GetCurrentPage() > 2) then
            if(not GetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_MOUSEWHEEL_PAGING) and GetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE)) then
                ToyBox.mousewheelPagingHelpBox:Show();
            end
        end

        PlaySound("igAbiliityPageTurn");
        ToyBox.PagingFrame:NextPage()
        self:ToyBox_UpdatePages();
        self:ToyBox_UpdateButtons();
    end
end

function private:FilterToys()
    local toyCount = C_ToyBox.GetNumTotalDisplayedToys();
    if (C_ToyBox.GetNumFilteredToys() ~= toyCount) then
        C_ToyBox.SetAllSourceTypeFilters(true);
        C_ToyBox.SetFilterString("");
        C_ToyBox.SetCollectedShown(true);
        C_ToyBox.SetUncollectedShown(true);
    end

    self.filteredToyList = {};

    for toyIndex = 1, toyCount do
        local itemId, name, icon, favorited = C_ToyBox.GetToyInfo(C_ToyBox.GetToyFromIndex(toyIndex));
        local collected = PlayerHasToy(itemId);

        if (self:FilterHiddenToys(name, itemId) and
            self:FilterFavoriteToys(name, favorited) and
            self:FilterUsableToys(name, itemId) and
            self:FilterToysBySource(name, itemId, collected) and
            self:FilterToysByFaction(name, itemId, collected) and
            self:FilterToysByProfession(name, itemId, collected) and
            self:FilterToysByWorldEvent(name, itemId, collected))
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
        return true;
    else
        return false;
    end
end

function private:FilterHiddenToys(name, itemId)
    if (self.filterString and string.len(self.filterString) > 0) then
        return self:FilterToysByName(name);
    end

    if (self.settings.filter.hidden) then
        return true;
    end

    return not self.settings.hiddenToys[itemId];
end

function private:FilterFavoriteToys(name, isFavorite)
    if (self.filterString and string.len(self.filterString) > 0) then
        return self:FilterToysByName(name);
    end

    if (not self.settings.filter.onlyFavorites) then
        return true;
    end

    return isFavorite or not self.settings.filter.collected;
end

function private:FilterUsableToys(name, itemId)
    if (self.filterString and string.len(self.filterString) > 0) then
        return self:FilterToysByName(name);
    end

    if (not self.settings.filter.onlyUsable) then
        return true;
    end

    return self:IsToyUsable(itemId);
end

function private:FilterToysBySource(name, itemId, collected)
    if (self.filterString and string.len(self.filterString) > 0) then
        return self:FilterToysByName(name);
    end

    if (not self.settings.filter.collected and collected) then
        return false;
    end

    if (not self.settings.filter.notCollected and not collected) then
        return false;
    end

    local notContainded = true;

    local allDisabled = true;
    local allEnabled = true;
    for _, value in pairs(self.settings.filter.source) do
        if (value) then
            allDisabled = false;
        else
            allEnabled = false;
        end
    end

    if (allEnabled) then
        return true;
    end

    for source, value in pairs(self.settings.filter.source) do
        for _, category in pairs(ToyBoxEnhancedSource) do
            if (category.Name == source) then
                if (category.Data[itemId]) then
                    if (value) then
                        return true;
                    else
                        notContainded = false;
                    end
                end
                break;
            end
        end
    end

    return notContainded and (allDisabled or allEnabled);
end

function private:FilterToysByFaction(name, itemId, collected)
    if (self.filterString and string.len(self.filterString) > 0) then
        return self:FilterToysByName(name);
    end

    if (not self.settings.filter.collected and collected) then
        return false;
    end

    if (not self.settings.filter.notCollected and not collected) then
        return false;
    end

    local notContainded = true;

    local allDisabled = true;
    local allEnabled = true;
    for _, value in pairs(self.settings.filter.faction) do
        if (value) then
            allDisabled = false;
        else
            allEnabled = false;
        end
    end

    if (allEnabled) then
        return true;
    end

    if (ToyBoxEnhancedFaction.alliance[itemId]) then
        if (self.settings.filter.faction.alliance) then
            return true;
        else
            notContainded = false;
        end
    end

    if (ToyBoxEnhancedFaction.horde[itemId]) then
        if (self.settings.filter.faction.horde) then
            return true;
        else
            notContainded = false;
        end
    end

    return self.settings.filter.faction.noFaction and notContainded;
end

function private:FilterToysByProfession(name, itemId, collected)
    if (self.filterString and string.len(self.filterString) > 0) then
        return self:FilterToysByName(name);
    end

    if (not self.settings.filter.collected and collected) then
        return false;
    end

    if (not self.settings.filter.notCollected and not collected) then
        return false;
    end

    local notContainded = true;

    local allDisabled = true;
    local allEnabled = true;
    for _, value in pairs(self.settings.filter.profession) do
        if (value) then
            allDisabled = false;
        else
            allEnabled = false;
        end
    end

    if (allEnabled) then
        return true;
    end

    for profession, value in pairs(self.settings.filter.profession) do
        for _, category in pairs(ToyBoxEnhancedProfession) do
            if (category.Name == profession) then
                if (category.Data[itemId]) then
                    if (value) then
                        return true;
                    else
                        notContainded = false;
                    end
                end
                break;
            end
        end
    end

    if (not notContainded) then
        return false;
    end

    local isProfessionItem = false;
    for _, category in pairs(ToyBoxEnhancedSource) do
        if (category.Name == "Profession") then
            if (category.Data[itemId]) then
                isProfessionItem = true;
            end
            break;
        end
    end

    return isProfessionItem and (allDisabled or allEnabled);
end

function private:FilterToysByWorldEvent(name, itemId, collected)
    if (self.filterString and string.len(self.filterString) > 0) then
        return self:FilterToysByName(name);
    end

    if (not self.settings.filter.collected and collected) then
        return false;
    end

    if (not self.settings.filter.notCollected and not collected) then
        return false;
    end

    local notContainded = true;

    local allDisabled = true;
    local allEnabled = true;
    for _, value in pairs(self.settings.filter.worldEvent) do
        if (value) then
            allDisabled = false;
        else
            allEnabled = false;
        end
    end

    if (allEnabled) then
        return true;
    end

    for worldEvent, value in pairs(self.settings.filter.worldEvent) do
        for _, category in pairs(ToyBoxEnhancedWorldEvent) do
            if (category.Name == worldEvent) then
                if (category.Data[itemId]) then
                    if (value) then
                        return true;
                    else
                        notContainded = false;
                    end
                end
                break;
            end
        end
    end

    if (not notContainded) then
        return false;
    end

    local isWorldEventItem = false;
    for _, category in pairs(ToyBoxEnhancedSource) do
        if (category.Name == "World Event") then
            if (category.Data[itemId]) then
                isWorldEventItem = true;
            end
            break;
        end
    end

    return isWorldEventItem and (allDisabled or allEnabled);
end

function private:GetUsableToysCount()
    local toyCount = C_ToyBox.GetNumTotalDisplayedToys();
    if (C_ToyBox.GetNumFilteredToys() ~= toyCount) then
        C_ToyBox.SetAllSourceTypeFilters(true);
        C_ToyBox.SetFilterString("");
        C_ToyBox.SetCollectedShown(true);
        C_ToyBox.SetUncollectedShown(true);
    end

    local usableCount = 0;

    local toyCount = C_ToyBox.GetNumTotalDisplayedToys();
    for toyIndex = 1, toyCount do
        local itemId = C_ToyBox.GetToyInfo(C_ToyBox.GetToyFromIndex(toyIndex));
        if (PlayerHasToy(itemId) and self:IsToyUsable(itemId)) then
            usableCount = usableCount + 1;
        end
    end

    return usableCount;
end

function private:IsToyUsable(itemId)
    local _, _, _, _, reqLevel = GetItemInfo(itemId);
    local level = UnitLevel("player");
    if (not reqLevel or reqLevel > level) then
        return false;
    end

    if (not ToyBoxEnhancedConditions[itemId]) then
        return true;
    end

    local reqClass = ToyBoxEnhancedConditions[itemId].Class;
    if (reqClass) then
        local _, class = UnitClass("player");
        if (reqClass ~= class) then
            return false;
        end
    end
    
    local reqRace = ToyBoxEnhancedConditions[itemId].Race;
    if (reqRace) then
        local _, race = UnitRace("player");
        if (reqRace ~= race) then
            return false;
        end
    end
    
    local reqFaction = ToyBoxEnhancedConditions[itemId].Faction;
    if (reqFaction) then
        local faction = UnitFactionGroup("player");
        if (reqFaction ~= faction) then
            return false;
        end
    end

    local reqReputation = ToyBoxEnhancedConditions[itemId].Reputation;
    if (reqReputation) then
        local _, _, reputationValue = GetFactionInfoByID(reqReputation.Id);
        if (not reputationValue or reputationValue < reqReputation.Value) then
            return false;
        end
    end

    local reqProfession = ToyBoxEnhancedConditions[itemId].Profession;
    if (reqProfession) then
        local hasProfessionReq = false;

        local professionIndices = { GetProfessions() };
        for _, professionIndex in pairs(professionIndices) do
            local _, _, professionLevel, _, _, _, professionId, _, specialization = GetProfessionInfo(professionIndex)
            if (reqProfession.Id == professionId and reqProfession.Value <= professionLevel) then
                if (not reqProfession.Specialization or reqProfession.Specialization == specialization) then
                    hasProfessionReq = true;
                end
                break;
            end
        end

        if (not hasProfessionReq) then
            return false;
        end
    end

    return true;
end

function private:GetToyFromIndex(index)
    if (index > #self.filteredToyList) then
        return -1;
    end

    return self.filteredToyList[index];
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
        self:FilterToys();
        self:ToyBox_UpdatePages();
        self:ToyBox_UpdateButtons();

        if (new == 1) then
            ToyBox.newToys[itemID] = 1;
        end
    end
end

function private:OnAchievement()
    self.achievementFrame.staticText:SetText(GetCategoryAchievementPoints(TOY_ACHIEVEMENT_CATEGORY, true));
end

function private:OnCombatStateChanged()
    if (ToyBox:IsVisible()) then
        self:FilterToys();
        self:ToyBox_UpdatePages();
        self:ToyBox_UpdateButtons();
    end
end

function private:OnSlashCommand(command, parameter1, parameter2)
    if (command == "debug") then
        if (parameter1 == "on") then
            self.settings.debugMode = true;
            print("ToyBoxEnhanced: Debug mode activated.");
            return;
        end

        if (parameter1 == "off") then
            self.settings.debugMode = false;
            print("ToyBoxEnhanced: Debug mode deactivated.");
            return;
        end
    end

    print("Syntax:");
    print("/tbe debug (on | off)");
end