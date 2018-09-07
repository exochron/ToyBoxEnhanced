local ADDON_NAME, ADDON = ...

SLASH_TOYBOXENHANCED1, SLASH_TOYBOXENHANCED2 = '/toyboxenhanced', '/tbe'
function SlashCmdList.TOYBOXENHANCED(msg, editBox)
    msg = msg:lower()

    if (msg == "debug on") then
        ADDON.settings.debugMode = true
        print("ToyBoxEnhanced: Debug mode activated.")
    elseif (parameter1 == "debug off") then
        ADDON.settings.debugMode = false
        print("ToyBoxEnhanced: Debug mode deactivated.")
    else
        print("Syntax:")
        print("/tbe debug (on | off)")
    end
end