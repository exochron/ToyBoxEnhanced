local ADDON_NAME, ADDON = ...

ADDON.db = {}

-- itemIds of all initially scanned toys
ADDON.db.ingameList = {}

ADDON.db.worldEvent = {

    ["Timewalking"] = {
        [129926] = true, -- Mark of the Ashtongue
        [129929] = true, -- Ever-Shifting Mirror
        [129938] = true, -- Will of Northrend
        [129952] = true, -- Hourglass of Eternity
        [129965] = true, -- Grizzlesnout's Fang
        [133511] = true, -- Gurboggle's Gleaming Bauble
        [133542] = true, -- Tosselwrench's Mega-Accurate Simulation Viewfinder
        [144072] = true, -- Adopted Puppy Crate
        [144393] = true, -- Portable Yak Wash
        [151016] = true, -- Fractured Necrolyte Skull
        [151184] = true, -- Verdant Throwing Sphere
        [168012] = true, -- Apexis Focusing Shard
        [168014] = true, -- Banner of the Burning Blade
        [170380] = true, -- Jar of Sunwarmed Sand
    },

    ["Darkmoon Faire"] = {
        [75042] = true, -- Flimsy Yellow Balloon
        [90899] = true, -- Darkmoon Whistle
        [101571] = true, -- Moonfang Shroud
        [105898] = true, -- Moonfang's Paw
        [116067] = true, -- Ring of Broken Promises
        [116115] = true, -- Blazing Wings
        [116139] = true, -- Haunting Memento
        [122119] = true, -- Everlasting Darkmoon Firework
        [122120] = true, -- Gaze of the Darkmoon
        [122121] = true, -- Darkmoon Gazer
        [122122] = true, -- Darkmoon Tonk Controller
        [122123] = true, -- Darkmoon Ring-Flinger
        [122126] = true, -- Attraction Sign
        [122129] = true, -- Fire-Eater's Vial
        [126931] = true, -- Seafarer's Slidewhistle
        [97994] = true, -- Darkmoon Seesaw
        [138202] = true, -- Sparklepony XL
        [151265] = true, -- Blight Boar Microphone
        [162539] = true, -- Hot Buttered Popcorn
    },

    ["Lunar Festival"] = {
        [21540] = true, -- Elune's Lantern
        [89999] = true, -- Everlasting Alliance Firework
        [90000] = true, -- Everlasting Horde Firework
        [143827] = true, -- Dragon Head Costume
        [143828] = true, -- Dragon Body Costume
        [143829] = true, -- Dragon Tail Costume
        [165671] = true, -- Blue Dragon Head Costume
        [165672] = true, -- Blue Dragon Body Costume
        [165673] = true, -- Blue Dragon Tail Costume
        [165674] = true, -- Green Dragon Head Costume
        [165675] = true, -- Green Dragon Body Costume
        [165676] = true, -- Green Dragon Tail Costume
        [165669] = true, -- Lunar Elder's Hearthstone
    },

    ["Love is in the Air"] = {
        [34480] = true, -- Romantic Picnic Basket
        [50471] = true, -- The Heartbreaker
        [116651] = true, -- True Love Prism
        [142341] = true, -- Love Boat
        [144339] = true, -- Sturdy Love Fool
        [165670] = true, -- Peddlefeet's Lovely Hearthstone
    },

    ["Noblegarden"] = {
        [165802] = true, -- Noble Gardener's Hearthstone
    },

    ["Children's Week"] = {
        [69895] = true, -- Green Balloon
        [69896] = true, -- Yellow Balloon
    },

    ["Midsummer Fire Festival"] = {
        [34686] = true, -- Brazier of Dancing Flames
        [116435] = true, -- Cozy Bonfire
        [116440] = true, -- Burning Defender's Medallion
        [141649] = true, -- Set of Matches
        [166746] = true, -- Fire Eater's Hearthstone
    },

    ["Brewfest"] = {
        [33927] = true, -- Brewfest Pony Keg
        [71137] = true, -- Brewfest Keg Pony
        [90427] = true, -- Pandaren Brewpack
        [116757] = true, -- Steamworks Sausage Grill
        [116758] = true, -- Brewfest Banner
        [138900] = true, -- Gravil Goldbraid's Famous Sausage Hat
        [166747] = true, -- Brewfest Reveler's Hearthstone
        [169865] = true, -- Brewfest Chowdown Trophy
    },

    ["Hallow's End"] = {
        [70722] = true, -- Little Wickerman
        [128807] = true, -- Coin of Many Faces
        [128794] = true, -- Sack of Spectral Spiders
        [151270] = true, -- Horse Tail Costume
        [151271] = true, -- Horse Head Costume
        [163045] = true, -- Headless Horseman's Hearthstone
    },

    ["Day of the Dead"] = {
        [116856] = true, -- "Blooming Rose" Contender's Costume
        [116888] = true, -- "Night Demon" Contender's Costume
        [116889] = true, -- "Purple Phantom" Contender's Costume
        [116890] = true, -- "Santo's Sun" Contender's Costume
        [116891] = true, -- "Snowy Owl" Contender's Costume
    },

    ["Pilgrim's Bounty"] = {
        [116400] = true, -- Silver-Plated Turkey Shooter
    },

    ["Pirates' Day"] = {
        [138415] = true, -- Slightly-Chewed Insult Book
        [150547] = true, -- Jolly Roger
    },

    ["Feast of Winter Veil"] = {
        [17712] = true, -- Winter Veil Disguise Kit
        [37710] = true, -- Crashin' Thrashin' Racer Controller
        [46709] = true, -- MiniZep Controller
        [90883] = true, -- The Pigskin
        [90888] = true, -- Foot Ball
        [104318] = true, -- Crashin' Thrashin' Flyer Controller
        [116456] = true, -- Scroll of Storytelling
        [116689] = true, -- Pineapple Lounge Cushion
        [116690] = true, -- Safari Lounge Cushion
        [116691] = true, -- Zhevra Lounge Cushion
        [116692] = true, -- Fuzzy Green Lounge Cushion
        [116763] = true, -- Crashin' Thrashin' Shredder Controller
        [128776] = true, -- Red Wooden Sled
        [108632] = true, -- Crashin' Thrashin' Flamer Controller
        [108635] = true, -- Crashin' Thrashin' Killdozer Controller
        [139337] = true, -- Disposable Winter Veil Suits
        [128636] = true, -- Endothermic Blaster
        [151343] = true, -- Hearthstation
        [151344] = true, -- Hearthstation
        [151348] = true, -- Toy Weapon Set
        [151349] = true, -- Toy Weapon Set
        [162973] = true, -- Greatfather Winter's Hearthstone
        [162642] = true, -- Toy Armor Set
        [162643] = true, -- Toy Armor Set
        [172219] = true, -- Wild Holly
        [172222] = true, -- Crashin' Thrashin' Juggernaught
        [172223] = true, -- Crashin' Thrashin' Battleship
    },
}

ADDON.db.profession = {
    ["Jewelcrafting"] = {
        [115503] = true, -- Blazing Diamond Pendant
        [130251] = true, -- JewelCraft
        [130254] = true, -- Chatterstone
    },

    ["Engineering"] = {
        [17716] = true, -- Snowmaster 9000
        [18660] = true, -- World Enlarger
        [23767] = true, -- Crashin' Thrashin' Robot
        [40895] = true, -- Gnomish X-Ray Specs
        [108745] = true, -- Personal Hologram
        [109183] = true, -- World Shrinker
        [111821] = true, -- Blingtron 5000
        [132518] = true, -- Blingtron's Circuit Design Tutorial
        [40768] = true, -- MOLL-E
        [87214] = true, -- Blingtron 4000
        [109167] = true, -- Findle's Loot-A-Rang
        [87215] = true, -- Wormhole Generator: Pandaria
        [40727] = true, -- Gnomish Gravity Well
        [60854] = true, -- Loot-A-Rang
        [112059] = true, -- Wormhole Centrifuge
        [48933] = true, -- Wormhole Generator: Northrend
        [30544] = true, -- Ultrasafe Transporter: Toshley's Station
        [18986] = true, -- Ultrasafe Transporter: Gadgetzan
        [18984] = true, -- Dimensional Ripper - Everlook
        [30542] = true, -- Dimensional Ripper - Area 52
        [151652] = true, -- Wormhole Generator: Argus
        [168667] = true, -- Blingtron 7000
        [168807] = true, -- Wormhole Generator: Kul Tiras
        [168808] = true, -- Wormhole Generator: Zandalar
        [172924] = true, -- Wormhole Generator: Shadowlands
    },

    ["Archaeology"] = {
        [64358] = true, -- Highborne Soul Mirror
        [64361] = true, -- Druid and Priest Statue Set
        [64373] = true, -- Chalice of the Mountain Kings
        [64383] = true, -- Kaldorei Wind Chimes
        [64456] = true, -- Arrival of the Naaru
        [64481] = true, -- Blessing of the Old God
        [64482] = true, -- Puzzle Box of Yogg-Saron
        [64646] = true, -- Bones of Transformation
        [64651] = true, -- Wisp Amulet
        [64881] = true, -- Pendant of the Scarab Storm
        [69775] = true, -- Vrykul Drinking Horn
        [69776] = true, -- Ancient Amber
        [69777] = true, -- Haunted War Drum
        [131724] = true, -- Crystalline Eye of Undravius
        [64488] = true, -- The Innkeeper's Daughter
        [89614] = true, -- Anatomical Dummy
        [160751] = true, -- Dance of the Dead
        [160740] = true, -- Croak Crock
    },

    ["Cooking"] = {
        [88801] = true, -- Flippable Table
        [134020] = true, -- Chef's Hat
    },

    ["Fishing"] = {
        [44430] = true, -- Titanium Seal of Dalaran
        [45984] = true, -- Unusual Compass
        [85973] = true, -- Ancient Pandaren Fishing Charm
        [142528] = true, -- Crate of Bobbers: Can of Worms
        [142529] = true, -- Crate of Bobbers: Cat Head
        [142530] = true, -- Crate of Bobbers: Tugboat
        [143662] = true, -- Crate of Bobbers: Wooden Pepe
        [152556] = true, -- Trawler Totem
        [152574] = true, -- Corbyn's Beacon
    },

    ["Leatherworking"] = {
        [129956] = true, -- Leather Love Seat
        [129960] = true, -- Leather Pet Bed
        [129961] = true, -- Flaming Hoop
        [129958] = true, -- Leather Pet Leash
        [130102] = true, -- Mother's Skinning Knife
    },

    ["Enchanting"] = {
        [128536] = true, -- Leylight Brazier
    },

    ["Inscription"] = {
        [129211] = true, -- Steamy Romance Novel Kit
    },
}

