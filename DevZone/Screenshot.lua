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

    local function OpenFilterMenu()
        ADDON.UI.FilterDropdown:OpenMenu()
        --for k, v in pairs(Menu.GetManager():GetOpenMenu()) do
        --    print(k,v)
        --end

        return { Menu.GetManager():GetOpenMenu():GetChildren() }
    end

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
                    api:Point(ADDON.UI.FavoriteButton)
                    ADDON.UI.FavoriteButton:OpenMenu()
                end,
                function(api)
                    api:BackScreen()
                    api:Point(OpenFilterMenu()[3]) -- Sort
                end,
                function(api)
                    api:BackScreen()
                    api:Point(OpenFilterMenu()[13]) -- Effects
                end,
                function(api)
                    api:BackScreen()
                    api:Point(OpenFilterMenu()[14]) -- Sources
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