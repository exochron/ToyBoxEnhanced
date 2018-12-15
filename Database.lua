local ADDON_NAME, ADDON = ...

ADDON.db = {}

-- itemIds of all initially scanned toys
ADDON.db.ingameList = {}

ADDON.db.worldEvent = {

    ["Timewalking"] = {
        [129926] = "Mark of the Ashtongue",
        [129929] = "Ever-Shifting Mirror",
        [129938] = "Will of Northrend",
        [129952] = "Hourglass of Eternity",
        [129965] = "Grizzlesnout's Fang",
        [133511] = "Gurboggle's Gleaming Bauble",
        [133542] = "Tosselwrench's Mega-Accurate Simulation Viewfinder",
        [144072] = "Adopted Puppy Crate",
        [144393] = "Portable Yak Wash",
        [151016] = "Fractured Necrolyte Skull",
        [151184] = "Verdant Throwing Sphere",
    },

    ["Darkmoon Faire"] = {
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
        [151265] = "Blight Boar Microphone",
        [162539] = "Hot Buttered Popcorn",
    },

    ["Lunar Festival"] = {
        [21540] = "Elune's Lantern",
        [89999] = "Everlasting Alliance Firework",
        [90000] = "Everlasting Horde Firework",
        [143827] = "Dragon Head Costume",
        [143828] = "Dragon Body Costume",
        [143829] = "Dragon Tail Costume",
        [165671] = "Blue Dragon Head Costume",
        [165672] = "Blue Dragon Body Costume",
        [165673] = "Blue Dragon Tail Costume",
        [165674] = "Green Dragon Head Costume",
        [165675] = "Green Dragon Body Costume",
        [165676] = "Green Dragon Tail Costume",
        [165669] = "Lunar Elder's Hearthstone",
    },

    ["Love is in the Air"] = {
        [34480] = "Romantic Picnic Basket",
        [50471] = "The Heartbreaker",
        [116651] = "True Love Prism",
        [142341] = "Love Boat",
        [144339] = "Sturdy Love Fool",
        [165670] = "Peddlefeet's Lovely Hearthstone",
    },

    ["Children's Week"] = {
        [69895] = "Green Balloon",
        [69896] = "Yellow Balloon",
    },

    ["Midsummer Fire Festival"] = {
        [34686] = "Brazier of Dancing Flames",
        [116435] = "Cozy Bonfire",
        [116440] = "Burning Defender's Medallion",
        [141649] = "Set of Matches",
    },

    ["Brewfest"] = {
        [33927] = "Brewfest Pony Keg",
        [71137] = "Brewfest Keg Pony",
        [90427] = "Pandaren Brewpack",
        [116757] = "Steamworks Sausage Grill",
        [116758] = "Brewfest Banner",
        [138900] = "Gravil Goldbraid's Famous Sausage Hat",
    },

    ["Hallow's End"] = {
        [70722] = "Little Wickerman",
        [128807] = "Coin of Many Faces",
        [128794] = "Sack of Spectral Spiders",
        [151270] = "Horse Tail Costume",
        [151271] = "Horse Head Costume",
        [163045] = "Headless Horseman's Hearthstone",
    },

    ["Day of the Dead"] = {
        [116856] = "\"Blooming Rose\" Contender's Costume",
        [116888] = "\"Night Demon\" Contender's Costume",
        [116889] = "\"Purple Phantom\" Contender's Costume",
        [116890] = "\"Santo's Sun\" Contender's Costume",
        [116891] = "\"Snowy Owl\" Contender's Costume",
    },

    ["Pilgrim's Bounty"] = {
        [116400] = "Silver-Plated Turkey Shooter",
    },

    ["Pirates' Day"] = {
        [138415] = "Slightly-Chewed Insult Book",
        [150547] = "Jolly Roger",
    },

    ["Feast of Winter Veil"] = {
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
        [151343] = "Hearthstation",
        [151344] = "Hearthstation",
        [151348] = "Toy Weapon Set",
        [151349] = "Toy Weapon Set",
        [162973] = "Greatfather Winter's Hearthstone",
        [162642] = "Toy Armor Set",
        [162643] = "Toy Armor Set",
    },
}

