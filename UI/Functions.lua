local _, ADDON = ...

ADDON.UI = {}

local function hookStripTextures()
    local frame = CreateFrame('Frame')
    if frame.StripTextures then
        local mt = getmetatable(frame).__index
        local org_Strip = mt.StripTextures
        mt.StripTextures = function(self, ...)
            if _G['ToyBox'] then
                ADDON.Events:TriggerEvent("OnStripUI", self)
            end
            return org_Strip(self, ...)
        end
    end
end
ADDON.Events:RegisterCallback("OnLogin", hookStripTextures, "ui-hooks")