ADDON.db.faction = {
    alliance = {
        [30690] = true, -- Power Converter
        [45011] = true, -- Stormwind Banner
        [45018] = true, -- Ironforge Banner
        [45019] = true, -- Gnomeregan Banner
        [45020] = true, -- Exodar Banner
        [45021] = true, -- Darnassus Banner
        [54651] = true, -- Gnomeregan Pride
        [63141] = true, -- Tol Barad Searchlight
        [89999] = true, -- Everlasting Alliance Firework
        [95567] = true, -- Kirin Tor Beacon
        [95589] = true, -- Glorious Standard of the Kirin Tor Offensive
        [116396] = true, -- LeBlanc's Recorder
        [119144] = true, -- Touch of the Naaru
        [119182] = true, -- Soul Evacuation Crystal
        [119217] = true, -- Alliance Flag of Victory
        [128462] = true, -- Karabor Councilor's Attire
        [115472] = true, -- Permanent Time Bubble
        [119421] = true, -- Sha'tari Defender's Medallion
        [150743] = true, -- Surviving Kalimdor
        [150746] = true, -- To Modernize the Provisioning of Azeroth
        [151343] = true, -- Hearthstation
        [151349] = true, -- Toy Weapon Set
        [162643] = true, -- Toy Armor Set
        [163607] = true, -- Lucille's Sewing Needle
        [163828] = true, -- Toy Siege Tower
        [166702] = true, -- Proudmoore Music Box -- Proudmoore Admiralty Supplies
        [166808] = true, -- Bewitching Tea Set -- Order of Embers Supplies
        [166744] = true, -- Glaive Tosser
        [163987] = true, -- Stormwind Champion's War Banner  --Blizzcon 2018
        [166777] = true, -- Lion's Pride Firework
        [169275] = true, -- Alliance War Banner
        [169278] = true, -- Alliance War Standard
        [169297] = true, -- Stormpike Insignia
    },

    horde = {
        [53057] = true, -- Faded Wizard Hat
        [54653] = true, -- Darkspear Pride
        [45013] = true, -- Thunder Bluff Banner
        [45014] = true, -- Orgrimmar Banner
        [45015] = true, -- Sen'jin Banner
        [45016] = true, -- Undercity Banner
        [45017] = true, -- Silvermoon City Banner
        [64997] = true, -- Tol Barad Searchlight
        [89205] = true, -- Mini Mana Bomb
        [90000] = true, -- Everlasting Horde Firework
        [95568] = true, -- Sunreaver Beacon
        [95590] = true, -- Glorious Standard of the Sunreaver Onslaught
        [115468] = true, -- Permanent Frost Essence
        [115503] = true, -- Blazing Diamond Pendant
        [115505] = true, -- LeBlanc's Recorder
        [119145] = true, -- Firefury Totem
        [119160] = true, -- Tickle Totem
        [119218] = true, -- Horde Flag of Victory
        [128471] = true, -- Frostwolf Grunt's Battlegear
        [150744] = true, -- Walking Kalimdor with the Earthmother
        [150745] = true, -- The Azeroth Campaign
        [151344] = true, -- Hearthstation
        [151348] = true, -- Toy Weapon Set
        [162642] = true, -- Toy Armor Set
        [163829] = true, -- Toy War Machine
        [165791] = true, -- Worn Cloak
        [166544] = true, -- Dark Ranger's Spare Cowl
        [166678] = true, -- Brynja's Beacon
        [166703] = true, -- Goldtusk Inn Breakfast Buffet -- Voldunai Supplies
        [165021] = true, -- Words of Akunda -- Voldunai Supplies
        [166880] = true, -- Meerah's Jukebox -- Voldunai Supplies
        [166701] = true, -- Warbeast Kraal Dinner Bell -- Zandalari Empire Supplies
        [166308] = true, -- For da Blood God! -- Talanjis Expedition
        [166743] = true, -- Blight Bomber
        [163986] = true, -- Orgrimmar Hero's War Banner --Blizzcon 2018
        [166778] = true, -- Horde's Might Firework
        [169276] = true, -- Horde War Banner
        [169277] = true, -- Horde War Standard
        [169298] = true, -- Frostwolf Insignia
    },
}

