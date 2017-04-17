local function flattenTable(source)
    local result = {}
    for _, category in pairs(source) do
        for id, name in pairs(category.Data) do
            result[id] = name
        end
    end

    return result
end

ToyBoxEnhancedWorldEvent = {
    {
        Name = "Timewalking",
        Data = {
            [129952] = "Hourglass of Eternity",
            [129926] = "Mark of the Ashtongue",
            [129938] = "Will of Northrend",
            [133511] = "Gurboggle's Gleaming Bauble",
            [133542] = "Tosselwrench's Mega-Accurate Simulation Viewfinder",
            [129929] = "Ever-Shifting Mirror",
            [144393] = "Portable Yak Wash",
        },
    },

    {
        Name = "Darkmoon Faire",
        Data = {
            [75042] = "Flimsy Yellow Balloon",
            [90899] = "Darkmoon Whistle",
            [101571] = "Moonfang Shroud",
            [105898] = "Moonfang's Paw",
            [116067] = "Ring of Broken Promises",
            [116115] = "Blazing Wings",
            [116139] = "Haunting Memento",
            [122119] = "Everlasting Darkmoon Firework",
            [122120] = "Gaze of the Darkmoon",
            [122121] = "Darkmoon Gazer",
            [122122] = "Darkmoon Tonk Controller",
            [122123] = "Darkmoon Ring-Flinger",
            [122126] = "Attraction Sign",
            [122129] = "Fire-Eater's Vial",
            [126931] = "Seafarer's Slidewhistle",
            [97994] = "Darkmoon Seesaw",
            [138202] = "Sparklepony XL",
        },
    },

    {
        Name = "Lunar Festival",
        Data = {
            [21540] = "Elune's Lantern",
            [89999] = "Everlasting Alliance Firework",
            [90000] = "Everlasting Horde Firework",
            [143827] = "Dragon Head Costume",
            [143828] = "Dragon Body Costume",
            [143829] = "Dragon Tail Costume",
        },
    },

    {
        Name = "Love is in the Air",
        Data = {
            [34480] = "Romantic Picnic Basket",
            [50471] = "The Heartbreaker",
            [116651] = "True Love Prism",
            [142341] = "Love Boat",
            [144339] = "Sturdy Love Fool",
        },
    },

    {
        Name = "Children's Week",
        Data = {
            [69895] = "Green Balloon",
            [69896] = "Yellow Balloon",
        },
    },

    {
        Name = "Midsummer Fire Festival",
        Data = {
            [34686] = "Brazier of Dancing Flames",
            [116435] = "Cozy Bonfire",
            [116440] = "Burning Defender's Medallion",
            [141649] = "Set of Matches",
        },
    },

    {
        Name = "Brewfest",
        Data = {
            [33927] = "Brewfest Pony Keg",
            [71137] = "Brewfest Keg Pony",
            [90427] = "Pandaren Brewpack",
            [116757] = "Steamworks Sausage Grill",
            [116758] = "Brewfest Banner",
            [138900] = "Gravil Goldbraid's Famous Sausage Hat",
        },
    },

    {
        Name = "Hallow's End",
        Data = {
            [70722] = "Little Wickerman",
            [128807] = "Coin of Many Faces",
            [128794] = "Sack of Spectral Spiders",
        },
    },

    {
        Name = "Day of the Dead",
        Data = {
            [116856] = "\"Blooming Rose\" Contender's Costume",
            [116888] = "\"Night Demon\" Contender's Costume",
            [116889] = "\"Purple Phantom\" Contender's Costume",
            [116890] = "\"Santo's Sun\" Contender's Costume",
            [116891] = "\"Snowy Owl\" Contender's Costume",
        },
    },

    {
        Name = "Pilgrim's Bounty",
        Data = {
            [116400] = "Silver-Plated Turkey Shooter",
        },
    },

    {
        Name = "Pirates' Day",
        Data = {
            [138415] = "Slightly-Chewed Insult Book",
        },
    },

    {
        Name = "Feast of Winter Veil",
        Data = {
            [17712] = "Winter Veil Disguise Kit",
            [37710] = "Crashin' Thrashin' Racer Controller",
            [46709] = "MiniZep Controller",
            [90883] = "The Pigskin",
            [90888] = "Foot Ball",
            [104318] = "Crashin' Thrashin' Flyer Controller",
            [116456] = "Scroll of Storytelling",
            [116689] = "Pineapple Lounge Cushion",
            [116690] = "Safari Lounge Cushion",
            [116691] = "Zhevra Lounge Cushion",
            [116692] = "Fuzzy Green Lounge Cushion",
            [116763] = "Crashin' Thrashin' Shredder Controller",
            [128776] = "Red Wooden Sled",
            [108632] = "Crashin' Thrashin' Flamer Controller",
            [108635] = "Crashin' Thrashin' Killdozer Controller",
            [139337] = "Disposable Winter Veil Suits",
            [128636] = "Endothermic Blaster",
        },
    },
};