ADDON.db.profession = {
    ["Jewelcrafting"] = {
        [115503] = "Blazing Diamond Pendant",
        [130251] = "JewelCraft",
        [130254] = "Chatterstone",
    },

    ["Engineering"] = {
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
        [151652] = "Wormhole Generator: Argus",
    },

    ["Archaeology"] = {
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
        [160751] = "Dance of the Dead",
        [160740] = "Croak Crock",
    },

    ["Cooking"] = {
        [88801] = "Flippable Table",
        [134020] = "Chef's Hat",
    },

    ["Fishing"] = {
        [44430] = "Titanium Seal of Dalaran",
        [45984] = "Unusual Compass",
        [85973] = "Ancient Pandaren Fishing Charm",
        [142528] = "Crate of Bobbers: Can of Worms",
        [142529] = "Crate of Bobbers: Cat Head",
        [142530] = "Crate of Bobbers: Tugboat",
        [143662] = "Crate of Bobbers: Wooden Pepe",
        [152556] = "Trawler Totem",
        [152574] = "Corbyn's Beacon",
    },

    ["Leatherworking"] = {
        [129956] = "Leather Love Seat",
        [129960] = "Leather Pet Bed",
        [129961] = "Flaming Hoop",
        [129958] = "Leather Pet Leash",
        [130102] = "Mother's Skinning Knife",
    },

    ["Enchanting"] = {
        [128536] = "Leylight Brazier",
    },

    ["Inscription"] = {
        [129211] = "Steamy Romance Novel Kit",
    },
}

ADDON.db.faction = {
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
        [166702] = "Proudmoore Music Box", -- Proudmoore Admiralty Supplies
        [166808] = "Bewitching Tea Set", -- Order of Embers Supplies
        [166744] = "Glaive Tosser",
        [163987] = "Stormwind Champion's War Banner",  --Blizzcon 2018
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
        [166703] = "Goldtusk Inn Breakfast Buffet", -- Voldunai Supplies
        [165021] = "Words of Akunda", -- Voldunai Supplies
        [166880] = "Meerah's Jukebox", -- Voldunai Supplies
        [166701] = "Warbeast Kraal Dinner Bell", -- Zandalari Empire Supplies
        [166308] = "For da Blood God!", -- Talanjis Expedition
        [166743] = "Blight Bomber",
        [163986] = "Orgrimmar Hero's War Banner", --Blizzcon 2018
    },
}

