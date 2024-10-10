local _, ADDON = ...

-- Keyboard Shortcuts:
-- LEFT: Previous page
-- RIGHT: Next page


ADDON.Events:RegisterCallback("OnLoadUI", function()
    ToyBox.EnhancedLayer:SetPropagateKeyboardInput(true)
    ToyBox.EnhancedLayer:EnableKeyboard(true)
    ToyBox.EnhancedLayer:HookScript("OnKeyDown", function(self, key)
        if InCombatLockdown() then
            return
        end

        if (key == "LEFT" or key == "RIGHT") and ADDON.settings.ui.enableCursorKeys and not IsModifierKeyDown() then
            if key == "LEFT" then
                ToyBox.EnhancedLayer.PagingFrame:PreviousPage()
            elseif key == "RIGHT" then
                ToyBox.EnhancedLayer.PagingFrame:NextPage()
            end

            self:SetPropagateKeyboardInput(false)
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)
end, "hotkeys")