ToyBoxEnhancedProfession = {
    {
        Name = "Jewelcrafting",
        Data = {
            [115503] = "Blazing Diamond Pendant",
            [130251] = "JewelCraft",
            [130254] = "Chatterstone",
        },
    },

    {
        Name = "Engineering",
        Data = {
            [17716] = "Snowmaster 9000",
            [18660] = "World Enlarger",
            [23767] = "Crashin' Thrashin' Robot",
            [40895] = "Gnomish X-Ray Specs",
            [108745] = "Personal Hologram",
            [109183] = "World Shrinker",
            [111821] = "Blingtron 5000",
            [132518] = "Blingtron's Circuit Design Tutorial",
            [40768] = "MOLL-E",
            [87214] = "Blingtron 4000",
            [109167] = "Findle's Loot-A-Rang",
            [87215] = "Wormhole Generator: Pandaria",
            [40727] = "Gnomish Gravity Well",
            [60854] = "Loot-A-Rang",
            [112059] = "Wormhole Centrifuge",
            [48933] = "Wormhole Generator: Northrend",
            [30544] = "Ultrasafe Transporter: Toshley's Station",
            [18986] = "Ultrasafe Transporter: Gadgetzan",
            [18984] = "Dimensional Ripper - Everlook",
            [30542] = "Dimensional Ripper - Area 52",
        },
    },

    {
        Name = "Archaeology",
        Data = {
            [64358] = "Highborne Soul Mirror",
            [64361] = "Druid and Priest Statue Set",
            [64373] = "Chalice of the Mountain Kings",
            [64383] = "Kaldorei Wind Chimes",
            [64456] = "Arrival of the Naaru",
            [64481] = "Blessing of the Old God",
            [64482] = "Puzzle Box of Yogg-Saron",
            [64646] = "Bones of Transformation",
            [64651] = "Wisp Amulet",
            [64881] = "Pendant of the Scarab Storm",
            [69775] = "Vrykul Drinking Horn",
            [69776] = "Ancient Amber",
            [69777] = "Haunted War Drum",
            [131724] = "Crystalline Eye of Undravius",
            [64488] = "The Innkeeper's Daughter",
            [89614] = "Anatomical Dummy",
        },
    },

    {
        Name = "Cooking",
        Data = {
            [88801] = "Flippable Table",
            [134020] = "Chef's Hat",
        },
    },

    {
        Name = "Fishing",
        Data = {
            [44430] = "Titanium Seal of Dalaran",
            [45984] = "Unusual Compass",
            [85973] = "Ancient Pandaren Fishing Charm",
            [142528] = "Crate of Bobbers: Can of Worms",
            [142529] = "Crate of Bobbers: Cat Head",
            [142530] = "Crate of Bobbers: Tugboat",
            [143662] = "Crate of Bobbers: Wooden Pepe",
        },
    },

    {
        Name = "Leatherworking",
        Data = {
            [129956] = "Leather Love Seat",
            [129960] = "Leather Pet Bed",
            [129961] = "Flaming Hoop",
            [129958] = "Leather Pet Leash",
        },
    },

    {
        Name = "Enchanting",
        Data = {
            [128536] = "Leylight Brazier",
        },
    },

    {
        Name = "Inscription",
        Data = {
            [129211] = "Steamy Romance Novel Kit",
        },
    },
};

