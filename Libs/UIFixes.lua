-- This Lib contains some minor UI fixes by eXochron. (inspired by TaintLess)

-- The radio or check mark of a dropdown button doesn't get updated, while enabling or disabling the button.
-- The right colors are only set during initialisation.
if (tonumber(UI_DROPDOWN_ENABLE_ART_PATCH_VERSION) or 0) < 1 then
    UI_DROPDOWN_ENABLE_ART_PATCH_VERSION = 1
    local function set(region, active)
        region:SetDesaturated(not active)
        region:SetAlpha(active and 1 or 0.5)
    end
    hooksecurefunc("UIDropDownMenu_EnableButton", function(level, id)
        set(_G["DropDownList" .. level .. "Button" .. id .. "Check"], true)
        set(_G["DropDownList" .. level .. "Button" .. id .. "UnCheck"], true)
    end)
    hooksecurefunc("UIDropDownMenu_DisableButton", function(level, id)
        set(_G["DropDownList" .. level .. "Button" .. id .. "Check"], false)
        set(_G["DropDownList" .. level .. "Button" .. id .. "UnCheck"], false)
    end)
end

-- still needed ?
--if (tonumber(UI_PETJOURNAL_INIT_FIRST_CARD_PATCH_VERSION) or 0) < 1 then
--    UI_PETJOURNAL_INIT_FIRST_CARD_PATCH_VERSION = 1
--    local frame = CreateFrame("Frame")
--    frame:RegisterEvent("ADDON_LOADED")
--    frame:SetScript("OnEvent", function(self, event, arg1)
--        if PetJournal then
--            frame:UnregisterEvent("ADDON_LOADED")
--            PetJournal:HookScript("OnShow", function()
--                if not PetJournalPetCard.petID then
--                    --PetJournal_ShowPetCard(1)
--                end
--            end)
--        end
--    end)
--end