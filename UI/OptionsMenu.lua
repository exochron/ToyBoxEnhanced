local ADDON_NAME, ADDON = ...

local function InitDDMenu(sender, level)
    local itemId = sender.itemId

    local info

    if itemId and PlayerHasToy(itemId) then
        local isFavorite = ADDON.Api:GetIsFavorite(itemId)

        if isFavorite then
            info = {
                notCheckable = true,
                text = BATTLE_PET_UNFAVORITE,
                func = function()
                    ADDON.Api:SetIsFavorite(itemId, false)
                end
            }
            UIDropDownMenu_AddButton(info, level)
        else
            info = {
                notCheckable = true,
                text = BATTLE_PET_FAVORITE,
                func = function()
                    ADDON.Api:SetIsFavorite(itemId, true)
                    SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE, true)
                    HelpTip:Hide(ToyBox, TOYBOX_FAVORITE_HELP)
                end
            }
            UIDropDownMenu_AddButton(info, level)
        end
    end

    local isHidden = itemId and ADDON.settings.hiddenToys[itemId]
    if isHidden then
        info = {
            notCheckable = true,
            text = SHOW,
            func = function()
                ADDON.settings.hiddenToys[itemId] = nil
                ADDON:FilterToys()
            end
        }
        UIDropDownMenu_AddButton(info, level)
    else
        info = {
            notCheckable = true,
            text = HIDE,
            func = function()
                ADDON.settings.hiddenToys[itemId] = true
                ADDON:FilterToys()
            end
        }
        UIDropDownMenu_AddButton(info, level)
    end

    info = {
        notCheckable = true,
        text = CANCEL,
    }
    UIDropDownMenu_AddButton(info, level)
end

local function CreateContextMenu(owner, root, itemId)
    if itemId and PlayerHasToy(itemId) then
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

        root:CreateButton(CANCEL, function() end)
    end
end

ADDON.Events:RegisterCallback("OnLoadUI", function()
    local menu
    for i = 1, ADDON.TOYS_PER_PAGE do
        ToyBox.EnhancedLayer["spellButton" .. i]:HookScript("OnClick", function(sender, button)
            if not IsModifiedClick() and not sender.isPassive and button ~= "LeftButton" then
                if MenuUtil then
                    MenuUtil.CreateContextMenu(sender, CreateContextMenu, sender.itemID)
                else
                    if not menu then
                        menu = CreateFrame("Frame", ADDON_NAME .. "ToyMenu", ToyBox, "UIDropDownMenuTemplate")
                        UIDropDownMenu_Initialize(menu, InitDDMenu, "MENU")
                    end

                    menu.itemId = sender.itemID
                    ToggleDropDownMenu(1, nil, menu, sender, 0, 0)
                    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
                end
            end
        end)
    end
end, "options-menu")