ToyBoxEnhancedFaction = {
    alliance = {
        [45011] = "Stormwind Banner",
        [45018] = "Ironforge Banner",
        [45019] = "Gnomeregan Banner",
        [45020] = "Exodar Banner",
        [45021] = "Darnassus Banner",
        [54651] = "Gnomeregan Pride",
        [63141] = "Tol Barad Searchlight",
        [89999] = "Everlasting Alliance Firework",
        [95589] = "Glorious Standard of the Kirin Tor Offensive",
        [119144] = "Touch of the Naaru",
        [119182] = "Soul Evacuation Crystal",
        [119217] = "Alliance Flag of Victory",
        [128462] = "Karabor Councilor's Attire",
        [95567] = "Kirin Tor Beacon",
        [115472] = "Permanent Time Bubble",
        [119421] = "Sha'tari Defender's Medallion",
    },

    horde = {
        [53057] = "Faded Wizard Hat",
        [54653] = "Darkspear Pride",
        [45013] = "Thunder Bluff Banner",
        [45014] = "Orgrimmar Banner",
        [45015] = "Sen'jin Banner",
        [45016] = "Undercity Banner",
        [45017] = "Silvermoon City Banner",
        [64997] = "Tol Barad Searchlight",
        [89205] = "Mini Mana Bomb",
        [90000] = "Everlasting Horde Firework",
        [95590] = "Glorious Standard of the Sunreaver Onslaught",
        [115468] = "Permanent Frost Essence",
        [115503] = "Blazing Diamond Pendant",
        [119145] = "Firefury Totem",
        [119160] = "Tickle Totem",
        [119218] = "Horde Flag of Victory",
        [128471] = "Frostwolf Grunt's Battlegear",
        [95568] = "Sunreaver Beacon",
    },
};

