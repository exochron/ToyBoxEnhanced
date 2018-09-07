local ADDON_NAME, ADDON = ...

local function InitMenu(sender, level)
    local L = ADDON.L

    local info = UIDropDownMenu_CreateInfo()
    info.notCheckable = true
    info.disabled = nil

    if (ToyBox.menuItemID and PlayerHasToy(ToyBox.menuItemID)) then
        local isFavorite = ToyBox.menuItemID and C_ToyBox.GetIsFavorite(ToyBox.menuItemID)

        if (isFavorite) then
            info.text = BATTLE_PET_UNFAVORITE
            info.func = function()
                C_ToyBox.SetIsFavorite(ToyBox.menuItemID, false)
                ADDON:FilterAndRefresh()
            end
        else
            info.text = BATTLE_PET_FAVORITE
            info.func = function()
                C_ToyBox.SetIsFavorite(ToyBox.menuItemID, true)
                SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_TOYBOX_FAVORITE, true)
                ToyBox.favoriteHelpBox:Hide()
                ADDON:FilterAndRefresh()
            end
        end

        UIDropDownMenu_AddButton(info, level)
        info.disabled = nil
    end

    local itemId = ToyBox.menuItemID
    local isHidden = itemId and ADDON.settings.hiddenToys[itemId]
    if (isHidden) then
        info.text = L["Show"]
        info.func = function()
            ADDON.settings.hiddenToys[itemId] = nil
            ADDON:FilterAndRefresh()
        end
    else
        info.text = L["Hide"]
        info.func = function()
            ADDON.settings.hiddenToys[itemId] = true
            ADDON:FilterAndRefresh()
        end
    end

    UIDropDownMenu_AddButton(info, level)
    info.disabled = nil

    info.text = CANCEL
    info.func = nil
    UIDropDownMenu_AddButton(info, level)
end

ADDON:RegisterLoadUICallback( function()
    hooksecurefunc(ToyBox.toyOptionsMenu, "initialize", function(sender, level)
        UIDropDownMenu_InitializeHelper(sender)
        InitMenu(sender, level)
    end)
end)