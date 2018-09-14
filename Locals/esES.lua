local ADDON_NAME, ADDON = ...

if (GetLocale() == 'esES') then
    local L = ADDON.L or {}

    L["Toys"] = "Juguetes"
    L["Usable"] = "Utilizable"
    L["Hidden"] = "Oculto"
    L["Only usable"] = "Sólo utilizable"
    L["Reset filters"] = "Reiniciar Filtros"

    -- Source
    L["Treasure"] = "Tesoro"
    L["Order Hall"] = "Sede de clase"
    L["Pick Pocket"] = "Robado"
    L["Black Market"] = "Mercado Negro"

    -- Profession
    L["Jewelcrafting"] = "Joyería"
    L["Engineering"] = "Ingeniería"
    L["Leatherworking"] = "Peletería";
    L["Enchanting"] = "Encantamiento";

    -- World Event
    L["Lunar Festival"] = "Festival Lunar"
    L["Love is in the Air"] = "Amor en el aire"
    L["Children's Week"] = "Semana de los niños"
    L["Midsummer Fire Festival"] = "Festival de Fuego del Solsticio"
    L["Brewfest"] = "Fiesta de la Cerveza"
    L["Hallow's End"] = "Halloween"
    L["Day of the Dead"] = "Día de los Muertos"
    L["Pilgrim's Bounty"] = "Festividad del Peregrino"
    L["Pirates' Day"] = "Día de los Piratas";
    L["Feast of Winter Veil"] = "Festival de Invierno"

    ADDON.L = L
end