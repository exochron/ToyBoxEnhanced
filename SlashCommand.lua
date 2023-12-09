local _, ADDON = ...

SLASH_TOYBOXENHANCED1, SLASH_TOYBOXENHANCED2 = '/toyboxenhanced', '/tbe'
function SlashCmdList.TOYBOXENHANCED(msg)
    msg = msg:lower()

    -- If you're reading this, then please don't use the debug command. It only helps me to find missing database entries and some bugs.
    -- You will also experience a significant performance drop with that.
    if msg == "debug on" then
        ADDON.settings.debugMode = true
        print("ToyBoxEnhanced: Debug mode activated.")
    elseif msg == "debug off" then
        ADDON.settings.debugMode = false
        print("ToyBoxEnhanced: Debug mode deactivated.")
    elseif ADDON.TakeScreenshots and msg == "screenshot" then
        ADDON:TakeScreenshots()
    else
        ADDON:OpenSettings()
    end
end

if not SLASH_TOYS1 then
    SLASH_TOYS1 = '/toys'
    function SlashCmdList.TOYS()
        ToggleCollectionsJournal(3);
    end
end