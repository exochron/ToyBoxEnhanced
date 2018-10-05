local ADDON_NAME, ADDON = ...

-- Keyboard Shortcuts:
-- LEFT: Previous page
-- RIGHT: Next page


ADDON:RegisterLoadUICallback(function()
    ToyBox.EnhancedLayer:SetPropagateKeyboardInput(true)
    ToyBox.EnhancedLayer:EnableKeyboard(true)
    ToyBox.EnhancedLayer:HookScript("OnKeyDown", function(self, key)
        if (key == "LEFT" or key == "RIGHT") and ADDON.settings.enableCursorKeys and not IsModifierKeyDown() then
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
end)