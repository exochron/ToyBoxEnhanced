local _, ADDON = ...

function ADDON:TakeScreenshots()

    -- hide UI elements
    local UIElementsToHide={
        ChatFrame1,
        MainMenuBar,
        PlayerFrame,
        BuffFrame,
    }
    for _, frame in pairs(UIElementsToHide) do
        frame:Hide()
    end

    if WeakAuras then
        WeakAuras:Toggle() -- turn off WA
    end
    ToggleCollectionsJournal(COLLECTIONS_JOURNAL_TAB_INDEX_TOYS)

    -- give time to load properly
    C_Timer.After(0.5, function()
        local gg = LibStub("GalleryGenerator")

        gg:TakeScreenshots(
            {
                function(api)
                    api:BackScreen()
                    api:Point(ADDON.UI.RandomButton)
                end,
                function(api)
                    api:BackScreen()
                    api:PointAndClick(ADDON.UI.FavoriteButton)
                end,
                function(api)
                    api:BackScreen()
                    api:Click(ToyBoxFilterButton)
                    api:Point(DropDownList1Button1, 20) -- Sort
                end,
                function(api)
                    api:BackScreen()
                    api:Click(ToyBoxFilterButton)
                    api:Point(DropDownList1Button11) -- Effects
                    api:Point(DropDownList2Button3, 20)
                end,
                function(api)
                    api:BackScreen()
                    api:Click(ToyBoxFilterButton)
                    api:Point(DropDownList1Button12) -- Sources
                    api:Point(DropDownList2Button4) -- world events
                end,
                function(api)
                    api:BackScreen()
                    ADDON:OpenSettings()
                end,
            },
            function()
                for _, frame in pairs(UIElementsToHide) do
                    frame:Show()
                end
                if WeakAuras then
                    WeakAuras:Toggle() -- turn on WA
                end
            end
        )
    end)
end