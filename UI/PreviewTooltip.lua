local _, ADDON = ...

local function isWeapon(invType)
    return invType == "INVTYPE_WEAPON" or invType == "INVTYPE_SHIELD" or invType == "INVTYPE_RANGED" or
            invType == "INVTYPE_RANGED" or invType == "INVTYPE_2HWEAPON" or invType == "INVTYPE_RELIC" or
            invType == "INVTYPE_WEAPONMAINHAND" or invType == "INVTYPE_WEAPONOFFHAND" or
            invType == "INVTYPE_HOLDABLE" or invType == "INVTYPE_THROWN" or invType == "INVTYPE_RANGEDRIGHT"
end

ADDON.Events:RegisterCallback("OnLogin", function()

    local backdropInfo = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileEdge = true,
        tileSize = 8,
        edgeSize = 8,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    }

    local preview = CreateFrame("DressUpModel", nil, nil, "BackdropTemplate")
    preview:SetSize(200, 200)
    preview:SetBackdrop(backdropInfo)
    preview:SetBackdropColor(0, 0, 0, 0.75)
    preview:SetFrameStrata("TOOLTIP")

    preview:SetUnit("player", true)

    local currentItem

    hooksecurefunc(GameTooltip, "SetToyByItemID", function(tooltip, itemId)
        if itemId ~= currentItem then
            currentItem = itemId
            preview:Hide()

            if itemId == 69896 then
                preview:SetPoint("TOPLEFT", tooltip, "BOTTOMLEFT", 0, 0)
                preview:Show()

                preview:SetCamera(1)
                preview:SetSheathed(false, false)
                C_Timer.After(0, function()
                    preview:SetCreature(53454)
                end)
            end

            if ADDON.db.preview[itemId] then
                preview:SetPoint("TOPLEFT", tooltip, "BOTTOMLEFT", 0, 0)
                preview:Show()

                preview:SetCamera(1)
                preview:SetSheathed(false, false)
                preview:SetUnit("player", true)

                if ADDON.db.preview[itemId]['armor'] then
                    preview:Undress()
                    C_Timer.After(0, function()
                        for _, armorId in ipairs(ADDON.db.preview[itemId]['armor']) do
                            preview:TryOn("item:" .. armorId)
                        end
                    end)
                    if 1 == #ADDON.db.preview[itemId]['armor'] and 1 == #GetKeysArray(ADDON.db.preview[itemId]) then
                        local armorId = ADDON.db.preview[itemId]['armor'][1]
                        local equipSlot = select(4, GetItemInfoInstant(armorId))
                        if equipSlot == "INVTYPE_HEAD" then
                            preview:SetCamera(0)
                        elseif C_TransmogCollection then
                            local appearanceID, sourceID = C_TransmogCollection.GetItemInfo(armorId)
                            if not sourceID and isWeapon(equipSlot) then
                                preview:Hide()
                                return
                            elseif sourceID and not isWeapon(equipSlot) then
                                Model_ApplyUICamera(preview, C_TransmogCollection.GetAppearanceCameraIDBySource(sourceID))
                            end
                        end
                    end
                end
                if ADDON.db.preview[itemId]['color'] then
                    C_Timer.After(0, function()
                        for _, visKit in ipairs(ADDON.db.preview[itemId]['color']) do
                            preview:ApplySpellVisualKit(visKit, false)
                        end
                    end)
                end
            end
        end
    end)
    hooksecurefunc(GameTooltip, "Hide", function()
        if preview:IsShown() then
            currentItem = nil
            preview:Hide()
        end
    end)
end, "preview-tooltip")