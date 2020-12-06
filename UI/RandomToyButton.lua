local ADDON_NAME, ADDON = ...

local MAX_GLOBAL_MACRO_COUNT = 120
local CLICK_TARGET_NAME = "TBERandomFavoredToy"
local MACRO_NAME, MACRO_ICON, MACRO_BODY = 'TBE: Random Toy', 'inv_misc_dice_02', "/click " .. CLICK_TARGET_NAME

local actionButton
local displayButton

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

    for itemId in pairs(ADDON.db.ingameList) do
        if PlayerHasToy(itemId) and C_ToyBox.GetIsFavorite(itemId) and C_ToyBox.IsToyUsable(itemId) then
            local startTime, duration = GetItemCooldown(itemId)
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

        if displayButton then
            displayButton.LockIcon:SetShown(#toys == 0)
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
    hooksecurefunc(C_ToyBox, "SetIsFavorite", updateButtonFavorites)
end

local function createDisplayButton()
    local L = ADDON.L
    displayButton = CreateFrame("Button", nil, ToyBox, "TBEUseRandomToyButtonTemplate")
    displayButton:RegisterForDrag("LeftButton")

    local toys = collectItemIds()
    displayButton.LockIcon:SetShown(#toys == 0)

    displayButton:SetScript("OnEnter", function(sender)
        GameTooltip:SetOwner(sender, "ANCHOR_NONE")
        GameTooltip:SetPoint("BOTTOMLEFT", sender, "TOPRIGHT", 0, 0)
        GameTooltip:SetText(L["RANDOM_TOY_TITLE"], 1, 1, 1)
        GameTooltip:AddLine(L["RANDOM_TOY_DESCRIPTION"])
        GameTooltip:Show()
    end);
    displayButton:SetScript("OnLeave", function(sender)
        GameTooltip:Hide()
    end);
end

local function checkClickMacro()
    if not GetMacroInfo(MACRO_NAME) and GetNumMacros() < MAX_GLOBAL_MACRO_COUNT then
        CreateMacro(MACRO_NAME, MACRO_ICON, MACRO_BODY)
    end
end

local function buildDelayTillOutOfCombat(func)
    return function()
        if InCombatLockdown() then
            local delayFrame = CreateFrame("Frame")
            delayFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
            delayFrame:SetScript("OnEvent", function()
                delayFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
                func()
            end)
        else
            func()
        end
    end
end

ADDON:RegisterLoginCallback(buildDelayTillOutOfCombat(function()
    checkClickMacro()
    initActionButton()
end))

ADDON:RegisterLoadUICallback(buildDelayTillOutOfCombat(createDisplayButton))
