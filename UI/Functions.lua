local _, ADDON = ...

local function hookStripTextures()
    local frame = CreateFrame('Frame')
    if frame.StripTextures then
        local mt = getmetatable(frame).__index
        local org_Strip = mt.StripTextures
        mt.StripTextures = function(self, a, b, c, d, e, f, g, h, i)
            if _G['ToyBox'] then
                ADDON.Event:TriggerEvent("OnStripUI", self)
            end
            return org_Strip(self, a, b, c, d, e, f, g, h, i)
        end
    end
end
ADDON.Event:RegisterCallback("OnLogin", hookStripTextures, "ui-hooks")