ADDON.db.source = {
    ["Treasure"] = {
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
        [130194] = "Silver Gilnean Brooch",

        -- Battle for Azeroth
        [161342] = "Gem of Acquiescence",
        [163740] = "Drust Ritual Knife",
        [163742] = "Heartsbane Grimoire",
        [163603] = "Lucille's Handkerchief",
    },

    ["Drop"] = {
        [1973] = "Orb of Deception",
        [32782] = "Time-Lost Figurine",
        [37254] = "Super Simian Sphere",

        -- Pandaria
        [86568] = "Mr. Smite's Brass Compass",
        [86571] = "Kang's Bindstone",
        [86573] = "Shard of Archstone",
        [86575] = "Chalice of Secrets",
        [86581] = "Farwater Conch",
        [86586] = "Panflute of Pandaria",
        [86588] = "Pandaren Firework Launcher",
        [86589] = "Ai-Li's Skymirror",
        [86593] = "Hozen Beach Ball",
        [90067] = "B. F. F. Necklace",
        [104262] = "Odd Polished Stone",
        [104294] = "Rime of the Time-Lost Mariner",
        [104302] = "Blackflame Daggers",
        [104309] = "Eternal Kiln",
        [104331] = "Warning Sign",
        [86590] = "Essence of the Breeze",
        [86594] = "Helpful Wikky's Whistle",
        [86565] = "Battle Horn",
        [104329] = "Ash-Covered Horn",
        [89139] = "Chain Pet Leash",
        [86578] = "Eternal Warrior's Sigil",
        [86582] = "Aqua Jewel",
        [86583] = "Salyin Battle Banner",
        [86584] = "Hardened Shell",

        -- Draenor
        [113570] = "Ancient's Bloom",
        [111476] = "Stolen Breath",
        [113631] = "Hypnosis Goggles",
        [113670] = "Mournful Moan of Murmur",
        [114227] = "Bubble Wand",
        [116122] = "Burning Legion Missive",
        [116125] = "Klikixx's Webspinner",
        [118221] = "Petrification Stone",
        [118222] = "Spirit of Bashiok",
        [118244] = "Iron Buccaneer's Hat",
        [119163] = "Soul Inhaler",
        [119178] = "Black Whirlwind",
        [119432] = "Botani Camouflage",
        [120276] = "Outrider's Bridle Chain",
        [127652] = "Felflame Campfire",
        [127659] = "Ghostly Iron Buccaneer's Hat",
        [127666] = "Vial of Red Goo",
        [128328] = "Skoller's Bag of Squirrel Treats",
        [122117] = "Cursed Feather of Ikzan",
        [108634] = "Crashin' Thrashin' Mortar Controller",
        [108633] = "Crashin' Thrashin' Cannon Controller",
        [108631] = "Crashin' Thrashin' Roller Controller",
        [113540] = "Ba'ruun's Bountiful Bloom",
        [113542] = "Whispers of Rai'Vosh",
        [113543] = "Spirit of Shinri",
        [116113] = "Breath of Talador",
        [119180] = 'Goren "Log" Roller',
        [118224] = "Ogre Brewing Kit",
        [127655] = "Sassy Imp",

        -- Legion
        [134019] = "Don Carlos' Famous Hat",
        [134023] = "Bottled Tornado",
        [140363] = "Pocket Fel Spreader",
        [130214] = "Worn Doll",
        [130171] = "Cursed Orb",
        [129113] = "Faintly Glowing Flagon of Mead",
        [134022] = "Burgy Blackheart's Handsome Hat",
        [131900] = "Majestic Elderhorn Hoof",
        [142265] = "Big Red Raygun",
        [147843] = "Sira's Extra Cloak", -- from warden paragon cache
        [147867] = "Pilfered Sweeper",
        [140314] = "Crab Shank",
        [129045] = "Whitewater Tsunami",
        [153124] = "Spire of Spite",
        [153126] = "Micro-Artillery Controller",
        [153179] = "Blue Conservatory Scroll",
        [153180] = "Yellow Conservatory Scroll",
        [153181] = "Red  Conservatory Scroll",
        [153182] = "Holy Lightsphere",
        [153183] = "Barrier Generator",
        [153193] = "Baarut the Brisk",
        [153194] = "Legion Communication Orb",
        [153253] = "S.F.E. Interceptor",
        [153293] = "Sightless Eye",
        [134831] = "Doomsayer's Robes",

        -- Battle for Azeroth
        [163713] = "Brazier Cap",
        [163744] = "Coldrage's Cooler",
        [163735] = "Foul Belly",
        [163750] = "Kovork Kostume",
        [163775] = "Molok Morion",
        [163736] = "Spectral Visage",
        [163738] = "Syndicate Mask",
        [163828] = "Toy Siege Tower",
        [163829] = "Toy War Machine",
        [163745] = "Witherbark Gong",
        [163741] = "Magic Fun Rock",
        [166702] = "Proudmoore Music Box", -- Proudmoore Admiralty Supplies
        [166808] = "Bewitching Tea Set", -- Order of Embers Supplies
        [166879] = "Rallying War Banner", -- 7th Legion Supplies & Honorbound Supplies
        [166703] = "Goldtusk Inn Breakfast Buffet", -- Voldunai Supplies
        [165021] = "Words of Akunda", -- Voldunai Supplies
        [166880] = "Meerah's Jukebox", -- Voldunai Supplies
        [166701] = "Warbeast Kraal Dinner Bell", -- Zandalari Empire Supplies
        [166308] = "For da Blood God!", -- Talanjis Expedition
        [166877] = "Azerite Firework Launcher", -- Champions of Azeroth Supplies
        [166851] = "Kojo's Master Matching Set", -- Tortollan Seekers Supplies
        [166704] = "Bowl of Glowing Pufferfish", -- Tortollan Seekers Supplies
        [166784] = "Narassin's Soul Gem", -- Darkshore
        [166785] = "Detoxified Blight Grenade", -- Darkshore
        [166787] = "Twiddle Twirler: Sentinel's Glaive", -- Darkshore
        [166788] = "Twiddle Twirler: Shredder Blade", -- Darkshore
        [166790] = "Highborne Memento", -- Darkshore
        -- Island Expeditions
        [163795] = "Oomgut Ritual Drum",
        [163924] = "Whiskerwax Candle",
        [164371] = "Yaungol Oil Stove",
        [164372] = "Jinyu Light Globe",
        [164373] = "Enchanted Soup Stone",
        [164374] = "Magic Monkey Banana",
        [164375] = "Bad Mojo Banana",
        [164377] = "Regenerating Banana Bunch",
    },

    ["Quest"] = {
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

        -- Battle for Azeroth
        [156871] = "Spitzy",
        [160509] = "Echoes of Rezan", -- WQ
        [163607] = "Lucille's Sewing Needle",
        [166544] = "Dark Ranger's Spare Cowl",
        [165791] = "Worn Cloak",
        [166678] = "Brynja's Beacon",
    },

    ["Vendor"] = {
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
        [141862] = "Mote of Light",
        [142452] = "Lingering Wyrmtongue Essence",
        [150743] = "Surviving Kalimdor",
        [150744] = "Walking Kalimdor with the Earthmother",
        [150745] = "The Azeroth Campaign",
        [150746] = "To Modernize the Provisioning of Azeroth",
        [153204] = "All-Seer's Eye", -- argus eye trader

        -- Battle for Azeroth
        [156649] = "Zandalari Effigy Amulet",
        [163704] = "Tiny Mechanical Mouse",
        [163705] = "Imaginary Gun",
        [159749] = "Haw'li's Hot & Spicy Chili",
        [164983] = "Rhan'ka's Escape Plan",
        [166662] = "Cranky Crab",
        [166663] = "Hand Anchor",
        [166461] = "Gnarlwood Waveboard",
        [166743] = "Blight Bomber",
        [166744] = "Glaive Tosser",
    },

    ["Instance"] = {
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
        [119211] = "Golden Hearthstone Card: Lord Jaraxxus",
        [143544] = "Skull of Corruption",
        [142536] = "Memory Cube",

        -- Seat of the Triumvirate
        [152982] = "Vixx's Chest of Tricks",
        [153004] = "Unstable Portal Emitter",
    },

    ["Reputation"] = {
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
        [129367] = "Vrykul Toy Boat Kit",
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
        [147708] = "Legion Invasion Simulator",
        [153039] = "Crystalline Campfire",

        -- Battle for Azeroth
        [163565] = "Vulpera Scrapper's Armor",
        [163566] = "Vulpera Battle Banner",
        [163206] = "Weary Spirit Binding",
        [163463] = "Dead Ringer",
        [163211] = "Akunda's Firesticks",
        [163210] = "Party Totem",
        [159753] = "Desert Flute",
        [163200] = "Cursed Spyglass",
        [163201] = "Gnoll Targetting Barrel",
    },

    ["Achievement"] = {
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
        [156833] = "Katy's Stampwhistle",

        -- Battle for Azeroth
        [163697] = "Laser Pointer",
        [166247] = "Citizens Brigade Whistle",
    },

    ["PvP"] = {
        -- Toys from prestige PvP system
        [134026] = "Honorable Pennant",
        [134031] = "Prestigious Pennant",
        [134032] = "Elite Pennant",
        [134034] = "Esteemed Pennant",
        [164310] = "Glorious Pennant",
    },

    ["Garrison"] = {
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

    ["Order Hall"] = {
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
        [139587] = "Suspicious Crate",
        [140160] = "Stormforged Vrykul Horn",
    },

    ["Pick Pocket"] = {
        [36862] = "Worn Troll Dice",
        [36863] = "Decahedral Dwarven Dice",
        [63269] = "Loaded Gnomish Dice",
        [120857] = "Barrel of Bandanas",
        [151877] = "Barrel of Eyepatches",
    },

    ["Black Market"] = {
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

    ["Promotion"] = {
        -- Event
        [33079] = "Murloc Costume",
        [142542] = "Tome of Town Portal",
        [143543] = "Twelve-String Guitar",
        [158149] = "Overtuned Corgi Goggles",
        [163986] = "Orgrimmar Hero's War Banner", --Blizzcon 2018
        [163987] = "Stormwind Champion's War Banner",  --Blizzcon 2018

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
}

ADDON.db.expansion = {

    -- Classic
    [EXPANSION_NAME0] = {
        ["minID"] = 0,
        ["maxID"] = 23700,
    },

    -- The Burning Crusade
    [EXPANSION_NAME1] = {
        ["minID"] = 23767,
        ["maxID"] = 36861,
        [37710] = "Crashin' Thrashin' Racer Controller",
        [38301] = "D.I.S.C.O.",
    },

    -- Wrath of the Lich King
    [EXPANSION_NAME2] = {
        ["minID"] = 36862,
        ["maxID"] = 54653,
    },

    -- Cataclysm
    [EXPANSION_NAME3] = {
        ["minID"] = 54654,
        ["maxID"] = 79999,
        [40727] = "Gnomish Gravity Well",
        [46709] = "MiniZep Controller",
        [53057] = "Faded Wizard Hat",
    },

    -- Mists of Pandaria
    [EXPANSION_NAME4] = {
        ["minID"] = 80000,
        ["maxID"] = 107999,
    },

    -- Warlords of Draenor
    [EXPANSION_NAME5] = {
        ["minID"] = 108000,
        ["maxID"] = 128999,
        [129926] = "Mark of the Ashtongue",
        [129929] = "Ever-Shifting Mirror",
        [129938] = "Will of Northrend",
        [129952] = "Hourglass of Eternity",
        [129965] = "Grizzlesnout's Fang",
        [133511] = "Gurboggle's Gleaming Bauble",
        [133542] = "Tosselwrench's Mega-Accurate Simulation Viewfinder",
    },

    -- Legion
    [EXPANSION_NAME6] = {
        ["minID"] = 129000,
        ["maxID"] = 156640,
        [156833] = "Katy's Stampwhistle",P
    },

    -- Battle for Azeroth
    [EXPANSION_NAME7] = {
        ["minID"] = 156649,
        ["maxID"] = 999999,
    },
}