local _, ADDON = ...

local MAX_GLOBAL_MACRO_COUNT = 120
local CLICK_TARGET_NAME = "TBERandomFavoredToy"
local MACRO_NAME, MACRO_ICON, MACRO_BODY = 'TBE: Random Toy', 'inv_misc_dice_02', "/click " .. CLICK_TARGET_NAME .. " LeftButton true"

local actionButton

local function shuffle(tbl)
    local size = #tbl
    for i = size, 1, -1 do
        local rand = math.random(size)
        tbl[i], tbl[rand] = tbl[rand], tbl[i]
    end
    return tbl
end

local function collectItemIds()
    local items = {}

    local now = GetTime() + 60

    local _,_, favoredToys = ADDON.Api:GetFavoriteProfile()
    for _, itemId in ipairs(favoredToys) do
        if PlayerHasToy(itemId) and C_ToyBox.IsToyUsable(itemId) then
            local startTime, duration = C_Container.GetItemCooldown(itemId)
            if startTime == 0 or (startTime + duration) <= now then
                items[#items + 1] = itemId
            end
        end
    end

    return items
end

local function updateButtonFavorites()
    if actionButton and not InCombatLockdown() then
        local toys = collectItemIds()
        if #toys > 0 then
            local maxToys = 222
            if #toys > maxToys then
                toys = shuffle(toys)
                table.removemulti(toys, maxToys, #toys - maxToys + 1)
            end
            -- Execute() crashes on too long expressions. (~249 toys)
            actionButton:Execute('toys = newtable(' .. strjoin(',', unpack(toys)) .. ')')
            actionButton:SetAttribute("type", "toy")
        else
            actionButton:Execute('toys = newtable()')
            actionButton:SetAttribute("type", ATTRIBUTE_NOOP)
        end

        if ADDON.UI.RandomButton then
            ADDON.UI.RandomButton.LockIcon:SetShown(#toys == 0)
        end
    end
end

local function initActionButton()
    actionButton = _G[CLICK_TARGET_NAME]
    actionButton:WrapScript(actionButton, 'OnClick', [=[
    if #toys > 0 then
        self:SetAttribute("toy", toys[random(#toys)])
    end
    ]=])
    updateButtonFavorites()

    actionButton:RegisterEvent("PLAYER_REGEN_ENABLED")
    actionButton:SetScript("OnEvent", updateButtonFavorites)
    actionButton:HookScript("OnClick", updateButtonFavorites)
    ADDON.Events:RegisterCallback("OnFavoritesChanged", updateButtonFavorites, "random-favorites")
end

local function createDisplayButton()
    local L = ADDON.L
    ADDON.UI.RandomButton = CreateFrame("Button", nil, ToyBox, "TBEUseRandomToyButtonTemplate")
    ADDON.UI.RandomButton:RegisterForDrag("LeftButton")

    if ElvUI and ToyBox.PagingFrame.NextPageButton.IsSkinned then
        local E = unpack(ElvUI)
        local S = E:GetModule('Skins')
        ADDON.UI.RandomButton.icon = ADDON.UI.RandomButton.texture
        S:HandleItemButton(ADDON.UI.RandomButton, true)
    end

    if ToyBox.progressBar:IsShown() then -- classic
        ADDON.UI.RandomButton:SetPoint("CENTER", ToyBox, "TOP", "-125", "-42")
    end

    local toys = collectItemIds()
    ADDON.UI.RandomButton.LockIcon:SetShown(#toys == 0)

    ADDON.UI.RandomButton:SetScript("OnEnter", function(sender)
        GameTooltip:SetOwner(sender, "ANCHOR_NONE")
        GameTooltip:SetPoint("BOTTOMLEFT", sender, "TOPRIGHT", 0, 0)
        GameTooltip:SetText(L["RANDOM_TOY_TITLE"], 1, 1, 1)
        GameTooltip:AddLine(L["RANDOM_TOY_DESCRIPTION"])
        if ADDON.UI.RandomButton.LockIcon:IsShown() then
            GameTooltip:AddLine(L["RANDOM_TOY_LOCKED"], 1, 0, 0)
        end
        GameTooltip:Show()
    end);
    ADDON.UI.RandomButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end);
end

local function checkClickMacro()
    local existingName, existingIcon, existingBody = GetMacroInfo(MACRO_NAME)
    if not InCombatLockdown() then
        if not existingName and GetNumMacros() < MAX_GLOBAL_MACRO_COUNT then
            CreateMacro(MACRO_NAME, MACRO_ICON, MACRO_BODY)
        elseif existingName and (existingIcon ~= MACRO_ICON or nil == string.find(existingBody, MACRO_BODY)) then
            EditMacro(existingName, nil, MACRO_ICON, MACRO_BODY)
        end
    end
end

ADDON.Events:RegisterCallback("OnLogin", checkClickMacro, "random-macro")
ADDON.Events:RegisterCallback("OnLogin", initActionButton, "random-init")
ADDON.Events:RegisterCallback("OnLoadUI", createDisplayButton, "random-button")