ADDON.db.source = {
    ["Treasure"] = {
        -- Draenor
        [108735] = true, -- Arena Master's War Horn
        [108739] = true, -- Pretty Draenor Pearl
        [108743] = true, -- Deceptia's Smoldering Boots
        [109739] = true, -- Star Chart
        [113375] = true, -- Vindicator's Armor Polish Kit
        [117569] = true, -- Giant Deathweb Egg
        [117550] = true, -- Angry Beehive
        [118716] = true, -- Goren Garb
        [127859] = true, -- Dazzling Rod
        [127394] = true, -- Podling Camouflage
        [127766] = true, -- The Perfect Blossom
        [127668] = true, -- Jewel of Hellfire
        [127670] = true, -- Accursed Tome of the Sargerei
        [127709] = true, -- Throbbing Blood Orb
        [116120] = true, -- Tasty Talador Lunch
        [128223] = true, -- Bottomless Stygana Mushroom Brew

        -- Legion
        [130147] = true, -- Thistleleaf Branch
        [141296] = true, -- Ancient Mana Basin
        [140786] = true, -- Ley Spider Eggs
        [141299] = true, -- Kaldorei Light Globe
        [141301] = true, -- Unstable Powder Box
        [134024] = true, -- Cursed Swabby Helmet
        [141306] = true, -- Wisp in a Bottle
        [122681] = true, -- Sternfathom's Pet Journal
        [102467] = true, -- Censer of Eternal Agony
        [130169] = true, -- Tournament Favor
        [131811] = true, -- Rocfeather Skyhorn Kite
        [129165] = true, -- Barnacle-Encrusted Gem
        [127669] = true, -- Skull of the Mad Chief
        [129055] = true, -- Shoe Shine Kit
        [141297] = true, -- Arcano-Shower
        [141298] = true, -- Displacer Meditation Stone
        [140780] = true, -- Fal'dorei Egg
        [143534] = true, -- Wand of Simulated Life
        [130194] = true, -- Silver Gilnean Brooch

        -- Battle for Azeroth
        [161342] = true, -- Gem of Acquiescence
        [163740] = true, -- Drust Ritual Knife
        [163742] = true, -- Heartsbane Grimoire
        [163603] = true, -- Lucille's Handkerchief
        [168824] = true, -- Ocean Simulator
        [174920] = true, -- Coifcurl's Close Shave Kit
        [174921] = true, -- Void-Touched Skull
        [174924] = true, -- Void-Touched Souvenir Totem
        [174928] = true, -- Rotten Apple

        -- Shadowlands
        [173984] = true, -- Scroll of Aeons
        [179393] = true, -- Mirror of Envious Dreams
        [180993] = true, -- Bat Visage Bobber
        [181825] = true, -- Phial of Ravenous Slime
        [182694] = true, -- Stylish Black Parasol
        [182696] = true, -- The Countess's Parasol
        [182729] = true, -- Hearty Dragon Plume
        [182780] = true, -- Muckpool Cookpot
        [183986] = true, -- Bondable Sinstone
        [183988] = true, -- Bondable Val'kyr Diadem
        [184075] = true, -- Stonewrought Sentry
        [184318] = true, -- Battlecry of Krexus
        [184447] = true, -- Kevin's Party Supplies
        [182732] = true, -- The Necronom-i-nom

    },

    ["Drop"] = {
        [1973] = true, -- Orb of Deception
        [32782] = true, -- Time-Lost Figurine
        [37254] = true, -- Super Simian Sphere

        -- Pandaria
        [86568] = true, -- Mr. Smite's Brass Compass
        [86571] = true, -- Kang's Bindstone
        [86573] = true, -- Shard of Archstone
        [86575] = true, -- Chalice of Secrets
        [86581] = true, -- Farwater Conch
        [86586] = true, -- Panflute of Pandaria
        [86588] = true, -- Pandaren Firework Launcher
        [86589] = true, -- Ai-Li's Skymirror
        [86593] = true, -- Hozen Beach Ball
        [90067] = true, -- B. F. F. Necklace
        [104262] = true, -- Odd Polished Stone
        [104294] = true, -- Rime of the Time-Lost Mariner
        [104302] = true, -- Blackflame Daggers
        [104309] = true, -- Eternal Kiln
        [104331] = true, -- Warning Sign
        [86590] = true, -- Essence of the Breeze
        [86594] = true, -- Helpful Wikky's Whistle
        [86565] = true, -- Battle Horn
        [104329] = true, -- Ash-Covered Horn
        [89139] = true, -- Chain Pet Leash
        [86578] = true, -- Eternal Warrior's Sigil
        [86582] = true, -- Aqua Jewel
        [86583] = true, -- Salyin Battle Banner
        [86584] = true, -- Hardened Shell

        -- Draenor
        [113570] = true, -- Ancient's Bloom
        [111476] = true, -- Stolen Breath
        [113631] = true, -- Hypnosis Goggles
        [113670] = true, -- Mournful Moan of Murmur
        [114227] = true, -- Bubble Wand
        [116122] = true, -- Burning Legion Missive
        [116125] = true, -- Klikixx's Webspinner
        [118221] = true, -- Petrification Stone
        [118222] = true, -- Spirit of Bashiok
        [118244] = true, -- Iron Buccaneer's Hat
        [119163] = true, -- Soul Inhaler
        [119178] = true, -- Black Whirlwind
        [119432] = true, -- Botani Camouflage
        [120276] = true, -- Outrider's Bridle Chain
        [127652] = true, -- Felflame Campfire
        [127659] = true, -- Ghostly Iron Buccaneer's Hat
        [127666] = true, -- Vial of Red Goo
        [128328] = true, -- Skoller's Bag of Squirrel Treats
        [122117] = true, -- Cursed Feather of Ikzan
        [108634] = true, -- Crashin' Thrashin' Mortar Controller
        [108633] = true, -- Crashin' Thrashin' Cannon Controller
        [108631] = true, -- Crashin' Thrashin' Roller Controller
        [113540] = true, -- Ba'ruun's Bountiful Bloom
        [113542] = true, -- Whispers of Rai'Vosh
        [113543] = true, -- Spirit of Shinri
        [116113] = true, -- Breath of Talador
        [119180] = true, -- Goren "Log" Roller
        [118224] = true, -- Ogre Brewing Kit
        [127655] = true, -- Sassy Imp

        -- Legion
        [134019] = true, -- Don Carlos' Famous Hat
        [134023] = true, -- Bottled Tornado
        [140363] = true, -- Pocket Fel Spreader
        [130214] = true, -- Worn Doll
        [130171] = true, -- Cursed Orb
        [129113] = true, -- Faintly Glowing Flagon of Mead
        [134022] = true, -- Burgy Blackheart's Handsome Hat
        [131900] = true, -- Majestic Elderhorn Hoof
        [142265] = true, -- Big Red Raygun
        [147843] = true, -- Sira's Extra Cloak -- from warden paragon cache
        [147867] = true, -- Pilfered Sweeper
        [140314] = true, -- Crab Shank
        [129045] = true, -- Whitewater Tsunami
        [153124] = true, -- Spire of Spite
        [153126] = true, -- Micro-Artillery Controller
        [153179] = true, -- Blue Conservatory Scroll
        [153180] = true, -- Yellow Conservatory Scroll
        [153181] = true, -- Red  Conservatory Scroll
        [153182] = true, -- Holy Lightsphere
        [153183] = true, -- Barrier Generator
        [153193] = true, -- Baarut the Brisk
        [153194] = true, -- Legion Communication Orb
        [153253] = true, -- S.F.E. Interceptor
        [153293] = true, -- Sightless Eye
        [134831] = true, -- Doomsayer's Robes

        -- Battle for Azeroth
        [163713] = true, -- Brazier Cap
        [163744] = true, -- Coldrage's Cooler
        [163735] = true, -- Foul Belly
        [163750] = true, -- Kovork Kostume
        [163775] = true, -- Molok Morion
        [163736] = true, -- Spectral Visage
        [163738] = true, -- Syndicate Mask
        [163828] = true, -- Toy Siege Tower
        [163829] = true, -- Toy War Machine
        [163745] = true, -- Witherbark Gong
        [163741] = true, -- Magic Fun Rock
        [166702] = true, -- Proudmoore Music Box -- Proudmoore Admiralty Supplies
        [166808] = true, -- Bewitching Tea Set -- Order of Embers Supplies
        [166879] = true, -- Rallying War Banner -- 7th Legion Supplies & Honorbound Supplies
        [166703] = true, -- Goldtusk Inn Breakfast Buffet -- Voldunai Supplies
        [165021] = true, -- Words of Akunda -- Voldunai Supplies
        [166880] = true, -- Meerah's Jukebox -- Voldunai Supplies
        [166701] = true, -- Warbeast Kraal Dinner Bell -- Zandalari Empire Supplies
        [166308] = true, -- For da Blood God! -- Talanjis Expedition
        [166877] = true, -- Azerite Firework Launcher -- Champions of Azeroth Supplies
        [166851] = true, -- Kojo's Master Matching Set -- Tortollan Seekers Supplies
        [166704] = true, -- Bowl of Glowing Pufferfish -- Tortollan Seekers Supplies
        [166784] = true, -- Narassin's Soul Gem -- Darkshore
        [166785] = true, -- Detoxified Blight Grenade -- Darkshore
        [166787] = true, -- Twiddle Twirler: Sentinel's Glaive -- Darkshore
        [166788] = true, -- Twiddle Twirler: Shredder Blade -- Darkshore
        [166790] = true, -- Highborne Memento -- Darkshore
        [167931] = true, -- Mechagonian Sawblades
        [169347] = true, -- Judgment of Mechagon
        [170187] = true, -- Shadescale
        [170196] = true, -- Shirakess Warning Sign
        [170198] = true, -- Eternal Palace Dining Set
        [170199] = true, -- Zanj'ir Weapon Rack
        [170203] = true, -- Flopping Fish -- Ankoan/Unshackled Supplies
        [170469] = true, -- Memento of the Deeps -- Ankoan/Unshackled Supplies
        [170476] = true, -- Underlight Sealamp
        -- Island Expeditions
        [163795] = true, -- Oomgut Ritual Drum
        [163924] = true, -- Whiskerwax Candle
        [164373] = true, -- Enchanted Soup Stone
        [164374] = true, -- Magic Monkey Banana
        [164375] = true, -- Bad Mojo Banana

        [169303] = true, -- Hell-Bent Bracers
        [174873] = true, -- Trans-mogu-rifier
        [174874] = true, -- Budget K'thir Disguise
        [174926] = true, -- Overly Sensitive Void Spectacles
        [175140] = true, -- All-Seeing Eyes

        -- Shadowlands
        [174445] = true, -- Glimmerfly Cocoon
        [180873] = true, -- Smolderheart
        [181794] = true, -- Orophea's Lyre
        [184292] = true, -- Ancient Elethium Coin
        [184312] = true, -- Borr-Geth's Fiery Brimstone
        [184396] = true, -- Malfunctioning Goliath Gauntlet -- Ascended Supplies
        [184435] = true, -- Mark of Purity -- Ascended Supplies
        [184476] = true, -- Regenerating Slime Vial
        [184495] = true, -- Infested Arachnid Casing -- Supplies of the Undying Army
    },

    ["Quest"] = {
        [30690] = true, -- Power Converter
        [53057] = true, -- Faded Wizard Hat
        [123851] = true, -- Photo B.O.M.B. -- Blingtron-5000

        -- Molten Front
        [71259] = true, -- Leyara's Locket

        -- Cataclysm
        [54651] = true, -- Gnomeregan Pride
        [54653] = true, -- Darkspear Pride

        -- Pandaria
        [80822] = true, -- The Golden Banana
        [82467] = true, -- Ruthers' Harness
        [88589] = true, -- Cremating Torch
        [88417] = true, -- Gokk'lok's Shell
        [88385] = true, -- Hozen Idol
        [88579] = true, -- Jin Warmkeg's Brew
        [88580] = true, -- Ken-Ken's Mask
        [88531] = true, -- Lao Chin's Last Mug
        [88370] = true, -- Puntable Marmot
        [88377] = true, -- Turnip Paint "Gun"
        [88387] = true, -- Shushen's Spittoon
        [88381] = true, -- Silversage Incense
        [88584] = true, -- Totem of Harmony
        [88375] = true, -- Turnip Punching Bag
        [95567] = true, -- Kirin Tor Beacon -- Alliance
        [95568] = true, -- Sunreaver Beacon -- Horde

        -- Draenor
        [119001] = true, -- Mystery Keg
        [119134] = true, -- Sargerei Disguise
        [119144] = true, -- Touch of the Naaru
        [119145] = true, -- Firefury Totem
        [119093] = true, -- Aviana's Feather
        [115506] = true, -- Treessassin's Guise
        [118935] = true, -- Ever-Blooming Frond

        -- Legion
        [129093] = true, -- Ravenbear Disguise
        [138873] = true, -- Mystical Frosh Hat
        [134021] = true, -- X-52 Rocket Helmet
        [141879] = true, -- Berglrgl Perrgl Girggrlf
        [131933] = true, -- Critter Hand Cannon
        [133997] = true, -- Black Ice
        [138876] = true, -- Runas' Crystal Grinder
        [130209] = true, -- Never Ending Toy Chest
        [138878] = true, -- Copy of Daglop's Contract
        [133998] = true, -- Rainbow Generator
        [142494] = true, -- Purple Blossom
        [142495] = true, -- Fake Teeth
        [142496] = true, -- Dirty Spoon
        [142497] = true, -- Tiny Pack
        [147838] = true, -- Akazamzarak's Spare Hat -- mage class quest
        [143727] = true, -- Champion's Salute -- class hall quest

        -- Battle for Azeroth
        [156871] = true, -- Spitzy
        [160509] = true, -- Echoes of Rezan -- WQ
        [163607] = true, -- Lucille's Sewing Needle
        [166544] = true, -- Dark Ranger's Spare Cowl
        [165791] = true, -- Worn Cloak
        [166678] = true, -- Brynja's Beacon
        [168123] = true, -- Twitching Eyeball
        [169796] = true, -- Azeroth Mini Collection: Mechagon
        [169768] = true, -- Heart of a Champion
        [170154] = true, -- Book of the Unshackled
        [170155] = true, -- Carved Ankoan Charm
        [173951] = true, -- N'lyeth, Sliver of N'Zoth
        [175063] = true, -- Aqir Egg Cluster

        -- Shadowlands
        [177951] = true, -- Glimmerflies on Strings
        [180947] = true, -- Tithe Collector's Vessel
        [183847] = true, -- Acolyte's Guise
        [183856] = true, -- Mystical Orb of Meditation

    },

    ["Vendor"] = {
        [43499] = true, -- Iron Boot Flask
        [68806] = true, -- Kalytha's Haunted Locket
        [88802] = true, -- Foxicopter Controller
        [91904] = true, -- Stackable Stag

        -- Toy vendors
        [44606] = true, -- Toy Train Set
        [45057] = true, -- Wind-Up Train Wrecker
        [54343] = true, -- Blue Crashin' Thrashin' Racer Controller
        [54437] = true, -- Tiny Green Ragdoll
        [54438] = true, -- Tiny Blue Ragdoll
        [104323] = true, -- The Pigskin
        [104324] = true, -- Foot Ball

        -- Argent Tournament
        [45011] = true, -- Stormwind Banner
        [45013] = true, -- Thunder Bluff Banner
        [45014] = true, -- Orgrimmar Banner
        [45015] = true, -- Sen'jin Banner
        [45016] = true, -- Undercity Banner
        [45017] = true, -- Silvermoon City Banner
        [45018] = true, -- Ironforge Banner
        [45019] = true, -- Gnomeregan Banner
        [45020] = true, -- Exodar Banner
        [45021] = true, -- Darnassus Banner
        [46843] = true, -- Argent Crusader's Banner

        -- Molten Front
        [70159] = true, -- Mylune's Call
        [70161] = true, -- Mushroom Chair

        -- Battlefield Barrens
        [97919] = true, -- Whole-Body Shrinka'
        [97921] = true, -- Bom'bay's Color-Seein' Sauce -- no longer available
        [97942] = true, -- Sen'jin Spirit Drum
        [98552] = true, -- Xan'tish's Flute

        -- Garrison
        [113096] = true, -- Bloodmane Charm
        [119210] = true, -- Hearthstone Board
        [119212] = true, -- Winning Hand

        [127695] = true, -- Spirit Wand
        [127696] = true, -- Magic Pet Mirror
        [127707] = true, -- Indestructible Bone
        [127864] = true, -- Personal Spotlight
        [44820] = true, -- Red Ribbon Pet Leash
        [37460] = true, -- Rope Pet Leash
        -- Ashran
        [115501] = true, -- Kowalski's Music Box
        [115505] = true, -- LeBlanc's Recorder
        [116396] = true, -- LeBlanc's Recorder

        -- Legion
        [137294] = true, -- Dalaran Initiates' Pin
        [136846] = true, -- Familiar Stone
        [140336] = true, -- Brulfist Idol
        [134007] = true, -- Eternal Black Diamond Ring
        [129057] = true, -- Dalaran Disc
        [140231] = true, -- Narcissa's Mirror
        [140309] = true, -- Prismatic Bauble
        [137663] = true, -- Soft Foam Sword
        [130151] = true, -- The "Devilsaur" Lunchbox
        [134004] = true, -- Noble's Eternal Elementium Signet
        [141862] = true, -- Mote of Light
        [142452] = true, -- Lingering Wyrmtongue Essence
        [150743] = true, -- Surviving Kalimdor
        [150744] = true, -- Walking Kalimdor with the Earthmother
        [150745] = true, -- The Azeroth Campaign
        [150746] = true, -- To Modernize the Provisioning of Azeroth
        [153204] = true, -- All-Seer's Eye -- argus eye trader

        -- Battle for Azeroth
        [156649] = true, -- Zandalari Effigy Amulet
        [163704] = true, -- Tiny Mechanical Mouse
        [163705] = true, -- Imaginary Gun
        [159749] = true, -- Haw'li's Hot & Spicy Chili
        [164983] = true, -- Rhan'ka's Escape Plan
        [166662] = true, -- Cranky Crab
        [166663] = true, -- Hand Anchor
        [166461] = true, -- Gnarlwood Waveboard
        [166743] = true, -- Blight Bomber
        [166744] = true, -- Glaive Tosser
        [168907] = true, -- Holographic Digitalization Hearthstone
        [169275] = true, -- Alliance War Banner
        [169276] = true, -- Horde War Banner
        [169277] = true, -- Horde War Standard
        [169278] = true, -- Alliance War Standard
        [170204] = true, -- Symbol of Gral
        [170380] = true, -- Jar of Sunwarmed Sand

        -- Shadowlands
        [180290] = true, -- Night Fae Hearthstone
        [183716] = true, -- Venthyr Sinstone
        [182773] = true, -- Necrolord Hearthstone
        [183876] = true, -- Quill of Correspondence
        [183989] = true, -- Dredger Barrow Racer
        [184353] = true, -- Kyrian Hearthstone
    },

    ["Instance"] = {
        [13379] = true, -- Piccolo of the Flaming Fire - Stratholme
        [35275] = true, -- Orb of the Sin'dorei - Magisters' Terrace
        [52201] = true, -- Muradin's Favor - Icecrown Citadel
        [52253] = true, -- Sylvanas' Music Box - Icecrown Citadel
        [88566] = true, -- Krastinov's Bag of Horrors - Scholomance
        [98132] = true, -- Shado-Pan Geyser Gun - Throne of Thunder
        [98136] = true, -- Gastropod Shell - Throne of Thunder
        [119211] = true, -- Golden Hearthstone Card: Lord Jaraxxus - Nighthold, Guldan
        [122304] = true, -- Fandral's Seed Pouch - Firelands
        [141331] = true, -- Vial of Green Goo - Gnomeregan, Endgineer Omegaplugg
        [143544] = true, -- Skull of Corruption - Nighthold
        [142536] = true, -- Memory Cube - Nighthold
        [152982] = true, -- Vixx's Chest of Tricks - Seat of the Triumvirate
        [153004] = true, -- Unstable Portal Emitter - Seat of the Triumvirate
    },

    ["Reputation"] = {
        [44719] = true, -- Frenzyheart Brew
        [63141] = true, -- Tol Barad Searchlight
        [64997] = true, -- Tol Barad Searchlight
        [66888] = true, -- Stave of Fur and Claw

        -- Pandaria
        [85500] = true, -- Anglers Fishing Raft
        [86596] = true, -- Nat's Fishing Chair
        [89222] = true, -- Cloud Ring
        [89869] = true, -- Pandaren Scarecrow
        [90175] = true, -- Gin-Ji Knife Set
        [95589] = true, -- Glorious Standard of the Kirin Tor Offensive
        [95590] = true, -- Glorious Standard of the Sunreaver Onslaught
        [103685] = true, -- Celestial Defender's Medallion

        -- Draenor
        [115468] = true, -- Permanent Frost Essence
        [119160] = true, -- Tickle Totem
        [119182] = true, -- Soul Evacuation Crystal
        [119421] = true, -- Sha'tari Defender's Medallion
        [128462] = true, -- Karabor Councilor's Attire
        [128471] = true, -- Frostwolf Grunt's Battlegear
        [122283] = true, -- Rukhmar's Sacred Memory
        [115472] = true, -- Permanent Time Bubble -- Alliance

        -- Legion
        [129367] = true, -- Vrykul Toy Boat Kit
        [130157] = true, -- Syxsehnz Rod
        [130158] = true, -- Path of Elothir
        [130191] = true, -- Trapped Treasure Chest Kit
        [130199] = true, -- Legion Pocket Portal
        [131814] = true, -- Whitewater Carp
        [131812] = true, -- Darkshard Fragment
        [130170] = true, -- Tear of the Green Aspect
        [129149] = true, -- Death's Door Charm
        [130232] = true, -- Moonfeather Statue
        [140324] = true, -- Mobile Telemancy Beacon
        [129279] = true, -- Enchanted Stone Whistle
        [140325] = true, -- Home Made Party Mask
        [142531] = true, -- Crate of Bobbers: Squeaky Duck
        [142532] = true, -- Crate of Bobbers: Murloc Head
        [147307] = true, -- Carved Wooden Helm
        [147308] = true, -- Enchanted Bobber
        [147309] = true, -- Face of the Forest
        [147310] = true, -- Floating Totem
        [147311] = true, -- Replica Gondola
        [147312] = true, -- Demon Noggin
        [147708] = true, -- Legion Invasion Simulator
        [153039] = true, -- Crystalline Campfire

        -- Battle for Azeroth
        [163565] = true, -- Vulpera Scrapper's Armor
        [163566] = true, -- Vulpera Battle Banner
        [163206] = true, -- Weary Spirit Binding
        [163463] = true, -- Dead Ringer
        [163211] = true, -- Akunda's Firesticks
        [163210] = true, -- Party Totem
        [159753] = true, -- Desert Flute
        [163200] = true, -- Cursed Spyglass
        [163201] = true, -- Gnoll Targetting Barrel
        [169108] = true, -- Rustbolt Banner
        [174995] = true, -- Void Tendril Pet Leash

        -- Shadowlands
        [182890] = true, -- Rapid Recitation Quill
        [183900] = true, -- Sinvyr Tea Set
        [184218] = true, -- Vulgarity Arbiter
        [184410] = true, -- Aspirant's Stretcher
    },

    ["Achievement"] = {
        [43824] = true, -- The Schools of Arcane Magic - Mastery
        [44430] = true, -- Titanium Seal of Dalaran
        [87528] = true, -- Honorary Brewmaster Keg
        [89205] = true, -- Mini Mana Bomb -- no longer available
        [92738] = true, -- Safari Hat
        [116115] = true, -- Blazing Wings
        [119215] = true, -- Robo-Gnomebulator
        [122293] = true, -- Trans-Dimensional Bird Whistle

        -- Legion
        [139773] = true, -- Emerald Winds
        [143660] = true, -- Mrgrglhjorn
        [156833] = true, -- Katy's Stampwhistle

        -- Battle for Azeroth
        [163697] = true, -- Laser Pointer
        [166247] = true, -- Citizens Brigade Whistle
        [168016] = true, -- Hyper-Compressed Ocean
        [174830] = true, -- Shadowy Disguise
        [174871] = true, -- Mayhem Mind Melder

        -- Shadowlands
        [182695] = true, -- Weathered Purple Parasol
        [184223] = true, -- Helm of the Dominated
        [184449] = true, -- Jiggles's Favorite Toy
        [184508] = true, -- Mawsworn Pet Leash
        [183903] = true, -- Smelly Jelly
    },

    ["PvP"] = {
        -- Toys from prestige PvP system
        [134026] = true, -- Honorable Pennant
        [134031] = true, -- Prestigious Pennant
        [134032] = true, -- Elite Pennant
        [134034] = true, -- Esteemed Pennant
        [164310] = true, -- Glorious Pennant
        [169297] = true, -- Stormpike Insignia
        [169298] = true, -- Frostwolf Insignia
    },

    ["Garrison"] = {
        [122700] = true, -- Portable Audiophone

        -- Garrison Mission
        [118191] = true, -- Archmage Vargoth's Spare Staff
        [118427] = true, -- Autographed Hearthstone Card
        [122674] = true, -- S.E.L.F.I.E. Camera MkII
        [128310] = true, -- Burning Blade

        -- Garrison Campaign
        [119134] = true, -- Sargerei Disguise
        [119144] = true, -- Touch of the Naaru

        -- Gladiator's Sanctum
        [119217] = true, -- Alliance Flag of Victory
        [119218] = true, -- Horde Flag of Victory
        [119219] = true, -- Warlord's Flag of Victory

        -- Lunarfall Inn / Frostwall Tavern
        [117573] = true, -- Wayfarer's Bonfire
        [118937] = true, -- Gamon's Braid
        [118938] = true, -- Manastorm's Duplicator
        [119003] = true, -- Void Totem
        [119039] = true, -- Lilian's Warning Sign
        [119083] = true, -- Fruit Basket
        [119092] = true, -- Moroes' Famous Polish

        -- Benjamin Brode
        [119210] = true, -- Hearthstone Board
        [119212] = true, -- Winning Hand

        -- Trading Post
        [113096] = true, -- Bloodmane Charm

        -- Giada Goldleash, Tiffy Trapspring
        [127695] = true, -- Spirit Wand
        [127696] = true, -- Magic Pet Mirror
        [127707] = true, -- Indestructible Bone

        -- Trader Araanda, Trader Darakk
        [127864] = true, -- Personal Spotlight

        -- Jonathan Stephens, Moz'def
        [122298] = true, -- Bodyguard Miniaturization Device
    },

    ["Order Hall"] = {
        [136855] = true, -- Hunter's Call -- only Hunter
        [136849] = true, -- Nature's Beacon -- only Druid
        [136927] = true, -- Scarlet Confessional Book -- only Priest
        [136928] = true, -- Thaumaturgist's Orb -- only Priest
        [136934] = true, -- Raging Elemental Stone -- only Shaman
        [136935] = true, -- Tadpole Cloudseeder -- only Shaman
        [136937] = true, -- Vol'jin's Serpent Totem -- only Shaman
        [138490] = true, -- Waterspeaker's Totem -- only Shaman
        [147537] = true, -- A Tiny Set of Warglaives -- demon hunter class hall
        [147832] = true, -- Magical Saucer -- mage class hall
        [139587] = true, -- Suspicious Crate
        [140160] = true, -- Stormforged Vrykul Horn
    },

    ["Pick Pocket"] = {
        [36862] = true, -- Worn Troll Dice
        [36863] = true, -- Decahedral Dwarven Dice
        [63269] = true, -- Loaded Gnomish Dice
        [120857] = true, -- Barrel of Bandanas
        [151877] = true, -- Barrel of Eyepatches
    },

    ["Black Market"] = {
        [32542] = true, -- Imp in a Ball
        [32566] = true, -- Picnic Basket
        [33219] = true, -- Goblin Gumbo Kettle
        [33223] = true, -- Fishing Chair
        [34499] = true, -- Paper Flying Machine Kit
        [35227] = true, -- Goblin Weather Machine - Prototype 01-B
        [38578] = true, -- The Flag of Ownership
        [45063] = true, -- Foam Sword Rack
        [46780] = true, -- Ogre Pinata
    },

    ["Shop"] = {
        [112324] = true, -- Nightmarish Hitching Post
        [166777] = true, -- Lion's Pride Firework
        [166778] = true, -- Horde's Might Firework
        [166779] = true, -- Transmorpher Beacon
    },

    ["Promotion"] = {
        [33079] = true, -- Murloc Costume
        [142542] = true, -- Tome of Town Portal
        [143543] = true, -- Twelve-String Guitar
        [158149] = true, -- Overtuned Corgi Goggles
        [163986] = true, -- Orgrimmar Hero's War Banner --Blizzcon 2018
        [163987] = true, -- Stormwind Champion's War Banner  --Blizzcon 2018
        [172179] = true, -- Eternal Traveler's Hearthstone - Shadowlands Epic Edition

        -- Trading Card Game
        [33219] = true, -- Goblin Gumbo Kettle
        [33223] = true, -- Fishing Chair
        [32566] = true, -- Picnic Basket
        [34499] = true, -- Paper Flying Machine Kit
        [32542] = true, -- Imp in a Ball
        [35227] = true, -- Goblin Weather Machine - Prototype 01-B
        [38301] = true, -- D.I.S.C.O.
        [38578] = true, -- The Flag of Ownership
        [45063] = true, -- Foam Sword Rack
        [46780] = true, -- Ogre Pinata
        [49703] = true, -- Perpetual Purple Firework
        [49704] = true, -- Carved Ogre Idol
        [54212] = true, -- Instant Statue Pedestal
        [67097] = true, -- Grim Campfire
        [69215] = true, -- War Party Hitching Post
        [69227] = true, -- Fool's Gold
        [71628] = true, -- Sack of Starfish
        [72159] = true, -- Magical Ogre Idol
        [72161] = true, -- Spurious Sarcophagus
        [79769] = true, -- Demon Hunter's Aspect
    },
}

