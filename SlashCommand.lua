local _, ADDON = ...

SLASH_TOYBOXENHANCED1, SLASH_TOYBOXENHANCED2 = '/toyboxenhanced', '/tbe'
function SlashCmdList.TOYBOXENHANCED(msg)
    msg = msg:lower()

    if ADDON.TakeScreenshots and msg == "screenshot" then
        ADDON:TakeScreenshots()
    else
        ADDON:OpenSettings()
    end
end

if not SLASH_TOYS1 then
    SLASH_TOYS1 = '/toys'
    function SlashCmdList.TOYS()
        if not InCombatLockdown() then
            ToggleCollectionsJournal(COLLECTIONS_JOURNAL_TAB_INDEX_TOYS)
        end
    end
end