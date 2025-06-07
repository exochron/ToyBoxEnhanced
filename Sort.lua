local _, ADDON = ...

local cache = {}
local setTimer = false
local function CacheToy(itemId)
    if cache[itemId] then
        return cache[itemId][1], cache[itemId][2]
    end

    if not setTimer then
        C_Timer.After(0.1, function()
            cache = {}
            setTimer = false
        end)
        setTimer = true
    end

    local _, name = C_ToyBox.GetToyInfo(itemId)
    local isFavorite = ADDON.Api:GetIsFavorite(itemId)

    cache[itemId] = { name, isFavorite}

    return name, isFavorite
end

function ADDON:SortHandler(itemA, itemB)
    if itemA == itemB then
        return false
    end

    local result = false

    local nameA, isFavoriteA = CacheToy(itemA)
    local nameB, isFavoriteB = CacheToy(itemB)

    if ADDON.settings.sort.favoritesFirst and isFavoriteA ~= isFavoriteB then
        return isFavoriteA and not isFavoriteB
    end
    if ADDON.settings.sort.unownedAtLast then
        local isCollectedA = PlayerHasToy(itemA)
        local isCollectedB = PlayerHasToy(itemB)
        if isCollectedA ~= isCollectedB then
            return isCollectedA and not isCollectedB
        end
    end

    if ADDON.settings.sort.by == 'name' then
        result = (nameA or '') < (nameB or '') -- warning: names can be nil on uninitialised toys
    elseif ADDON.settings.sort.by == 'expansion' then
        result = itemA < itemB
    end

    if ADDON.settings.sort.descending then
        result = not result
    end

    return result
end