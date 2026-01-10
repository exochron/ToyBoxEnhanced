local ADDON_NAME, ADDON = ...

if not AddonCompartmentFrame then
    return
end

AddonCompartmentFrame:RegisterAddon({
    text = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Title"),
    icon = C_AddOns.GetAddOnMetadata(ADDON_NAME, "IconTexture"),
    registerForAnyClick = true,
    notCheckable = true,
    func = function(_, inputData)
        if inputData.buttonName == "RightButton" then
            ADDON:OpenSettings()
        elseif not InCombatLockdown() then
            ToggleCollectionsJournal(COLLECTIONS_JOURNAL_TAB_INDEX_TOYS)
        end
    end,
    funcOnEnter = function(menuItem)
        GameTooltip:SetOwner(menuItem, "ANCHOR_CURSOR")
        GameTooltip:SetText("|T" .. C_AddOns.GetAddOnMetadata(ADDON_NAME, "IconTexture") .. ":0|t " .. C_AddOns.GetAddOnMetadata(ADDON_NAME, "Title"))
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(ADDON.L.COMPARTMENT_TOOLTIP)
        GameTooltip:Show()
    end,
    funcOnLeave = function()
        GameTooltip:Hide()
    end,
})