ADDON.db.expansion = {
    [0] = { -- Classic
        ["minID"] = 0,
        ["maxID"] = 23700,
    },
    [1] = { -- The Burning Crusade
        ["minID"] = 23767,
        ["maxID"] = 36861,
        [37710] = true, -- Crashin' Thrashin' Racer Controller
        [38301] = true, -- D.I.S.C.O.
    },
    [2] = { -- Wrath of the Lich King
        ["minID"] = 36862,
        ["maxID"] = 54653,
    },
    [3] = { -- Cataclysm
        ["minID"] = 54654,
        ["maxID"] = 79999,
        [40727] = true, -- Gnomish Gravity Well
        [46709] = true, -- MiniZep Controller
        [53057] = true, -- Faded Wizard Hat
    },
    [4] = { -- Mists of Pandaria
        ["minID"] = 80000,
        ["maxID"] = 107999,
    },
    [5] = { -- Warlords of Draenor
        ["minID"] = 108000,
        ["maxID"] = 128999,
        [129926] = true, -- Mark of the Ashtongue
        [129929] = true, -- Ever-Shifting Mirror
        [129938] = true, -- Will of Northrend
        [129952] = true, -- Hourglass of Eternity
        [129965] = true, -- Grizzlesnout's Fang
        [133511] = true, -- Gurboggle's Gleaming Bauble
        [133542] = true, -- Tosselwrench's Mega-Accurate Simulation Viewfinder
    },
    [6] = { -- Legion
        ["minID"] = 129000,
        ["maxID"] = 156640,
        [156833] = true, -- Katy's Stampwhistle
    },
    [7] = { -- Battle for Azeroth
        ["minID"] = 156649,
        ["maxID"] = 175140,
    },

    [8] = { -- Shadowlands
        ["minID"] = 175141,
        ["maxID"] = 999999,
        [172179] = true, -- Eternal Traveler's Hearthstone
        [173984] = true, -- Scroll of Aeons
        [174445] = true, -- Glimmerfly Cocoon
    }
}

