local ADDON_NAME, ADDON = ...

if (GetLocale() == 'esES') then
    local L = ADDON.L or {}

    L["Hidden"] = "Oculto"
    L["Only usable"] = "Sólo utilizable"
    L["Reset filters"] = "Reiniciar Filtros"
    L["Toys"] = "Juguetes"
    L["Usable"] = "Utilizable"

    -- Settings

    -- Source
    L["Black Market"] = "Mercado Negro"
    L["Enchanting"] = "Encantamiento"
    L["Engineering"] = "Ingeniería"
    L["Jewelcrafting"] = "Joyería"
    L["Leatherworking"] = "Peletería"
    L["Pick Pocket"] = "Robado"
    L["Treasure"] = "Tesoro"

    -- World Event
    L["Brewfest"] = "Fiesta de la Cerveza"
    L["Children's Week"] = "Semana de los niños"
    L["Day of the Dead"] = "Día de los Muertos"
    L["Feast of Winter Veil"] = "Festival de Invierno"
    L["Hallow's End"] = "Halloween"
    L["Love is in the Air"] = "Amor en el aire"
    L["Lunar Festival"] = "Festival Lunar"
    L["Midsummer Fire Festival"] = "Festival de Fuego del Solsticio"
    L["Pilgrim's Bounty"] = "Festividad del Peregrino"
    L["Pirates' Day"] = "Día de los Piratas"

    ADDON.L = L
end