ToyBoxEnhancedSource = {
    {
        Name = "Treasure",
        Data = {
            -- Draenor
            [108735] = "Arena Master's War Horn",
            [108739] = "Pretty Draenor Pearl",
            [108743] = "Deceptia's Smoldering Boots",
            [109739] = "Star Chart",
            [113375] = "Vindicator's Armor Polish Kit",
            [117569] = "Giant Deathweb Egg",
            [117550] = "Angry Beehive",
            [118716] = "Goren Garb",
            [127859] = "Dazzling Rod",
            [127394] = "Podling Camouflage",
            [127766] = "The Perfect Blossom",
            [127668] = "Jewel of Hellfire",
            [127670] = "Accursed Tome of the Sargerei",
            [127709] = "Throbbing Blood Orb",
            [116120] = "Tasty Talador Lunch",
            [128223] = "Bottomless Stygana Mushroom Brew",

            -- Legion
            [130147] = "Thistleleaf Branch",
            [141296] = "Ancient Mana Basin",
            [140786] = "Ley Spider Eggs",
            [141299] = "Kaldorei Light Globe",
            [141301] = "Unstable Powder Box",
            [134024] = "Cursed Swabby Helmet",
            [141306] = "Wisp in a Bottle",
            [122681] = "Sternfathom's Pet Journal",
            [102467] = "Censer of Eternal Agony",
            [130169] = "Tournament Favor",
            [131811] = "Rocfeather Skyhorn Kite",
            [129165] = "Barnacle-Encrusted Gem",
            [127669] = "Skull of the Mad Chief",
            [129055] = "Shoe Shine Kit",
            [141297] = "Arcano-Shower",
            [141298] = "Displacer Meditation Stone",
            [140780] = "Fal'dorei Egg",
            [143534] = "Wand of Simulated Life",
        },
    },

    {
        Name = "Drop",
        Data = {
            [1973] = "Täuschungskugel",
            [32782] = "Zeitverlorene Statuette",
            [37254] = "Super Sai'ansphäre",

            -- Pandaria
            [86568] = "Handlanger Peins Messingkompass",
            [86571] = "Kangs Bindungsstein",
            [86575] = "Kelch der Geheimnisse",
            [86581] = "Weitwassermuschelhorn",
            [86586] = "Pandarische Panflöte",
            [86588] = "Pandarischer Raketenzünder",
            [86589] = "Ai-Lis Himmelsspiegel",
            [86593] = "Ho-zen-Strandball",
            [90067] = "Freundschaftshalskette",
            [104262] = "Seltsamer glatt geschliffener Stein",
            [104294] = "Reif des zeitverlorenen Seefahrers",
            [104302] = "Schwarzflammendolche",
            [104309] = "Ewiger Flammenkessel",
            [104331] = "Warnschild",
            [86573] = "Fragment des Abschlusssteins",

            -- Draenor
            [113570] = "Urtumblüte",
            [111476] = "Geraubter Atem",
            [113631] = "Hypnosebrille",
            [113670] = "Murmurs trauriges Klagen",
            [114227] = "Blubberblasenzauberstab",
            [116122] = "Schreiben der Brennenden Legion",
            [116125] = "Klikixx' Netzweber",
            [118221] = "Stein der Versteinerung",
            [118222] = "Geist von Bashiok",
            [118244] = "Hut des Eisernen Bukaniers",
            [119163] = "Seeleninhalierer",
            [119178] = "Schwarzer Wirbelwind",
            [119432] = "Botanitarnung",
            [120276] = "Kettentrense des Vorhutreiters",
            [127652] = "Teufelsflammenlagerfeuer",
            [127659] = "Hut des geisterhaften eisernen Bukaniers",
            [127666] = "Phiole mit rotem Glibber",
            [128328] = "Skollers Beutel voll Eichhörnchenleckerlis",
            [122117] = "Verfluchte Feder von Ikzan",
            [108634] = "Krachbummmörsersteuerung",
            [108633] = "Krachbummkanonensteuerung",
            [108631] = "Krachbummwalzensteuerung",
            
            -- Legion
            [113540] = "Ba'ruuns buntes Buffet",
            [113542] = "Flüstern von Rai'Vosh",
            [134019] = "Don Carlos' berühmter Hut",
            [113543] = "Geist von Shinri",
            [134023] = "Abgefüllter Tornado",
            [86590] = "Essenz der Brise",
            [86594] = "Pfeife des hilfreichen Nupsi",
            [86565] = "Schlachthorn",
            [140363] = "Taschenteufelskondensator",
            [130214] = "Verschlissene Puppe",
            [130171] = "Verfluchte Kugel",
            [116113] = "Atem von Talador",
            [104329] = "Aschebedecktes Horn",
            [119180] = "Goren-Stamm-Walze",
            [129113] = "Schwach leuchtende Metflasche",
            [118224] = "Ogerbrauausrüstung",
            [89139] = "Haustierkette",
            [86578] = "Siegel des ewigen Kriegers",
            [134022] = "Bürgi Schwarzherzens Hübscher Hut",
            [131900] = "Huf eines majestätischen Urhorns",
            [86582] = "Wasserjuwel",
            [86583] = "Schlachtbanner von Salyis",
            [127655] = "Vorlauter Wichtel",
            [86584] = "Gehärteter Panzer",
            [142265] = "Große rote Strahlenkanone",
            [147843] = "Siras Ersatzumhang", -- from warden paragon cache
            [147867] = "Gestohlener Feger",
        },
    },

    {
        Name = "Quest",
        Data = {
            [30690] = "Power Converter",
            [53057] = "Faded Wizard Hat",
            [123851] = "Photo B.O.M.B.", -- Blingtron-5000
            
            -- Molten Front
            [71259] = "Leyara's Locket",

            -- Cataclysm
            [54651] = "Gnomeregan Pride",
            [54653] = "Darkspear Pride",

            -- Pandaria
            [80822] = "The Golden Banana",
            [82467] = "Ruthers' Harness",
            [88589] = "Cremating Torch",
            [88417] = "Gokk'lok's Shell",
            [88385] = "Hozen Idol",
            [88579] = "Jin Warmkeg's Brew",
            [88580] = "Ken-Ken's Mask",
            [88531] = "Lao Chin's Last Mug",
            [88370] = "Puntable Marmot",
            [88377] = "Turnip Paint \"Gun\"",
            [88387] = "Shushen's Spittoon",
            [88381] = "Silversage Incense",
            [88584] = "Totem of Harmony",
            [88375] = "Turnip Punching Bag",
            [95567] = "Kirin Tor Beacon", -- Alliance
            [95568] = "Sunreaver Beacon", -- Horde

            -- Draenor
            [119001] = "Mystery Keg",
            [119134] = "Sargerei Disguise",
            [119144] = "Touch of the Naaru",
            [119145] = "Firefury Totem",
            [119093] = "Aviana's Feather",
            [115506] = "Treessassin's Guise",
            [118935] = "Ever-Blooming Frond",

            -- Legion
            [129093] = "Ravenbear Disguise",
            [138873] = "Mystical Frosh Hat",
            [134021] = "X-52 Rocket Helmet",
            [141879] = "Berglrgl Perrgl Girggrlf",
            [131933] = "Critter Hand Cannon",
            [133997] = "Black Ice",
            [138876] = "Runas' Crystal Grinder",
            [130209] = "Never Ending Toy Chest",
            [138878] = "Copy of Daglop's Contract",
            [133998] = "Rainbow Generator",
            [142494] = "Purple Blossom",
            [142495] = "Fake Teeth",
            [142496] = "Dirty Spoon",
            [142497] = "Tiny Pack",
            [147838] = "Akazamzarak's Spare Hat", -- mage class quest
            [143727] = "Champion's Salute", -- class hall quest
        },
    },

    {
        Name = "Vendor",
        Data = {
            [43499] = "Iron Boot Flask",
            [68806] = "Kalytha's Haunted Locket",
            [88802] = "Foxicopter Controller",
            [91904] = "Stackable Stag",

            -- Toy vendors
            [44606] = "Toy Train Set",
            [45057] = "Wind-Up Train Wrecker",
            [54343] = "Blue Crashin' Thrashin' Racer Controller",
            [54437] = "Tiny Green Ragdoll",
            [54438] = "Tiny Blue Ragdoll",
            [104323] = "The Pigskin",
            [104324] = "Foot Ball",

            -- Argent Tournament
            [45011] = "Stormwind Banner",
            [45013] = "Thunder Bluff Banner",
            [45014] = "Orgrimmar Banner",
            [45015] = "Sen'jin Banner",
            [45016] = "Undercity Banner",
            [45017] = "Silvermoon City Banner",
            [45018] = "Ironforge Banner",
            [45019] = "Gnomeregan Banner",
            [45020] = "Exodar Banner",
            [45021] = "Darnassus Banner",
            [46843] = "Argent Crusader's Banner",

            -- Molten Front
            [70159] = "Mylune's Call",
            [70161] = "Mushroom Chair",

            -- Battlefield Barrens
            [97919] = "Whole-Body Shrinka'",
            [97921] = "Bom'bay's Color-Seein' Sauce", -- no longer available
            [97942] = "Sen'jin Spirit Drum",
            [98552] = "Xan'tish's Flute",

            -- Garrison
            [113096] = "Bloodmane Charm",
            [119210] = "Hearthstone Board",
            [119212] = "Winning Hand",
            
            [127695] = "Spirit Wand",
            [127696] = "Magic Pet Mirror",
            [127707] = "Indestructible Bone",
            [127864] = "Personal Spotlight",
            [44820] = "Red Ribbon Pet Leash",
            [37460] = "Rope Pet Leash",

            -- Legion
            [137294] = "Dalaran Initiates' Pin",
            [136846] = "Familiar Stone",
            [140336] = "Brulfist Idol",
            [134007] = "Eternal Black Diamond Ring",
            [129057] = "Dalaran Disc",
            [140231] = "Narcissa's Mirror",
            [140309] = "Prismatic Bauble",
            [137663] = "Soft Foam Sword",
            [130151] = "The \"Devilsaur\" Lunchbox",
            [134004] = "Noble's Eternal Elementium Signet",
            [136855] = "Hunter's Call", -- only Hunter
            [136849] = "Nature's Beacon", -- only Druid
            [136927] = "Scarlet Confessional Book", -- only Priest
            [136928] = "Thaumaturgist's Orb", -- only Priest
            [136934] = "Raging Elemental Stone", -- only Shaman
            [136935] = "Tadpole Cloudseeder", -- only Shaman
            [136937] = "Vol'jin's Serpent Totem", -- only Shaman
            [138490] = "Waterspeaker's Totem", -- only Shaman
            [147537] = "A Tiny Set of Warglaives", -- demon hunter class hall
            [147832] = "Magical Saucer", -- mage class hall
        },
    },

    {
        Name = "Profession",
        Data = flattenTable(ToyBoxEnhancedProfession),
    },

    {
        Name = "Instance",
        Data = {
            -- Stratholme
            [13379] = "Piccolo of the Flaming Fire",
        
            -- Scholomance
            [88566] = "Krastinov's Bag of Horrors",

            -- Magisters' Terrace
            [35275] = "Orb of the Sin'dorei",

            -- Icecrown Citadel
            [52201] = "Muradin's Favor",
            [52253] = "Sylvanas' Music Box",

            -- Firelands
            [122304] = "Fandral's Seed Pouch",
            
            -- Throne of Thunder
            [98132] = "Shado-Pan Geyser Gun",
            [98136] = "Gastropod Shell",

            -- Nighthold
            [143544] = "Skull of Corruption",
            [142536] = "Memory Cube",
        },
    },

    {
        Name = "Reputation",
        Data = {
            [44719] = "Frenzyheart Brew",
            [63141] = "Tol Barad Searchlight",
            [64997] = "Tol Barad Searchlight",
            [66888] = "Stave of Fur and Claw",

            -- Pandaria
            [85500] = "Anglers Fishing Raft",
            [86596] = "Nat's Fishing Chair",
            [89222] = "Cloud Ring",
            [89869] = "Pandaren Scarecrow",
            [90175] = "Gin-Ji Knife Set",
            [95589] = "Glorious Standard of the Kirin Tor Offensive",
            [95590] = "Glorious Standard of the Sunreaver Onslaught",
            [103685] = "Celestial Defender's Medallion",

            -- Draenor
            [115468] = "Permanent Frost Essence",
            [119160] = "Tickle Totem",
            [119182] = "Soul Evacuation Crystal",
            [119421] = "Sha'tari Defender's Medallion",
            [128462] = "Karabor Councilor's Attire",
            [128471] = "Frostwolf Grunt's Battlegear",
            [122283] = "Rukhmar's Sacred Memory",
            [115472] = "Permanent Time Bubble", -- Alliance

            -- Legion
            [130157] = "Syxsehnz Rod",
            [130158] = "Path of Elothir",
            [130191] = "Trapped Treasure Chest Kit",
            [130199] = "Legion Pocket Portal",
            [131814] = "Whitewater Carp",
            [131812] = "Darkshard Fragment",
            [130170] = "Tear of the Green Aspect",
            [129149] = "Death's Door Charm",
            [130232] = "Moonfeather Statue",
            [140324] = "Mobile Telemancy Beacon",
            [129279] = "Enchanted Stone Whistle",
            [140325] = "Home Made Party Mask",
            [142531] = "Crate of Bobbers: Squeaky Duck",
            [142532] = "Crate of Bobbers: Murloc Head",
            [147307] = "Carved Wooden Helm",
            [147308] = "Enchanted Bobber",
            [147309] = "Face of the Forest",
            [147310] = "Floating Totem",
            [147311] = "Replica Gondola",
            [147312] = "Demon Noggin",
            [147708] = "Legion Invasion Simulator ",
        },
    },

    {
        Name = "Achievement",
        Data = {
            [43824] = "The Schools of Arcane Magic - Mastery",
            [44430] = "Titanium Seal of Dalaran",
            [87528] = "Honorary Brewmaster Keg",
            [89205] = "Mini Mana Bomb", -- no longer available
            [92738] = "Safari Hat",
            [116115] = "Blazing Wings",
            [119215] = "Robo-Gnomebulator",
            [122293] = "Trans-Dimensional Bird Whistle",

            --[122187] = "Mikro-Garni-Blaster", -- now not available

            -- Legion
            [139773] = "Emerald Winds",
            [143660] = "Mrgrglhjorn",
        },
    },

    {
        Name = "Garrison",
        Data = {
            [122700] = "Portable Audiophone",
        
            -- Garrison Mission
            [118191] = "Archmage Vargoth's Spare Staff",
            [118427] = "Autographed Hearthstone Card",
            [122674] = "S.E.L.F.I.E. Camera MkII",
            [128310] = "Burning Blade",

            -- Garrison Campaign
            [119134] = "Sargerei Disguise",
            [119144] = "Touch of the Naaru",

            -- Gladiator's Sanctum
            [119217] = "Alliance Flag of Victory",
            [119218] = "Horde Flag of Victory",
            [119219] = "Warlord's Flag of Victory",

            -- Lunarfall Inn / Frostwall Tavern
            [117573] = "Wayfarer's Bonfire",
            [118937] = "Gamon's Braid",
            [118938] = "Manastorm's Duplicator",
            [119003] = "Void Totem",
            [119039] = "Lilian's Warning Sign",
            [119083] = "Fruit Basket",
            [119092] = "Moroes' Famous Polish",

            -- Benjamin Brode
            [119210] = "Hearthstone Board",
            [119212] = "Winning Hand",

            -- Trading Post
            [113096] = "Bloodmane Charm",
            
            -- Giada Goldleash, Tiffy Trapspring
            [127695] = "Spirit Wand",
            [127696] = "Magic Pet Mirror",
            [127707] = "Indestructible Bone",
            
            -- Trader Araanda, Trader Darakk
            [127864] = "Personal Spotlight",
            
            -- Jonathan Stephens, Moz'def
            [122298] = "Bodyguard Miniaturization Device",
        },
    },

    {
        Name = "World Event",
        Data = flattenTable(ToyBoxEnhancedWorldEvent),
    },

    {
        Name = "Pick Pocket",
        Data = {
            [36862] = "Worn Troll Dice",
            [36863] = "Decahedral Dwarven Dice",
            [63269] = "Loaded Gnomish Dice",
            [120857] = "Barrel of Bandanas",
        },
    },

    {
        Name = "Black Market",
        Data = {
            [32542] = "Imp in a Ball",
            [32566] = "Picnic Basket",
            [33219] = "Goblin Gumbo Kettle",
            [33223] = "Fishing Chair",
            [34499] = "Paper Flying Machine Kit",
            [35227] = "Goblin Weather Machine - Prototype 01-B",
            [38578] = "The Flag of Ownership",
            [45063] = "Foam Sword Rack",
            [46780] = "Ogre Pinata",
        },
    },

    {
        Name = "Promotion",
        Data = {
            -- Event
            [33079] = "Murloc Costume",
            [142542] = "Tome of Town Portal",
            [143543] = "Twelve-String Guitar",

            -- Trading Card Game
            [33219] = "Goblin Gumbo Kettle",
            [33223] = "Fishing Chair",
            [32566] = "Picnic Basket",
            [34499] = "Paper Flying Machine Kit",
            [32542] = "Imp in a Ball",
            [35227] = "Goblin Weather Machine - Prototype 01-B",
            [38301] = "D.I.S.C.O.",
            [38578] = "The Flag of Ownership",
            [45063] = "Foam Sword Rack",
            [46780] = "Ogre Pinata",
            [49703] = "Perpetual Purple Firework",
            [49704] = "Carved Ogre Idol",
            [54212] = "Instant Statue Pedestal",
            [67097] = "Grim Campfire",
            [69215] = "War Party Hitching Post",
            [69227] = "Fool's Gold",
            [71628] = "Sack of Starfish",
            [72159] = "Magical Ogre Idol",
            [72161] = "Spurious Sarcophagus",
            [79769] = "Demon Hunter's Aspect",

            -- Blizzard Store
            [112324] = "Nightmarish Hitching Post",
        },
    },
};