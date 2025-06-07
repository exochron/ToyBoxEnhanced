local _, ADDON = ...

local function CreateContextMenu(owner, root, itemId)
    local isFavorite = ADDON.Api:GetIsFavorite(itemId)

    if isFavorite then
        root:CreateButton(BATTLE_PET_UNFAVORITE, function()
            ADDON.Api:SetIsFavorite(itemId, false)
        end)
    else
        root:CreateButton(BATTLE_PET_FAVORITE, function()
            ADDON.Api:SetIsFavorite(itemId, true)
            SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE, true)
            HelpTip:Hide(ToyBox, TOYBOX_FAVORITE_HELP)
        end)
    end

    local isHidden = itemId and ADDON.settings.hiddenToys[itemId]
    if isHidden then
        root:CreateButton(SHOW, function()
            ADDON.settings.hiddenToys[itemId] = nil
            ADDON:FilterToys()
        end)
    else
        root:CreateButton(HIDE, function()
            ADDON.settings.hiddenToys[itemId] = true
            ADDON:FilterToys()
        end)
    end
end

ADDON.Events:RegisterCallback("OnLoadUI", function()
    for i = 1, ADDON.TOYS_PER_PAGE do
        ToyBox.EnhancedLayer["spellButton" .. i]:HookScript("OnClick", function(sender, button)
            if not IsModifiedClick() and not sender.isPassive and button ~= "LeftButton" and sender.itemID then
                MenuUtil.CreateContextMenu(sender, CreateContextMenu, sender.itemID)
            end
        end)
    end
end, "options-menu")