ADDON.db.effect = {

    ["Appearance"] = {

        -- Modify the entire character model, giving the player a new model
        ["Full"] = {
            [1973] = true, -- Orb of Deception
            [122283] = true, -- Rukhmar's Sacred Memory
            [17712] = true, -- Winter Veil Disguise Kit
            [32782] = true, -- Time-Lost Figurine
            [35275] = true, -- Orb of the Sin'dorei
            [37254] = true, -- Super Simian Sphere
            [72159] = true, -- Magical Ogre Idol
            [43499] = true, -- Iron Boot Flask
            [44719] = true, -- Frenzyheart Brew
            [52201] = true, -- Muradin's Favor
            [53057] = true, -- Faded Wizard Hat
            [54651] = true, -- Gnomeregan Pride
            [54653] = true, -- Darkspear Pride
            [64481] = true, -- Blessing of the Old God
            [64646] = true, -- Bones of Transformation
            [64651] = true, -- Wisp Amulet
            [66888] = true, -- Stave of Fur and Claw
            [68806] = true, -- Kalytha's Haunted Locket
            [71259] = true, -- Leyara's Locket
            [86568] = true, -- Mr. Smite's Brass Compass
            [86589] = true, -- Ai-Li's Skymirror
            [88566] = true, -- Krastinov's Bag of Horrors
            [103685] = true, -- Celestial Defender's Medallion
            [104294] = true, -- Rime of the Time-Lost Mariner
            [105898] = true, -- Moonfang's Paw
            [113096] = true, -- Bloodmane Charm
            [115506] = true, -- Treessassin's Guise
            [116067] = true, -- Ring of Broken Promises
            [116139] = true, -- Haunting Memento
            [116440] = true, -- Burning Defender's Medallion
            [118244] = true, -- Iron Buccaneer's Hat
            [118716] = true, -- Goren Garb
            [118937] = true, -- Gamon's Braid
            [118938] = true, -- Manastorm's Duplicator
            [119215] = true, -- Robo-Gnomebulator
            [119421] = true, -- Sha'tari Defender's Medallion
            [120276] = true, -- Outrider's Bridle Chain
            [122117] = true, -- Cursed Feather of Ikzan
            [122304] = true, -- Fandral's Seed Pouch
            [127394] = true, -- Podling Camouflage
            [127659] = true, -- Ghostly Iron Buccaneer's Hat
            [127668] = true, -- Jewel of Hellfire
            [127696] = true, -- Magic Pet Mirror
            [127709] = true, -- Throbbing Blood Orb
            [128807] = true, -- Coin of Many Faces
            [129113] = true, -- Faintly Glowing Flagon of Mead
            [129926] = true, -- Mark of the Ashtongue
            [129938] = true, -- Will of Northrend
            [130147] = true, -- Thistleleaf Branch
            [133511] = true, -- Gurboggle's Gleaming Bauble
            [134022] = true, -- Burgy Blackheart's Handsome Hat
            [138873] = true, -- Mystical Frosh Hat
            [140160] = true, -- Stormforged Vrykul Horn
            [140780] = true, -- Fal'dorei Egg
            [141862] = true, -- Mote of Light
            [142452] = true, -- Lingering Wyrmtongue Essence
            [143827] = true, -- Red Dragon Head Costume
            [143828] = true, -- Red Dragon Body Costume
            [143829] = true, -- Red Dragon Tail Costume
            [147843] = true, -- Sira's Extra Cloak
            [151270] = true, -- Horse Tail Costume
            [151271] = true, -- Horse Head Costume
            [152982] = true, -- Vixx's Chest of Tricks
            [163750] = true, -- Kovork Kostume
            [163795] = true, -- Oomgut Ritual Drum
            [164373] = true, -- Enchanted Soup Stone
            [164374] = true, -- Magic Monkey Banana
            [164375] = true, -- Bad Mojo Banana
            [165671] = true, -- Blue Dragon Head Costume
            [165672] = true, -- Blue Dragon Body Costume
            [165673] = true, -- Blue Dragon Tail Costume
            [165674] = true, -- Green Dragon Head Costume
            [165675] = true, -- Green Dragon Body Costume
            [165676] = true, -- Green Dragon Tail Costume
            [166308] = true, -- For da Blood God!
            [166544] = true, -- Dark Ranger's Spare Cowl
            [166779] = true, -- Transmorpher Beacon
            [166790] = true, -- Highborne Memento
            [172219] = true, -- Wild Holly
            [174873] = true, -- Trans-mogu-rifier
            [180947] = true, -- Tithe Collector's Vessel
            [183847] = true, -- Acolyte's Guise
            [183903] = true, -- Smelly Jelly
            [170154] = true, -- Book of the Unshackled
            [170155] = true, -- Carved Ankoan Charm
        },

        -- Add to or slightly change the existing character model, keeping the same model
        ["Minor"] = {
            [35227] = true, -- Goblin Weather Machine - Prototype 01-B
            [64361] = true, -- Druid and Priest Statue Set
            [69895] = true, -- Green Balloon
            [69896] = true, -- Yellow Balloon
            [75042] = true, -- Flimsy Yellow Balloon
            [79769] = true, -- Demon Hunter's Aspect
            [86593] = true, -- Hozen Beach Ball
            [87528] = true, -- Honorary Brewmaster Keg
            [88580] = true, -- Ken-Ken's Mask
            [101571] = true, -- Moonfang Shroud
            [104302] = true, -- Blackflame Daggers
            [108739] = true, -- Pretty Draenor Pearl
            [108743] = true, -- Deceptia's Smoldering Boots
            [111476] = true, -- Stolen Breath
            [113375] = true, -- Vindicator's Armor Polish Kit
            [115503] = true, -- Blazing Diamond Pendant
            [116115] = true, -- Blazing Wings
            [119092] = true, -- Moroes' Famous Polish
            [119134] = true, -- Sargerei Disguise
            [119144] = true, -- Touch of the Naaru
            [127670] = true, -- Accursed Tome of the Sargerei
            [127864] = true, -- Personal Spotlight
            [128462] = true, -- Karabor Councilor's Attire
            [128471] = true, -- Frostwolf Grunt's Battlegear
            [129093] = true, -- Ravenbear Disguise
            [130158] = true, -- Path of Elothir
            [131812] = true, -- Darkshard Fragment
            [133997] = true, -- Black Ice
            [134004] = true, -- Noble's Eternal Elementium Signet
            [134007] = true, -- Eternal Black Diamond Ring
            [134831] = true, -- Doomsayer's Robes
            [137294] = true, -- Dalaran Initiates' Pin
            [138490] = true, -- Waterspeaker's Totem
            [138900] = true, -- Gravil Goldbraid's Famous Sausage Hat
            [139337] = true, -- Disposable Winter Veil Suits
            [140314] = true, -- Crab Shank
            [141301] = true, -- Unstable Powder Box
            [144393] = true, -- Portable Yak Wash
            [151348] = true, -- Toy Weapon Set
            [151349] = true, -- Toy Weapon Set
            [153179] = true, -- Blue Conservatory Scroll
            [153180] = true, -- Yellow Conservatory Scroll
            [153181] = true, -- Red Conservatory Scroll
            [162642] = true, -- Toy Armor Set
            [162643] = true, -- Toy Armor Set
            [163713] = true, -- Brazier Cap
            [163738] = true, -- Syndicate Mask
            [163775] = true, -- Molok Morion
            [163924] = true, -- Whiskerwax Candle
            [165791] = true, -- Worn Cloak
            [166663] = true, -- Hand Anchor
            [167931] = true, -- Mechagonian Sawblades
            [168123] = true, -- Twitching Eyeball
            [170198] = true, -- Eternal Palace Dining Set
            [170199] = true, -- Zanj'ir Weapon Rack
            [175140] = true, -- All-Seeing Eyes
            [179393] = true, -- Mirror of Envious Dreams
            [180873] = true, -- Smolderheart
        },

        ["Bigger"] = {
            [69775] = true, -- Vrykul Drinking Horn
            [109183] = true, -- World Shrinker
        },

        ["Smaller"] = {
            [18660] = true, -- World Enlarger
            [97919] = true, -- Whole-Body Shrinka'
        },

        -- Change only the color/transparency of the model
        ["Color"] = {
            [86571] = true, -- Kang's Bindstone
            [88377] = true, -- Turnip Paint "Gun"
            [104262] = true, -- Odd Polished Stone
            [115468] = true, -- Permanent Frost Essence
            [129149] = true, -- Death's Door Charm
            [140309] = true, -- Prismatic Bauble
            [140325] = true, -- Home Made Party Mask
            [153293] = true, -- Sightless Eye
            [159749] = true, -- Haw'li's Hot & Spicy Chili
            [163736] = true, -- Spectral Visage
            [163742] = true, -- Heartsbane Grimoire
            [166785] = true, -- Detoxified Blight Grenade
            [170204] = true, -- Symbol of Gral
            [173984] = true, -- Scroll of Aeons
            [174830] = true, -- Shadowy Disguise
        },

        -- Banners the character wears on their back
        ["Pennant"] = {
            [116758] = true, -- Brewfest Banner
            [128310] = true, -- Burning Blade
            [134026] = true, -- Honorable Pennant
            [134031] = true, -- Prestigious Pennant
            [134032] = true, -- Elite Pennant
            [134034] = true, -- Esteemed Pennant
            [164310] = true, -- Glorious Pennant
            [168014] = true, -- Banner of the Burning Blade
            [169275] = true, -- Alliance War Banner
            [169276] = true, -- Horde War Banner
            [150547] = true, -- Jolly Roger
        },
    },

    ["Consumable"] = {

        ["Alcohol"] = {
            [33927] = true, -- Brewfest Pony Keg
            [71137] = true, -- Brewfest Keg Pony
            [88531] = true, -- Lao Chin's Last Mug
            [88579] = true, -- Jin Warmkeg's Brew
            [118224] = true, -- Ogre Brewing Kit
            [119001] = true, -- Mystery Keg
            [169865] = true, -- Brewfest Chowdown Trophy
        },

        ["Food/Water"] = {
            [86578] = true, -- Eternal Warrior's Sigil
            [113540] = true, -- Ba'ruun's Bountiful Bloom
            [116120] = true, -- Tasty Talador Lunch
            [118935] = true, -- Ever-Blooming Frond
            [128223] = true, -- Bottomless Stygana Mushroom Brew
            [130151] = true, -- The "Devilsaur" Lunchbox
            [166703] = true, -- Goldtusk Inn Breakfast Buffet
        },

        ["Other"] = {
            [17716] = true, -- Snowmaster 9000
            [21540] = true, -- Elune's Lantern
        }
    },

    -- Control a separate entity while the player character stands still
    ["Controller"] = {

        ["Aircraft"] = {
            [46709] = true, -- MiniZep Controller
            [88802] = true, -- Foxicopter Controller
            [104318] = true, -- Crashin' Thrashin' Flyer Controller
            [147708] = true, -- Legion Invasion Simulator
        },

        ["Tonk"] = {
            [37710] = true, -- Crashin' Thrashin' Racer Controller
            [54343] = true, -- Blue Crashin' Thrashin' Racer Controller
            [98136] = true, -- Gastropod Shell
            [108631] = true, -- Crashin' Thrashin' Roller Controller
            [108632] = true, -- Crashin' Thrashin' Flamer Controller
            [108633] = true, -- Crashin' Thrashin' Cannon Controller
            [108634] = true, -- Crashin' Thrashin' Mortar Controller
            [108635] = true, -- Crashin' Thrashin' Killdozer Controller
            [116763] = true, -- Crashin' Thrashin' Shredder Controller
            [122122] = true, -- Darkmoon Tonk Controller
            [153126] = true, -- Micro-Artillery Controller
            [163828] = true, -- Toy Siege Tower
            [163829] = true, -- Toy War Machine
            [166743] = true, -- Blight Bomber
            [166744] = true, -- Glaive Tosser
            [172222] = true, -- Crashin' Thrashin' Juggernaught
            [172223] = true, -- Crashin' Thrashin' Battleship
        },

        ["Vision"] = {
            [122121] = true, -- Darkmoon Gazer
            [153253] = true, -- S.F.E. Interceptor
        }
    },

    -- Non-combat creatures; unrelated to battle pets
    ["Critter"] = {

        ["Nearby"] = {
            [86586] = true, -- Panflute of Pandaria
            [88385] = true, -- Hozen Idol
            [113631] = true, -- Hypnosis Goggles
            [118221] = true, -- Petrification Stone
            [131933] = true, -- Critter Hand Cannon
            [136937] = true, -- Vol'jin's Serpent Totem
            [153124] = true, -- Spire of Spite
            [174924] = true, -- Void-Touched Souvenir Totem
        },

        ["Summon"] = {
            [23767] = true, -- Crashin' Thrashin' Robot
            [32542] = true, -- Imp in a Ball
            [64881] = true, -- Pendant of the Scarab Storm
            [69227] = true, -- Fool's Gold
            [82467] = true, -- Ruthers' Harness
            [91904] = true, -- Stackable Stag
            [98552] = true, -- Xan'tish's Flute
            [117569] = true, -- Giant Deathweb Egg
            [128328] = true, -- Skoller's Bag of Squirrel Treats
            [128794] = true, -- Sack of Spectral Spiders
            [129279] = true, -- Enchanted Stone Whistle
            [134019] = true, -- Don Carlos' Famous Hat
            [136846] = true, -- Familiar Stone
            [136855] = true, -- Hunter's Call
            [136934] = true, -- Raging Elemental Stone
            [138878] = true, -- Copy of Daglop's Contract
            [140786] = true, -- Ley Spider Eggs
            [143534] = true, -- Wand of Simulated Life
            [143660] = true, -- Mrgrglhjorn
            [144072] = true, -- Adopted Puppy Crate
            [147537] = true, -- A Tiny Set of Warglaives
            [147867] = true, -- Pilfered Sweeper
            [156871] = true, -- Spitzy
            [159753] = true, -- Desert Flute
            [160740] = true, -- Croak Crock
            [174445] = true, -- Glimmerfly Cocoon
            [183986] = true, -- Bondable Sinstone
            [183988] = true, -- Bondable Val'kyr Diadem
            [136928] = true, -- Thaumaturgist's Orb
            [174874] = true, -- Budget K'thir Disguise
            [161342] = true, -- Gem of Acquiescence
            [122293] = true, -- Trans-Dimensional Bird Whistle
        },
    },

    -- Dances, Laughter, Poses, Roleplaying, etc
    ["Emote"] = {

        ["Act"] = {
            [13379] = true, -- Piccolo of the Flaming Fire
            [33219] = true, -- Goblin Gumbo Kettle
            [34686] = true, -- Brazier of Dancing Flames
            [38301] = true, -- D.I.S.C.O.
            [44606] = true, -- Toy Train Set
            [45057] = true, -- Wind-Up Train Wrecker
            [45984] = true, -- Unusual Compass
            [50471] = true, -- The Heartbreaker
            [60854] = true, -- Loot-A-Rang
            [64482] = true, -- Puzzle Box of Yogg-Saron
            [88801] = true, -- Flippable Table
            [90067] = true, -- B. F. F. Necklace
            [109167] = true, -- Findle's Loot-A-Rang
            [114227] = true, -- Bubble Wand
            [117550] = true, -- Angry Beehive
            [118427] = true, -- Autographed Hearthstone Card
            [119083] = true, -- Fruit Basket
            [119160] = true, -- Tickle Totem
            [122123] = true, -- Darkmoon Ring-Flinger
            [122129] = true, -- Fire-Eater's Vial
            [129055] = true, -- Shoe Shine Kit
            [130169] = true, -- Tournament Favor
            [133542] = true, -- Tosselwrench's Mega-Accurate Simulation Viewfinder
            [133998] = true, -- Rainbow Generator
            [138415] = true, -- Slightly-Chewed Insult Book
            [138876] = true, -- Runas' Crystal Grinder
            [141298] = true, -- Displacer Meditation Stone
            [141649] = true, -- Set of Matches
            [143544] = true, -- Skull of Corruption
            [143727] = true, -- Champion's Salute
            [147838] = true, -- Akazamzarak's Spare Hat
            [151265] = true, -- Blight Boar Microphone
            [152574] = true, -- Corbyn's Beacon
            [153183] = true, -- Barrier Generator
            [160509] = true, -- Echoes of Rezan
            [162539] = true, -- Hot Buttered Popcorn
            [163210] = true, -- Party Totem
            [163735] = true, -- Foul Belly
            [165021] = true, -- Words of Akunda
            [168012] = true, -- Apexis Focusing Shard
            [169277] = true, -- Horde War Standard
            [169278] = true, -- Alliance War Standard
            [169303] = true, -- Hell-Bent Bracers
            [169768] = true, -- Heart of a Champion
            [175063] = true, -- Aqir Egg Cluster
            [181794] = true, -- Orophea's Lyre
            [182732] = true, -- The Necronom-i-nom
            [183856] = true, -- Mystical Orb of Meditation
            [136927] = true, -- Scarlet Confessional Book
            [139587] = true, -- Suspicious Crate
            [127666] = true, -- Vial of Red Goo
            [116651] = true, -- True Love Prism
        },

        ["Corpse"] = {
            [88589] = true, -- Cremating Torch
            [90175] = true, -- Gin-Ji Knife Set
            [119163] = true, -- Soul Inhaler
            [119182] = true, -- Soul Evacuation Crystal
            [163740] = true, -- Drust Ritual Knife
            [166701] = true, -- Warbeast Kraal Dinner Bell
            [166784] = true, -- Narassin's Soul Gem
        },

        ["Roll"] = {
            [36862] = true, -- Worn Troll Dice
            [36863] = true, -- Decahedral Dwarven Dice
            [44430] = true, -- Titanium Seal of Dalaran
            [63269] = true, -- Loaded Gnomish Dice
        },

        ["Statue"] = {
            [54212] = true, -- Instant Statue Pedestal
            [69776] = true, -- Ancient Amber
            [72161] = true, -- Spurious Sarcophagus
            [115472] = true, -- Permanent Time Bubble
            [116125] = true, -- Klikixx's Webspinner
            [130171] = true, -- Cursed Orb
            [141879] = true, -- Berglrgl Perrgl Girggrlf
            [164983] = true, -- Rhan'ka's Escape Plan
            [113570] = true, -- Ancient's Bloom
            [119432] = true, -- Botani Camouflage
            [86573] = true, -- Shard of Archstone
            [88417] = true, -- Gokk'lok's Shell
        },

    },

    ["Environment"] = {

        -- Poles that stick out of the ground
        ["Banner"] = {
            [45011] = true, -- Stormwind Banner
            [45013] = true, -- Thunder Bluff Banner
            [45014] = true, -- Orgrimmar Banner
            [45015] = true, -- Sen'jin Banner
            [45016] = true, -- Undercity Banner
            [45017] = true, -- Silvermoon City Banner
            [45018] = true, -- Ironforge Banner
            [45019] = true, -- Gnomeregan Banner
            [45020] = true, -- Exodar Banner
            [45021] = true, -- Darnassus Banner
            [46843] = true, -- Argent Crusader's Banner
            [95589] = true, -- Glorious Standard of the Kirin Tor Offensive
            [95590] = true, -- Glorious Standard of the Sunreaver Onslaught
            [163986] = true, -- Orgrimmar Hero's War Banner
            [163987] = true, -- Stormwind Champion's War Banner
            [166879] = true, -- Rallying War Banner
            [169108] = true, -- Rustbolt Banner
        },

        -- Summons a clone of the character
        ["Clone"] = {
            [64358] = true, -- Highborne Soul Mirror
            [108745] = true, -- Personal Hologram
            [129952] = true, -- Hourglass of Eternity
        },

        -- Controlled explosives
        ["Firework"] = {
            [30690] = true, -- Power Converter
            [49703] = true, -- Perpetual Purple Firework
            [86588] = true, -- Pandaren Firework Launcher
            [89999] = true, -- Everlasting Alliance Firework
            [90000] = true, -- Everlasting Horde Firework
            [119212] = true, -- Winning Hand
            [122119] = true, -- Everlasting Darkmoon Firework
            [138202] = true, -- Sparklepony XL
            [166877] = true, -- Azerite Firework Launcher
            [166778] = true, -- Horde's Might Firework
            [166777] = true, -- Lion's Pride Firework
        },

        --
        ["Ground"] = {
            [54437] = true, -- Tiny Green Ragdoll
            [54438] = true, -- Tiny Blue Ragdoll
            [63141] = true, -- Tol Barad Searchlight
            [64456] = true, -- Arrival of the Naaru
            [64997] = true, -- Tol Barad Searchlight
            [70159] = true, -- Mylune's Call
            [80822] = true, -- The Golden Banana
            [88381] = true, -- Silversage Incense
            [88584] = true, -- Totem of Harmony
            [89205] = true, -- Mini Mana Bomb
            [89869] = true, -- Pandaren Scarecrow
            [109739] = true, -- Star Chart
            [116122] = true, -- Burning Legion Missive
            [118222] = true, -- Spirit of Bashiok
            [122126] = true, -- Attraction Sign
            [130170] = true, -- Tear of the Green Aspect
            [130199] = true, -- Legion Pocket Portal
            [130214] = true, -- Worn Doll
            [130232] = true, -- Moonfeather Statue
            [140363] = true, -- Pocket Fel Spreader
            [141297] = true, -- Arcano-Shower
            [160751] = true, -- Dance of the Dead
            [169347] = true, -- Judgment of Mechagon
            [140632] = true, -- Lava Fountain
        },

        ["Weather"] = {
            [119003] = true, -- Void Totem
            [119145] = true, -- Firefury Totem
            [131724] = true, -- Crystalline Eye of Undravius
            [136935] = true, -- Tadpole Cloudseeder
            [163744] = true, -- Coldrage's Cooler
        }
    },

    ["Interactable"] = {

        -- Can sit in these
        ["Chair"] = {
            [33223] = true, -- Fishing Chair
            [70161] = true, -- Mushroom Chair
            [86596] = true, -- Nat's Fishing Chair
            [97994] = true, -- Darkmoon Seesaw
            [116689] = true, -- Pineapple Lounge Cushion
            [116690] = true, -- Safari Lounge Cushion
            [116691] = true, -- Zhevra Lounge Cushion
            [116692] = true, -- Fuzzy Green Lounge Cushion
            [129956] = true, -- Leather Love Seat
        },

        -- Can click on these
        ["Clickable"] = {
            [32566] = true, -- Picnic Basket
            [34480] = true, -- Romantic Picnic Basket
            [69215] = true, -- War Party Hitching Post
            [88370] = true, -- Puntable Marmot
            [88387] = true, -- Shushen's Spittoon
            [104331] = true, -- Warning Sign
            [112324] = true, -- Nightmarish Hitching Post
            [119039] = true, -- Lilian's Warning Sign
            [119210] = true, -- Hearthstone Board
            [130191] = true, -- Trapped Treasure Chest Kit
            [130209] = true, -- Never Ending Toy Chest
            [131814] = true, -- Whitewater Carp
            [141296] = true, -- Ancient Mana Basin
            [141299] = true, -- Kaldorei Light Globe
            [156649] = true, -- Zandalari Effigy Amulet
            [166704] = true, -- Bowl of Glowing Pufferfish
            [166808] = true, -- Bewitching Tea Set
            [169796] = true, -- Azeroth Mini Collection: Mechagon
            [170196] = true, -- Shirakess Warning Sign
            [170203] = true, -- Flopping Fish
            [170476] = true, -- Underlight Sealamp
            [174920] = true, -- Coifcurl's Close Shave Kit
            [174928] = true, -- Rotten Apple
            [120857] = true, -- Barrel of Bandanas
        },

        ["Mail"] = {
            [40768] = true, -- MOLL-E
            [156833] = true, -- Katy's Stampwhistle
        },

        ["NPC"] = {
            [86583] = true, -- Salyin Battle Banner
            [86594] = true, -- Helpful Wikky's Whistle
            [87214] = true, -- Blingtron 4000
            [111821] = true, -- Blingtron 5000
            [118191] = true, -- Archmage Vargoth's Spare Staff
            [122681] = true, -- Sternfathom's Pet Journal
            [127655] = true, -- Sassy Imp
            [166247] = true, -- Citizens Brigade Whistle
            [168667] = true, -- Blingtron 7000
        },

        -- Can attack these
        ["Target Dummy"] = {
            [46780] = true, -- Ogre Pinata
            [88375] = true, -- Turnip Punching Bag
            [89614] = true, -- Anatomical Dummy
            [144339] = true, -- Sturdy Love Fool
            [163201] = true, -- Gnoll Targeting Barrel
        },
    },

    ["Game"] = {

        ["Solo"] = {
            [130251] = true, -- JewelCraft
            [132518] = true, -- Blingtron's Circuit Design Tutorial
            [166787] = true, -- Twiddle Twirler: Sentinel's Glaive
            [166788] = true, -- Twiddle Twirler: Shredder Blade
        },

        ["Co-op"] = {
            [34499] = true, -- Paper Flying Machine Kit
            [45063] = true, -- Foam Sword Rack
            [71628] = true, -- Sack of Starfish
            [90427] = true, -- Pandaren Brewpack
            [90883] = true, -- The Pigskin
            [90888] = true, -- Special Edition Foot Ball
            [98132] = true, -- Shado-Pan Geyser Gun
            [104323] = true, -- The Swineskin
            [104324] = true, -- Foot Ball
            [116856] = true, -- "Blooming Rose" Contender's Costume
            [116888] = true, -- "Night Demon" Contender's Costume
            [116889] = true, -- "Purple Phantom" Contender's Costume
            [116890] = true, -- "Santo's Sun" Contender's Costume
            [116891] = true, -- "Snowy Owl" Contender's Costume
            [127859] = true, -- Dazzling Rod
            [128636] = true, -- Endothermic Blaster
            [129057] = true, -- Dalaran Disc
            [129367] = true, -- Vrykul Toy Boat Kit
            [137663] = true, -- Soft Foam Sword
            [141306] = true, -- Wisp in a Bottle
            [151184] = true, -- Verdant Throwing Sphere
            [151343] = true, -- Hearthstation
            [151344] = true, -- Hearthstation
            [153182] = true, -- Holy Lightsphere
            [163607] = true, -- Lucille's Sewing Needle
            [163741] = true, -- Magic Fun Rock
            [174921] = true, -- Void-Touched Skull
            [181825] = true, -- Phial of Ravenous Slime
            [116400] = true, -- Silver-Plated Turkey Shooter
        }
    },

    ["Profession"] = {

        ["Cooking"] = {
            [67097] = true, -- Grim Campfire
            [70722] = true, -- Little Wickerman
            [104309] = true, -- Eternal Kiln
            [116435] = true, -- Cozy Bonfire
            [116757] = true, -- Steamworks Sausage Grill
            [117573] = true, -- Wayfarer's Bonfire
            [127652] = true, -- Felflame Campfire
            [128536] = true, -- Leylight Brazier
            [134020] = true, -- Chef's Hat
            [153039] = true, -- Crystalline Campfire
            [163211] = true, -- Akunda's Firesticks
            [182780] = true, -- Muckpool Cookpot
        },

        ["Fishing"] = {
            [85973] = true, -- Ancient Pandaren Fishing Charm
            [142528] = true, -- Crate of Bobbers: Can of Worms
            [142529] = true, -- Crate of Bobbers: Cat Head
            [142530] = true, -- Crate of Bobbers: Tugboat
            [142531] = true, -- Crate of Bobbers: Squeaky Duck
            [142532] = true, -- Crate of Bobbers: Murloc Head
            [143662] = true, -- Crate of Bobbers: Wooden Pepe
            [147307] = true, -- Crate of Bobbers: Carved Wooden Helm
            [147308] = true, -- Crate of Bobbers: Enchanted Bobber
            [147309] = true, -- Crate of Bobbers: Face of the Forest
            [147310] = true, -- Crate of Bobbers: Floating Totem
            [147311] = true, -- Crate of Bobbers: Replica Gondola
            [147312] = true, -- Crate of Bobbers: Demon Noggin
            [152556] = true, -- Trawler Totem
            [168016] = true, -- Hyper-Compressed Ocean
            [180993] = true, -- Bat Visage Bobber
        },

        ["Jewelcrafting"] = {
            [130254] = true, -- Chatterstone
        },

        ["Skinning"] = {
            [130102] = true, -- Mother's Skinning Knife
        },
    },

    ["PVP"] = {

        ["Ashran"] = {
            [115505] = true, -- LeBlanc's Recorder
            [116396] = true, -- LeBlanc's Recorder
        },

        ["Dismount"] = {
            [86584] = true, -- Hardened Shell
        },

        ["Taunt"] = {
            [38578] = true, -- The Flag of Ownership
            [86575] = true, -- Chalice of Secrets
            [119217] = true, -- Alliance Flag of Victory
            [119218] = true, -- Horde Flag of Victory
            [119219] = true, -- Warlord's Flag of Victory
        },

        ["Transform"] = {
            [102467] = true, -- Censer of Eternal Agony
            [173951] = true, -- N'lyeth, Sliver of N'Zoth
        }
    },

    ["Sound"] = {

        ["Effect"] = {
            [64383] = true, -- Kaldorei Wind Chimes
            [86565] = true, -- Battle Horn
            [90899] = true, -- Darkmoon Whistle
            [97942] = true, -- Sen'jin Spirit Drum
            [108735] = true, -- Arena Master's War Horn
            [113670] = true, -- Mournful Moan of Murmur
            [126931] = true, -- Seafarer's Slidewhistle
            [163463] = true, -- Dead Ringer
            [163745] = true, -- Witherbark Gong
            [168824] = true, -- Ocean Simulator
        },

        ["Music"] = {
            [52253] = true, -- Sylvanas' Music Box
            [64373] = true, -- Chalice of the Mountain Kings
            [69777] = true, -- Haunted War Drum
            [115501] = true, -- Kowalski's Music Box
            [122700] = true, -- Portable Audiophone
            [143543] = true, -- Twelve-String Guitar
            [166702] = true, -- Proudmoore Music Box
            [166880] = true, -- Meerah's Jukebox
        },

        ["Voice"] = {
            [170469] = true, -- Memento of the Deeps
        }
    },

    ["Transportation"] = {

        -- Fly or Slowfall
        ["Fly/Fall"] = {
            [40727] = true, -- Gnomish Gravity Well
            [113542] = true, -- Whispers of Rai'Vosh
            [119093] = true, -- Aviana's Feather
            [131811] = true, -- Rocfeather Skyhorn Kite
            [134021] = true, -- X-52 Rocket Helmet
            [173727] = true, -- Nomi's Vintage
            [177951] = true, -- Glimmerflies on Strings
            [182694] = true, -- Stylish Black Parasol
            [182695] = true, -- Weathered Purple Parasol
            [182696] = true, -- The Countess's Parasol
            [182729] = true, -- Hearty Dragon Plume
        },

        -- Unlocks flight paths
        ["Flight Path"] = {
            [150743] = true, -- Surviving Kalimdor
            [150744] = true, -- Walking Kalimdor with the Earthmother
            [150745] = true, -- The Azeroth Campaign
            [150746] = true, -- To Modernize the Provisioning of Azeroth
        },

        ["Hearthstone"] = {
            [64488] = true, -- The Innkeeper's Daughter
            [162973] = true, -- Greatfather Winter's Hearthstone
            [163045] = true, -- Headless Horseman's Hearthstone
            [165669] = true, -- Lunar Elder's Hearthstone
            [165670] = true, -- Peddlefeet's Lovely Hearthstone
            [165802] = true, -- Noble Gardener's Hearthstone
            [166746] = true, -- Fire Eater's Hearthstone
            [166747] = true, -- Brewfest Reveler's Hearthstone
            [168907] = true, -- Holographic Digitalization Hearthstone
            [172179] = true, -- Eternal Traveler's Hearthstone
            [180290] = true, -- Night Fae Hearthstone
            [182773] = true, -- Necrolord Hearthstone
            [183716] = true, -- Venthyr Sinstone
            [184353] = true, -- Kyrian Hearthstone
        },

        ["Jump"] = {
            [86590] = true, -- Essence of the Breeze
            [116113] = true, -- Breath of Talador
            [119178] = true, -- Black Whirlwind
            [134023] = true, -- Bottled Tornado
            [139773] = true, -- Emerald Winds
            [140336] = true, -- Brulfist Idol
        },

        ["Run"] = {
            [104329] = true, -- Ash-Covered Horn
            [113543] = true, -- Spirit of Shinri
            [119180] = true, -- Goren "Log" Roller
            [127669] = true, -- Skull of the Mad Chief
            [129965] = true, -- Grizzlesnout's Fang
            [131900] = true, -- Majestic Elderhorn Hoof
            [153193] = true, -- Baarut the Brisk
        },

        ["Swim"] = {
            [86582] = true, -- Aqua Jewel
            [129165] = true, -- Barnacle-Encrusted Gem
            [134024] = true, -- Cursed Swabby Helmet
        },

        ["Teleport"] = {
            [18986] = true, -- Ultrasafe Transporter: Gadgetzan
            [30544] = true, -- Ultrasafe Transporter: Toshley's Station
            [43824] = true, -- The Schools of Arcane Magic - Mastery
            [48933] = true, -- Wormhole Generator: Northrend
            [87215] = true, -- Wormhole Generator: Pandaria
            [95567] = true, -- Kirin Tor Beacon
            [95568] = true, -- Sunreaver Beacon
            [112059] = true, -- Wormhole Centrifuge
            [129929] = true, -- Ever-Shifting Mirror
            [140324] = true, -- Mobile Telemancy Beacon
            [151016] = true, -- Fractured Necrolyte Skull
            [151652] = true, -- Wormhole Generator: Argus
            [168807] = true, -- Wormhole Generator: Kul Tiras
            [168808] = true, -- Wormhole Generator: Zandalar
            [169297] = true, -- Stormpike Insignia
            [169298] = true, -- Frostwolf Insignia
            [30542] = true, -- Dimensional Ripper - Area 52
            [18984] = true, -- Dimensional Ripper - Everlook
            [136849] = true, -- Nature's Beacon
            [153004] = true, -- Unstable Portal Emitter
        },

        ["Water Walk"] = {
            [85500] = true, -- Angler's Fishing Raft
            [142341] = true, -- Love Boat
            [166461] = true, -- Gnarlwood Waveboard
        }
    },

    ["Perception"] = {
        [40895] = true, -- Gnomish X-Ray Specs
        [86581] = true, -- Farwater Conch
        [97921] = true, -- Bom'bay's Color-Seein' Sauce
        [116456] = true, -- Scroll of Storytelling
        [122120] = true, -- Gaze of the Darkmoon
        [122298] = true, -- Bodyguard Miniaturization Device
        [122674] = true, -- S.E.L.F.I.E. Camera MkII
        [123851] = true, -- Photo B.O.M.B.
        [129211] = true, -- Steamy Romance Novel Kit
        [130157] = true, -- Syxsehnz Rod
        [142536] = true, -- Memory Cube
        [153194] = true, -- Legion Communication Orb
        [153204] = true, -- All-Seer's Eye
        [158149] = true, -- Overtuned Corgi Goggles
        [163200] = true, -- Cursed Spyglass
        [166678] = true, -- Brynja's Beacon
        [170187] = true, -- Shadescale
        [170380] = true, -- Jar of Sunwarmed Sand
        [174926] = true, -- Overly Sensitive Void Spectacles
        [163603] = true, -- Lucille's Handkerchief
    },

    -- Battle pets; No critters or combat/hunter pets
    ["Battle Pet"] = {
        [127707] = true, -- Indestructible Bone
        [37460] = true, -- Rope Pet Leash
        [44820] = true, -- Red Ribbon Pet Leash
        [89139] = true, -- Chain Pet Leash
        [89222] = true, -- Cloud Ring
        [92738] = true, -- Safari Hat
        [127695] = true, -- Spirit Wand
        [127766] = true, -- The Perfect Blossom
        [128776] = true, -- Red Wooden Sled
        [129958] = true, -- Leather Pet Leash
        [129960] = true, -- Leather Pet Bed
        [129961] = true, -- Flaming Hoop
        [140231] = true, -- Narcissa's Mirror
        [142265] = true, -- Big Red Raygun
        [142494] = true, -- Purple Blossom
        [142495] = true, -- Fake Teeth
        [142496] = true, -- Dirty Spoon
        [142497] = true, -- Tiny Pack
        [147832] = true, -- Magical Saucer
        [163697] = true, -- Laser Pointer
        [163704] = true, -- Tiny Mechanical Mouse
        [163705] = true, -- Imaginary Gun
        [166662] = true, -- Cranky Crab
        [174871] = true, -- Mayhem Mind Melder
        [174995] = true, -- Void Tendril Pet Leash
        [184508] = true, -- Mawsworn Pet Leash
    },
}
