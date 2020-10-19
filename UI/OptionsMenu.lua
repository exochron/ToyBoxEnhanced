local ADDON_NAME, ADDON = ...

local function InitMenu(sender, level)
    local itemId = sender.itemId

    local info = MSA_DropDownMenu_CreateInfo()
    info.notCheckable = true
    info.disabled = nil

    if (itemId and PlayerHasToy(itemId)) then
        local isFavorite = C_ToyBox.GetIsFavorite(itemId)

        if (isFavorite) then
            info.text = BATTLE_PET_UNFAVORITE
            info.func = function()
                C_ToyBox.SetIsFavorite(itemId, false)
            end
        else
            info.text = BATTLE_PET_FAVORITE
            info.func = function()
                C_ToyBox.SetIsFavorite(itemId, true)
                SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE, true)
                HelpTip:Hide(ToyBox, TOYBOX_FAVORITE_HELP)
            end
        end

        MSA_DropDownMenu_AddButton(info, level)
        info.disabled = nil
    end

    local isHidden = itemId and ADDON.settings.hiddenToys[itemId]
    if (isHidden) then
        info.text = SHOW
        info.func = function()
            ADDON.settings.hiddenToys[itemId] = nil
            ADDON:FilterAndRefresh()
        end
    else
        info.text = HIDE
        info.func = function()
            ADDON.settings.hiddenToys[itemId] = true
            ADDON:FilterAndRefresh()
        end
    end
    MSA_DropDownMenu_AddButton(info, level)
    info.disabled = nil

    info.text = CANCEL
    info.func = nil
    MSA_DropDownMenu_AddButton(info, level)
end

ADDON:RegisterLoadUICallback( function()
    local menu = MSA_DropDownMenu_Create(ADDON_NAME .. "ToyMenu", ToyBox)
    MSA_DropDownMenu_Initialize(menu, InitMenu, "MENU")

    for i = 1, ADDON.TOYS_PER_PAGE do
        ToyBox.EnhancedLayer["spellButton"..i]:HookScript("OnClick", function(sender, button)
            if (not IsModifiedClick() and not sender.isPassive and button ~= "LeftButton") then
                menu.itemId = sender.itemID
                MSA_ToggleDropDownMenu(1, nil, menu, sender, 0, 0)
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
            end
        end)
    end
end)