local _, ADDON = ...

local isClassic = WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE

ADDON.db = {}

if isClassic then
    ADDON.db.Recent = {
        ["minID"] = 80000,
        ["blacklist"] = { 198647, 184871, 216893}, -- Fishspeaker's Lucky Lure, Dark Portal, Goblin Town-in-a-Box
        ["whitelist"] = { },
    }
else
    local build = select(4, GetBuildInfo())
    if build < 120000 then
        ADDON.db.Recent = {
            ["minID"] = 256881,
            ["blacklist"] = {},
            ["whitelist"] = {242520,243304,245580},
        }
    else
        ADDON.db.Recent = {
            ["minID"] = 258963,
            ["blacklist"] = {},
            ["whitelist"] = {243146, 249468, 250319, 250320, 250974, 251491, 251633, 251903, 252265, 253629, 256552, 257736,},
        }
    end
end

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
        [187591] = true, -- Nightborne Guard's Vigilance
        [224192] = true, -- Practice Ravager
        [228789] = true, -- Coldflame Ring
        [229828] = true, -- 20th Anniversary Balloon Chest
        [245942] = true, -- Sea-Blessed Shrine
        [246227] = true, -- Lightning-Blessed Spire
        [256881] = true, -- Steward's Bauble
        [256893] = true, -- Wretched Dredger's Brand
    },

    ["Darkmoon Faire"] = {
        [75042] = true, -- Flimsy Yellow Balloon
        [90899] = true, -- Darkmoon Whistle
        [97994] = true, -- Darkmoon Seesaw
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
        [138202] = true, -- Sparklepony XL
        [151265] = true, -- Blight Boar Microphone
        [162539] = true, -- Hot Buttered Popcorn
        [187689] = true, -- Dance Dance Darkmoon
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
        [210974] = true, -- Eyes For You Only
        [210975] = true, -- Date Simulation Modulator
        [211864] = true, -- Exquisite Love Boat
    },

    ["Noblegarden"] = {
        [165802] = true, -- Noble Gardener's Hearthstone
        [188694] = true, -- Spring Florist's Pouch
        [188698] = true, -- Eagger Basket
        [204675] = true, -- A Drake's Big Basket of Eggs
        [216881] = true, -- Duck Disguiser
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
        [188695] = true, -- Summer Cranial Skillet
        [188699] = true, -- Insulated Dancing Insoles
        [188701] = true, -- Fire Festival Batons
        [206038] = true, -- Flamin' Ring of Flashiness
    },

    ["Secrets of Azeroth"] = {
        [206696] = true, -- Tricked-Out Thinking Cap
        [207730] = true, -- Idol of Ohn'ahra
        [208092] = true, -- Torch of Pyrreth
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
        [209052] = true, -- Brew Barrel
        [245946] = true, -- Brewer's Balloon
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
        [178530] = true, -- Wreath-A-Rang
        [187422] = true, -- Rockin' Rollin' Racer Customizer 19.9.3
        [188680] = true, -- Winter Veil Chorus Book
        [191925] = true, -- Falling Star Flinger
        [191937] = true, -- Falling Star Catcher
        [208825] = true, -- Junior Timekeeper's Racing Belt
        [209859] = true, -- Festive Trans-Dimensional Bird Whistle
        [210656] = true, -- Winter Veil Socks
        [218308] = true, -- Winter Veil Cracker
        [218310] = true, -- Box of Puntables
        [243304] = true, -- Jubilant Snowman Costume
        [245580] = true, -- Rolling Snowball
    },
}

ADDON.db.profession = {
    ["Jewelcrafting"] = {
        [115503] = true, -- Blazing Diamond Pendant
        [130251] = true, -- JewelCraft
        [130254] = true, -- Chatterstone
        [193032] = true, -- Jeweled Offering
        [193033] = true, -- Convergent Prism
        [205045] = true, -- B.B.F, Fist
        [215145] = true, -- Remembrance Stone
        [215147] = true, -- Beautification Iris
    },

    ["Engineering"] = {
        [17716] = true, -- Snowmaster 9000
        [18660] = true, -- World Enlarger
        [18984] = true, -- Dimensional Ripper - Everlook
        [18986] = true, -- Ultrasafe Transporter: Gadgetzan
        [23767] = true, -- Crashin' Thrashin' Robot
        [30542] = true, -- Dimensional Ripper - Area 52
        [30544] = true, -- Ultrasafe Transporter: Toshley's Station
        [40727] = true, -- Gnomish Gravity Well
        [40768] = true, -- MOLL-E
        [40895] = true, -- Gnomish X-Ray Specs
        [48933] = true, -- Wormhole Generator: Northrend
        [60854] = true, -- Loot-A-Rang
        [87214] = true, -- Blingtron 4000
        [87215] = true, -- Wormhole Generator: Pandaria
        [108745] = true, -- Personal Hologram
        [109167] = true, -- Findle's Loot-A-Rang
        [109183] = true, -- World Shrinker
        [111821] = true, -- Blingtron 5000
        [112059] = true, -- Wormhole Centrifuge
        [132518] = true, -- Blingtron's Circuit Design Tutorial
        [151652] = true, -- Wormhole Generator: Argus
        [168667] = true, -- Blingtron 7000
        [168807] = true, -- Wormhole Generator: Kul Tiras
        [168808] = true, -- Wormhole Generator: Zandalar
        [172924] = true, -- Wormhole Generator: Shadowlands
        [192443] = true, -- Element-Infused Rocket Helmet
        [192495] = true, -- Malfunctioning Stealthman 54
        [198156] = true, -- Wyrmhole Generator
        [198173] = true, -- Atomic Recalibrator
        [198206] = true, -- Environmental Emulator
        [198227] = true, -- Giggle Goggles
        [198264] = true, -- Centralized Precipitation Emitter
        [199554] = true, -- S.E.A.T.
        [201930] = true, -- H.E.L.P.
        [202309] = true, -- Defective Doomsday Device
        [202360] = true, -- Dented Can
        [204818] = true, -- Mallard Mortar
        [207092] = true, -- Portable Party Platter
        [219387] = true, -- Barrel of Fireworks
        [219403] = true, -- Stonebound Lantern
        [221962] = true, -- Defective Escape Pod
        [221964] = true, -- Filmless Camera
        [221966] = true, -- Wormhole Generator: Khaz Algar
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
        [64488] = true, -- The Innkeeper's Daughter
        [89614] = true, -- Anatomical Dummy
        [131724] = true, -- Crystalline Eye of Undravius
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
        [186686] = true, -- Pallid Oracle Bones
        [186985] = true, -- Elisive Pet Treat
        [186702] = true, -- Pallid Bone Flute
        [193476] = true, -- Gnoll Tent
        [193478] = true, -- Tuskarr Beanbag
        [197719] = true, -- Artisan's Sign
    },

    ["Enchanting"] = {
        [128536] = true, -- Leylight Brazier
        [186973] = true, -- Anima-ted Leash
        [200469] = true, -- Khadgar's Disenchanting Rod
        [200636] = true, -- Primal Invocation Quintessence
    },

    ["Inscription"] = {
        [129211] = true, -- Steamy Romance Novel Kit
    },

    ["Tailoring"] = {
        [194052] = true, -- Forlorn Funeral Pall
        [194056] = true, -- Duck-Stuffed Duck Lovie
        [194057] = true, -- Cushion of Time Travel
        [194058] = true, -- Cold Cushion
        [194059] = true, -- Market Tent
        [194060] = true, -- Dragonscale Expedition's Expedition Tent
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
        [182732] = true, -- The Necronom-i-nom
        [182780] = true, -- Muckpool Cookpot
        [183986] = true, -- Bondable Sinstone
        [183988] = true, -- Bondable Val'kyr Diadem
        [184075] = true, -- Stonewrought Sentry
        [184318] = true, -- Battlecry of Krexus
        [184415] = true, -- Soothing Vesper -- Skyward Bell
        [184418] = true, -- Acrobatic Steward -- Gilded Chest
        [184447] = true, -- Kevin's Party Supplies
        [184489] = true, -- Fae Harp
        [184490] = true, -- Fae Pipes
        [187051] = true, -- Forgotten Feather
        [187113] = true, -- Personal Ball and Chain
        [187140] = true, -- Ring of Duplicity
        [187154] = true, -- Ancient Korthian Runes
        [187155] = true, -- Guise of the Changeling
        [187159] = true, -- Shadow Slicing Shortsword
        [187339] = true, -- Silver Shardhide Whistle
        [187344] = true, -- Offering Kit Maker
        [187416] = true, -- Jailer's Cage
        [187705] = true, -- Choofa's Call
        [190196] = true, -- Enlightened Hearthstone
        [190457] = true, -- Protopological Cube
        [190853] = true, -- Bushel of Mysterious Fruit
        [190926] = true, -- Infested Automa Core
        [192485] = true, -- Stored Wisdom Device

        -- Dragonflight
        [200869] = true, -- Ohn Lite Branded Horn
        [200878] = true, -- Wheeled Floaty Boaty Controller
        [201927] = true, -- Gleaming Arcanocrystal
        [202019] = true, -- Golden Dragon Goblet
        [202022] = true, -- Yennu's Kite
        [202711] = true, -- Lost Compass
        [204405] = true, -- Stuffed Bear
        [205418] = true, -- Blazing Shadowflame Cinder
        [210411] = true, -- Fast Growing Seed

        -- War Within
        [224552] = true, -- Cave Spelunker's Torch
        [224554] = true, -- Silver Linin' Scepter
        [224585] = true, -- Hanna's Locket
        [224783] = true, -- Sovereign's Finery Chest
        [225347] = true, -- Web-Vandal's Spinning Wheel
        [225556] = true, -- Ancient Construct
        [225641] = true, -- Illusive Kobyss Lure
        [225659] = true, -- Arathi Book Collection
        [234951] = true, -- Uncracked Cold Ones
        [245970] = true, -- P.O.S.T. Master's Express Hearthstone

        -- Midnight
        [250319] = true, -- Researcher's Shadowgraft
        [252265] = true, -- Hexed Potatoad Mucus
        [258963] = true, -- Shroom Jumper's Parachute
        [259084] = true, -- Gift of the Cycle
        [264805] = true, -- Brann-O-Vision 3000
        [267139] = true, -- Hungry Black Hole

    },

    ["Drop"] = {
        [1973] = true, -- Orb of Deception
        [32782] = true, -- Time-Lost Figurine
        [37254] = true, -- Super Simian Sphere
        [38506] = true, -- Don Carlos' Famous Hat

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
        [183901] = true, -- Bonestorm Top
        [184292] = true, -- Ancient Elethium Coin
        [184312] = true, -- Borr-Geth's Fiery Brimstone
        [184396] = true, -- Malfunctioning Goliath Gauntlet -- Ascended Supplies
        [184404] = true, -- Ever-Abundant Hearth
        [184413] = true, -- Mnemonic Attunement Pane
        [184435] = true, -- Mark of Purity -- Ascended Supplies
        [184476] = true, -- Regenerating Slime Vial
        [184495] = true, -- Infested Arachnid Casing -- Supplies of the Undying Army
        [187075] = true, -- Box of Rattling Chains
        [187139] = true, -- Bottled Shade Heart
        [187174] = true, -- Shaded Judgement Stone
        [187176] = true, -- Vesper of Harmony
        [187185] = true, -- Vesper of Faith
        [187417] = true, -- Adamant Vaults Cell
        [187420] = true, -- Maw-Ocular Viewfinder
        [190177] = true, -- Sphere of Enlightened Cogitation -- Enlightened Broker Supplies
        [190238] = true, -- Xy'rath's Booby-Trapped Cache -- Xy'rath the Covetous
        [190734] = true, -- Makaris's Satchel of Mines

        -- Dragonflight
        [198409] = true, -- Personal Shell
        [200116] = true, -- Everlasting Horn of Lavaswimming
        [200148] = true, -- A Collection Of Me
        [200160] = true, -- Notfar's Favorite Food
        [200178] = true, -- Infected Ichor
        [200198] = true, -- Primalist Prison
        [200249] = true, -- Mage's Chewed Wand
        [200857] = true, -- Talisman of Sargha
        [200999] = true, -- The Super Shellkhan Gang
        [201933] = true, -- Black Dragon's Challenge Dummy
        [205419] = true, -- Jrumm's Drum
        [205796] = true, -- Molten Lava Pack
        [206043] = true, -- Fyrakk's Frenzy
        [206993] = true, -- Investi-gator's Pocketwatch
        [205463] = true, -- Molten Lava Ball
        [210725] = true, -- Owl Post

        -- War Within
        [226810] = true, -- Infiltrator's Shroud
        [230727] = true, -- Explosive Victory
        [235017] = true, -- Glittering Vaulöt Shard
        [242323] = true, -- Chowdar's Favorite Ribbon
    },

    ["Quest"] = {
        [30690] = true, -- Power Converter
        [53057] = true, -- Faded Wizard Hat
        [123851] = true, -- Photo B.O.M.B. -- Blingtron-5000

        -- Molten Front
        [71259] = true, -- Leyara's Locket

        -- Pandaria
        [80822] = true, -- The Golden Banana
        [82467] = true, -- Ruthers' Harness
        [88370] = true, -- Puntable Marmot
        [88375] = true, -- Turnip Punching Bag
        [88377] = true, -- Turnip Paint "Gun"
        [88381] = true, -- Silversage Incense
        [88385] = true, -- Hozen Idol
        [88387] = true, -- Shushen's Spittoon
        [88417] = true, -- Gokk'lok's Shell
        [88531] = true, -- Lao Chin's Last Mug
        [88579] = true, -- Jin Warmkeg's Brew
        [88580] = true, -- Ken-Ken's Mask
        [88584] = true, -- Totem of Harmony
        [88589] = true, -- Cremating Torch
        [95567] = true, -- Kirin Tor Beacon -- Alliance
        [95568] = true, -- Sunreaver Beacon -- Horde

        -- Draenor
        [110560] = true, -- Garrison Hearthstone
        [115506] = true, -- Treessassin's Guise
        [118935] = true, -- Ever-Blooming Frond
        [119001] = true, -- Mystery Keg
        [119093] = true, -- Aviana's Feather
        [119134] = true, -- Sargerei Disguise
        [119144] = true, -- Touch of the Naaru
        [119145] = true, -- Firefury Totem

        -- Legion
        [129093] = true, -- Ravenbear Disguise
        [130209] = true, -- Never Ending Toy Chest
        [131717] = true, -- Starlight Beacon
        [131933] = true, -- Critter Hand Cannon
        [138111] = true, -- Stormforged Grapple Launcher
        [133997] = true, -- Black Ice
        [133998] = true, -- Rainbow Generator
        [134021] = true, -- X-52 Rocket Helmet
        [138873] = true, -- Mystical Frosh Hat
        [138876] = true, -- Runas' Crystal Grinder
        [138878] = true, -- Copy of Daglop's Contract
        [140192] = true, -- Dalaran Hearthstone
        [141605] = true, -- Flight Master's Whistle
        [141879] = true, -- Berglrgl Perrgl Girggrlf
        [142494] = true, -- Purple Blossom
        [142495] = true, -- Fake Teeth
        [142496] = true, -- Dirty Spoon
        [142497] = true, -- Tiny Pack
        [143727] = true, -- Champion's Salute -- class hall quest
        [147838] = true, -- Akazamzarak's Spare Hat -- mage class quest

        -- Battle for Azeroth
        [156871] = true, -- Spitzy
        [160509] = true, -- Echoes of Rezan -- WQ
        [163607] = true, -- Lucille's Sewing Needle
        [165791] = true, -- Worn Cloak
        [166544] = true, -- Dark Ranger's Spare Cowl
        [166678] = true, -- Brynja's Beacon
        [168123] = true, -- Twitching Eyeball
        [169768] = true, -- Heart of a Champion
        [169796] = true, -- Azeroth Mini Collection: Mechagon
        [170154] = true, -- Book of the Unshackled
        [170155] = true, -- Carved Ankoan Charm
        [173727] = true, -- Nomi's Vintage
        [173951] = true, -- N'lyeth, Sliver of N'Zoth
        [175063] = true, -- Aqir Egg Cluster

        -- Shadowlands
        [177951] = true, -- Glimmerflies on Strings
        [180947] = true, -- Tithe Collector's Vessel
        [183847] = true, -- Acolyte's Guise
        [183856] = true, -- Mystical Orb of Meditation
        [184487] = true, -- Gormling in a Bag
        [187184] = true, -- Vesper of Clarity
        [187419] = true, -- Steward's First Feather
        [187512] = true, -- Tome of Small Sins
        [187840] = true, -- Sparkle Wings
        [187913] = true, -- Apprentice Slimemancer's Boots
        [190754] = true, -- Firim's Specimen Container

        -- Dragonflight
        [191891] = true, -- Professor Chirpsnide's Im-PECK-able Harpy Disguise
        [198039] = true, -- Rock of Appreciation
        [198090] = true, -- Jar of Excess Slime
        [198474] = true, -- Artist's Easel
        [198537] = true, -- Taivan's Trumpet
        [198857] = true, -- Lucky Duck
        [199830] = true, -- Tuskarr Training Dummy
        [200597] = true, -- Lover's Bouquet
        [200628] = true, -- Somewhat-Stabilized Arcana
        [200926] = true, -- Compendium of Love
        [200960] = true, -- Seed of Renewed Souls
        [201815] = true, -- Cloak of Many Faces
        [203725] = true, -- Display of Strength
        [204170] = true, -- Clan Banner
        [204220] = true, -- Hraxian's Unbreakable Will
        [204389] = true, -- Stonebreaker
        [204686] = true, -- Titan's Containment Device
        [205688] = true, -- Glutinous Glitterscale Glob
        [205908] = true, -- Inherited Wisdom of Senegos
        [208415] = true, -- Stasis Sand
        [208658] = true, -- Mirror of Humility
        [210864] = true, -- Improvised Leafbed
        [208798] = true, -- Recorded Memories of Tyr's Guard
        [210455] = true, -- Draenic Hologem
        [211788] = true, -- Tess's Peacebloom
        [223146] = true, -- Satchel of Stormborn Seeds

        -- War Within
        [225547] = true, -- Toxic Victory
        [228966] = true, -- Starry-Eyed Goggles
        [233202] = true, -- G.O.L.E.M, Jr.
        [235041] = true, -- Cyrce's Circlet
        [239007] = true, -- Dastardly Banner
        [239018] = true, -- Winner's Podium
        [244888] = true, -- Echo of the Xal'atath, Blade of the Black Empire
        [245631] = true, -- Royal Visage
        [245567] = true, -- K'aresh Memory Crystal
        [244470] = true, -- Etheric Victory
        [249713] = true, -- Cartel Transmorpher
        [242520] = true, -- Festival Hot Air Balloon

        -- Midnight
        [243146] = true, -- Ren'dorei Struggle
        [253629] = true, -- Personal Key to the Arcantina
        [257736] = true, -- Lightcalled Hearthstone
        [263198] = true, -- Valdekar's Special
        [263871] = true, -- Holy Pet Leash
        [264413] = true, -- Dominating Victory
        [267456] = true, -- Lil' Scoots' Pillow

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

        -- Heirloom Vendor
        [150743] = true, -- Scouting Map: Surviving Kalimdor
        [150744] = true, -- Scouting Map: Walking Kalimdor with the Earthmother
        [150745] = true, -- Scouting Map: The Eastern Kingdoms Campaign
        [150746] = true, -- Scouting Map: Modern Provisioning of the Eastern Kingdoms
        [187869] = true, -- Scouting Map: Into the Shadowlands
        [187875] = true, -- Scouting Map: United Fronts of the Broken Isles
        [187895] = true, -- Scouting Map: The Dangers of Draenor
        [187896] = true, -- Scouting Map: A Stormstout's Guide to Pandaria
        [187897] = true, -- Scouting Map: Cataclysm's Consequences
        [187898] = true, -- Scouting Map: True Cost of the Northrend Campaign
        [187899] = true, -- Scouting Map: The Many Curiosities of Outland
        [187900] = true, -- Scouting Map: The Wonders of Kul Tiras and Zandalar

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

        -- MoP classic
        [265786] = true, -- Demon Hunter's Aspect
        [266999] = true, -- Swift Yak Pelt

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
        [183876] = true, -- Quill of Correspondence
        [183989] = true, -- Dredger Barrow Racer
        [186974] = true, -- Experimental Anima Cell
        [190333] = true, -- Jiro Circle of Song
        [192099] = true, -- Earpieces of Tranquil Focus

        -- Dragonflight
        [198646] = true, -- Ornate Dragon Statue
        [199900] = true, -- Secondhand Survey Tools
        [199337] = true, -- Bag of Furious Winds
        [200707] = true, -- Armoire of Endless Cloaks
        [201435] = true, -- Shuffling Sands
        [202020] = true, -- Chasing Storm
        [202021] = true, -- Breaker's Flag of Victory
        [202042] = true, -- Aquatic Shades
        [205936] = true, -- New Niffen No-Sniffen' Tonic
        [205963] = true, -- Sniffin' Salts
        [206195] = true, -- Path of the Naaru
        [209858] = true, -- Dreamsurge Remnant
        [209944] = true, -- Friendsurge Defenders
        [212518] = true, -- Vial of Endless Draconic Scales

        -- War Within
        [211931] = true, -- Abyss Caller Horn
        [223312] = true, -- Trusty Hat
        [224643] = true, -- Pet-Sized Candle
        [225910] = true, -- Pileus Delight
        [226191] = true, -- Web Pet Leash
        [226519] = true, -- General's Expertise
        [228413] = true, -- Lampyridae Caller
        [228698] = true, -- Candleflexer's Dumbbell
        [228705] = true, -- Arachnoserum
        [228706] = true, -- Rockslidomancer's Stone
        [228707] = true, -- Trial of Burning Light
        [228914] = true, -- Arachnophile Spectacles
        [228940] = true, -- Notorious Thread's Hearthstone
        [230850] = true, -- Delve-O-Bot 7001
        [230924] = true, -- Spotlight Materializer 1000
        [231064] = true, -- Throwaway Gangster Disguise
        [233486] = true, -- Hallowfall Supply Cache
        [234473] = true, -- Soweezi's Comfy Lawn Chair
        [235015] = true, -- Awakened Supply Crate
        [235016] = true, -- Redeployment Module
        [237345] = true, -- Limited Edition Rocket Bobber
        [237346] = true, -- Artisan Beverage Goblet Bobber
        [237347] = true, -- Organically-Sourced Wellington Bobber
        [237382] = true, -- Undermine Supply Crate
        [243056] = true, -- Delver's Mana-Bound Ethergate
        [244792] = true, -- Etheric Brannmorpher
        [246903] = true, -- Guise of the Phase Diver
        [246905] = true, -- Overtuned K'areshi Goggles
        [246907] = true, -- Broker Supply Crate
        [246908] = true, -- K'areshi Supply Crate
        [250722] = true, -- Ethereal Stall

        -- Midnight
        [250974] = true, -- Akil'zon's Updraft
        [249468] = true, -- Twilight's Blade Top Secret Strategy Training Guide
        [251633] = true, -- Bursting Bounty Bundle
        [256552] = true, -- Verdant Rutaani Seed
        [259240] = true, -- Sin'dorei Wine
        [262431] = true, -- Bouncy Mushroom
        [263244] = true, -- Enigmatic Fountain
        [263933] = true, -- Astalor's Summons
        [264414] = true, -- Midnight Delver's Flare Gun
        [264517] = true, -- Galactic Flag of Victory
        [265100] = true, -- Corewarden's Hearthstone
        [266370] = true, -- Dundun's Abundant Travel Method
        [267291] = true, -- Coffer Key Glue

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
        [203757] = true, -- Brazier of Madness -- Zul'Gurub
        [203852] = true, -- Spore-Bound Essence -- Zserka Vaults
        [204256] = true, -- Holoviewer: The Scarlet Queen -- Zserka Vaults
        [204257] = true, -- Holoviewer: The Lady of Dreams -- Zserka Vaults
        [204262] = true, -- Holoviewer: The Timeless One -- Zserka Vaults
        [204687] = true, -- Obsidian Battle Horn -- Zserka Vaults
        [206565] = true, -- Plagued Grain -- Naxxramas
        [208096] = true, -- Familiar Journal -- Naxxramas
        [209035] = true, -- Hearthstone of the Flame -- Amidrassil
        [232301] = true, -- Tempered Banner of the Algari -- MDI - War Within Season 1
        [236687] = true, -- Explosive Hearthstone -- Liberation of Undermine
        [232302] = true, -- Prized Banner of the Algari -- MDI War Within S2
        [232303] = true, -- Unbound Banner of the Algari -- MDI War Within S3
        [246565] = true, -- Cosmic Hearthstone
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
        [180290] = true, -- Night Fae Hearthstone
        [183716] = true, -- Venthyr Sinstone
        [182773] = true, -- Necrolord Hearthstone
        [184353] = true, -- Kyrian Hearthstone
        [190237] = true, -- Broker Translocation Matrix

        -- Dragonflight Renown
        [194885] = true, -- Ohuna Perch
        [198402] = true, -- Maruuk Cooking Pot
        [198720] = true, -- Soft Purple Pillow
        [198721] = true, -- Skinny Reliquary Pillow
        [198722] = true, -- Small Triangular Pillow
        [198728] = true, -- Explorer's League Banner
        [198729] = true, -- Reliquary Banner
        [198827] = true, -- Magical Snow Sled
        [199649] = true, -- Dragon Tea Set
        [199650] = true, -- Whale Bone Tea Set
        [199767] = true, -- Red Dragon Banner
        [199768] = true, -- Black Dragon Banner
        [199769] = true, -- Blue Dragon Banner
        [199770] = true, -- Bronze Dragon Banner
        [199771] = true, -- Green Dragon Banner
        [199892] = true, -- Tuskarr Traveling Soup Pot
        [199894] = true, -- Fisherman's Folly
        [199896] = true, -- Rubbery Fish Head
        [199897] = true, -- Blue-Covered Beanbag
        [199899] = true, -- Iskaara Tug Sled
        [199902] = true, -- Wayfinder's Compass
        [200550] = true, -- Very Comfortable Pelt
        [200551] = true, -- Comfortable Pile of Pelts
        [200640] = true, -- Obsidian Egg Clutch
        [202253] = true, -- Primal Stave of Claw and Fur
        [202283] = true, -- Reading Glasses
        [203734] = true, -- Snow Blanket
        [205255] = true, -- Niffen Diggin' Mitts
        [208058] = true, -- Minute Glass

        -- War within Renown
        [226373] = true, -- Everlasting Noggenfogger Elixir
        [228698] = true, -- Candleflexer's Dumbbell
        [228707] = true, -- Trial of Burning Light
        [228940] = true, -- Notorious Thread's Hearthstone
        [234950] = true, -- Atomic Regoblinator
        [235669] = true, -- Steamwheedle Cartel Banner
        [235670] = true, -- Bilgewater Cartel Banner
        [235671] = true, -- Blackwater Cartel Banner
        [235672] = true, -- Venture Co. Banner
        [235799] = true, -- Throwin' Sawblade
        [235801] = true, -- Personal Fishing Barge
        [235807] = true, -- Storefront-in-a-Box
        [236749] = true, -- Take-Home Torq
        [236751] = true, -- Take-Home Flarendo
        [238850] = true, -- Arathi Entertainer's Flame
        [238852] = true, -- Flame's Radiance Banner
        [239693] = true, -- Radiant Lynx Whistle

        -- Midnight
        [256552] = true, -- Verdant Rutaani Seed
        [259240] = true, -- Sin'dorei Wine
        [263244] = true, -- Enigmatic Fountain
        [263933] = true, -- Astalor's Summons
        [264517] = true, -- Galactic Flag of Victory

    },

    ["Achievement"] = {
        [43824] = true, -- The Schools of Arcane Magic - Mastery
        [44430] = true, -- Titanium Seal of Dalaran
        [87528] = true, -- Honorary Brewmaster Keg
        [92738] = true, -- Safari Hat
        [116115] = true, -- Blazing Wings
        [119215] = true, -- Robo-Gnomebulator
        [122293] = true, -- Trans-Dimensional Bird Whistle

        -- MoP Classic
        [265774] = true, -- Platinum Boots of Expeditious Retreat
        [265780] = true, -- Platinum "Little Ale"
        [265418] = true, -- Platinum Rod of Ambershaping
        [265419] = true, -- Platinum Potion of Invisibility
        [265414] = true, -- Platinum Amber
        [265417] = true, -- Platinum Battle Horn
        [265415] = true, -- Platinum Vial of Polyformic Acid
        [265416] = true, -- Platinum Battle Banner
        [265573] = true, -- Platinum Sacrificial Dagger

        -- Legion
        [139773] = true, -- Emerald Winds
        [143660] = true, -- Mrgrglhjorn
        [156833] = true, -- Katy's Stampwhistle

        -- Battle for Azeroth
        [163697] = true, -- Laser Pointer
        [166247] = true, -- Citizens Brigade Whistle
        [167698] = true, -- Secret Fish Goggles
        [168016] = true, -- Hyper-Compressed Ocean
        [174830] = true, -- Shadowy Disguise
        [174871] = true, -- Mayhem Mind Melder

        -- Shadowlands
        [182695] = true, -- Weathered Purple Parasol
        [184223] = true, -- Helm of the Dominated
        [184449] = true, -- Jiggles's Favorite Toy
        [184508] = true, -- Mawsworn Pet Leash
        [183903] = true, -- Smelly Jelly
        [187689] = true, -- Dance Dance Darkmoon
        [187793] = true, -- Personal Containment Trap
        [187860] = true, -- Mortis Mover
        [188952] = true, -- Dominated Hearthstone

        -- Dragonflight
        [197961] = true, -- Whelps on Strings
        [197986] = true, -- Murglasses
        [198428] = true, -- Tuskarr Dinghy
        [200630] = true, -- Ohn'ir Windsage's Hearthstone
        [200631] = true, -- Happy Tuskarr Palooza
        [202207] = true, -- Reusable Oversized Bobber
        [205904] = true, -- Vibrant Clacking Claw
        [207099] = true, -- Tiny Box of Tiny Rocks
        [208186] = true, -- Boffins
        [208421] = true, -- Compendium of the New Moon
        [208433] = true, -- Bronze Racer's Pennant
        [211946] = true, -- Hearthstone Game Table

        -- War Within
        [224251] = true, -- Memory Chord
        [225933] = true, -- Forged Legend's Pennant
        [227538] = true, -- Unbound Legend's Pennant
        [227539] = true, -- Unbound Strategist's Pennant
        [235050] = true, -- Desk-in-a-Box
        [235220] = true, -- Fireworks Hat
        [235519] = true, -- Prized Legend's Pennant
        [236769] = true, -- Gallagio Pipeline Rerouter

        -- Midnight
        [251491] = true, -- Magical Pet Clicker
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
        [225933] = true, -- Forged Legend's Pennant
        [225969] = true, -- Forged Flag of Victory
        [227538] = true, -- Unbound Legend's Pennant
        [227539] = true, -- Unbound Strategist's Pennant
        [232305] = true, -- Forged Champion's Prestigious Banner -- AWC War Within S1
        [235519] = true, -- Prized Legend's Pennant
        [232306] = true, -- Prized Champion's Prestigious Banner -- AWC War Within S2
        [232307] = true, -- Astral Champion's Prestigious Banner -- AWC War Within S3
        [242636] = true, -- Astral Legend's Pennant
        [264517] = true, -- Galactic Flag of Victory
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
        [140632] = true, -- Lava Fountain
    },

    ["Pick Pocket"] = {
        [36862] = true, -- Worn Troll Dice
        [36863] = true, -- Decahedral Dwarven Dice
        [63269] = true, -- Loaded Gnomish Dice
        [120857] = true, -- Barrel of Bandanas
        [151877] = true, -- Barrel of Eyepatches
    },

    ["Black Market"] = {
        [32566] = true, -- Picnic Basket
        [33219] = true, -- Goblin Gumbo Kettle
        [33223] = true, -- Fishing Chair
        [34499] = true, -- Paper Flying Machine Kit
        [35227] = true, -- Goblin Weather Machine - Prototype 01-B
        [38578] = true, -- The Flag of Ownership
        [45063] = true, -- Foam Sword Rack
        [46780] = true, -- Ogre Pinata
    },

    ["Trading Post"] = {
        [32542] = true, -- Imp in a Ball
        [206268] = true, -- Ethereal Transmogrifier
        [206347] = true, -- Mannequin Charm
        [212500] = true, -- Delicate Silk Parasol
        [212523] = true, -- Delicate Jade Parasol
        [212524] = true, -- Delicate Crimson Parasol
        [212525] = true, -- Delicate Ebony Parasol
        [218112] = true, -- Colorful Beach Chair
        [220692] = true, -- X-treme Water Blaster Display
    },

    ["Shop"] = {
        [38233] = true, -- Path of Illidan - TBC classic Deluxe Edition
        [112324] = true, -- Nightmarish Hitching Post
        [166777] = true, -- Lion's Pride Firework
        [166778] = true, -- Horde's Might Firework
        [166779] = true, -- Transmorpher Beacon
        [184871] = true, -- Dark Portal - TBC classic Deluxe Edition
        [198647] = true, -- Fishspeaker's Lucky Lure - WotLK classic Epic Edition
        [210467] = true, -- Magical Murkmorpher
        [247893] = true, -- Fandral's Eternal Seed
        [248263] = true, -- Azure Sea Boat -- mop classic (chinese?)
        [255973] = true, -- Sandbox Horse
        [256141] = true, -- Fortune's Waving Cat
        [258840] = true, -- Gilded Fountain
    },

    ["Promotion"] = {
        [158149] = true, -- Overtuned Corgi Goggles
        [172179] = true, -- Eternal Traveler's Hearthstone - Shadowlands Epic Edition
        [186501] = true, -- Doomwalker Trophy Stand
        [193588] = true, -- Timewalker's Hearthstone - Dragonflight Epic Edition
        [208704] = true, -- Deepdweller's Earthen Hearthstone - War Within Epic Edition
        [208883] = true, -- Sandbox Storm Gryphon - War Within Epic Edition
        [216893] = true, -- Goblin Town-in-a-Box -- Cata Classic Epic Edition
        [235288] = true, -- Sha-Warped Tea Set -- MoP Classic Heroic Pack
        [235464] = true, -- Sha-Touched Tea Set -- MoP Classic Heroic Pack (classic)
        [254666] = true, -- Exodar Replica -- TBC Classic
        [260221] = true, -- Naaru's Embrace -- TBC Classic
        [260622] = true, -- Exodar Replica -- TBC Classic
        [263489] = true, -- Naaru's Enfold -- TBC Classic
        [258129] = true, -- Jade Monument
        [258135] = true, -- Gilded Coil Spire
        [258136] = true, -- Azure Thunder Coil Spire

        -- Trading Card Game
        [32542] = true, -- Imp in a Ball
        [32566] = true, -- Picnic Basket
        [33219] = true, -- Goblin Gumbo Kettle
        [33223] = true, -- Fishing Chair
        [34499] = true, -- Paper Flying Machine Kit
        [35227] = true, -- Goblin Weather Machine - Prototype 01-B
        [38301] = true, -- D.I.S.C.O.
        [38578] = true, -- The Flag of Ownership
        [45047] = true, -- Sandbox Tiger
        [45063] = true, -- Foam Sword Rack
        [46779] = true, -- Path of Cenarius
        [46780] = true, -- Ogre Pinata
        [49703] = true, -- Perpetual Purple Firework
        [49704] = true, -- Carved Ogre Idol
        [54212] = true, -- Instant Statue Pedestal
        [54452] = true, -- Ethereal Portal
        [67097] = true, -- Grim Campfire
        [69215] = true, -- War Party Hitching Post
        [69227] = true, -- Fool's Gold
        [71628] = true, -- Sack of Starfish
        [72159] = true, -- Magical Ogre Idol
        [72161] = true, -- Spurious Sarcophagus
        [79769] = true, -- Demon Hunter's Aspect
        [93672] = true, -- Dark Portal

        -- Warcraft Rumble
        [201931] = true, -- Warcraft Rumble Toy: Maiev
        [202261] = true, -- Warcraft Rumble Toy: Sneed
        [202851] = true, -- Warcraft Rumble Toy: Night Elf Huntress
        [202856] = true, -- Warcraft Rumble Toy: Stonehoof Tauren
        [202859] = true, -- Warcraft Rumble Toy: Undead Ghoul
        [202862] = true, -- Warcraft Rumble Toy: Murloc
        [202865] = true, -- Warcraft Rumble Toy: Whelp Egg
    },

    ["Unavailable"] = {
        -- from: https://warcraft-secrets.com/guides/hidden-toys#Legacy_Toys
        -- and: https://www.dataforazeroth.com/collections/toys (Advanced->Unobtainable)

        [33079] = true, -- Murloc Costume -- BlizzCon 2007
        [54651] = true, -- Gnomeregan Pride
        [54653] = true, -- Darkspear Pride
        [89205] = true, -- Mini Mana Bomb
        [142542] = true, -- Tome of Town Portal
        [143543] = true, -- Twelve-String Guitar
        [163986] = true, -- Orgrimmar Hero's War Banner --Blizzcon 2018
        [163987] = true, -- Stormwind Champion's War Banner  --Blizzcon 2018
        [170197] = true, -- Swarthy Warning Sign
        [187834] = true, -- Tormented Banner of the Opportune
        [187957] = true, -- Encrypted Banner of the Opportune
        [187958] = true, -- Shrouded Banner of the Opportune
        [203716] = true, -- Thundering Banner of the Aspects
        [206008] = true, -- Nightmare Banner
        [206267] = true, -- Obsidian Legend's Pennant
        [206343] = true, -- Crimson Legend's Pennant
        [208057] = true, -- Smoldering Banner of the Aspects
        [210042] = true, -- Chilling Celebration Banner
        [217723] = true, -- Fury of Xuen
        [217724] = true, -- Kindness of Chi-ji
        [217725] = true, -- Essence of Yu'lon
        [217726] = true, -- Fortitude of Niuzao
        [220777] = true, -- Cherry Blossom Trail
        [210497] = true, -- Verdant Legend's Pennant
        [211424] = true, -- Dreaming Banner of the Aspects
        [211869] = true, -- Draconic Legend's Pennant
        [212337] = true, -- Stone of the Hearth
        [218128] = true, -- Draconic Banner of the Aspects
    },
}

if isClassic then
    ADDON.db.source["Trading Post"] = {}
end

ADDON.db.expansion = {
    [0] = { -- Classic
        ["minID"] = 0,
        ["maxID"] = 23700,
    },
    [1] = { -- The Burning Crusade
        ["minID"] = 23767,
        ["maxID"] = 36861,
        [37710] = true, -- Crashin' Thrashin' Racer Controller
        [38233] = true, -- Path of Illidan
        [38301] = true, -- D.I.S.C.O.
        [38506] = true, -- Don Carlos' Famous Hat
        [38578] = true, -- The Flag of Ownership
        [184871] = true, -- Dark Portal
    },
    [2] = { -- Wrath of the Lich King
        ["minID"] = 36862,
        ["maxID"] = 54653,
        [198647] = true, -- Fishspeaker's Lucky Lure
    },
    [3] = { -- Cataclysm
        ["minID"] = 54654,
        ["maxID"] = 79999,
        [40727] = true, -- Gnomish Gravity Well
        [46709] = true, -- MiniZep Controller
        [53057] = true, -- Faded Wizard Hat
        [216893] = true, -- Goblin Town-in-a-Box (Cata Classic)
    },
    [4] = { -- Mists of Pandaria
        ["minID"] = 80000,
        ["maxID"] = 107999,
        [235288] = true, -- Sha-Warped Tea Set
        [235464] = true, -- Sha-Touched Tea Set (MoP Classic)
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
        ["maxID"] = 190926,
        [172179] = true, -- Eternal Traveler's Hearthstone
        [172924] = true, -- Wormhole Generator: Shadowlands
        [173984] = true, -- Scroll of Aeons
        [174445] = true, -- Glimmerfly Cocoon
        [192099] = true, -- Earpieces of Tranquil Focus
        [192485] = true, -- Stored Wisdom Device
    },
    [9] = { -- Dragonflight
        ["minID"] = 191891,
        ["maxID"] = 218300,
        [220692] = true, -- X-treme Water Blaster Display
        [220777] = true, -- Cherry Blossom Trail
        [223146] = true, -- Satchel of Stormborn Seeds
    },
    [10] = { -- War Within
        ["minID"] = 218310,
        ["maxID"] = 258962,
        [208704] = true, -- Deepdweller's Earthen Hearthstone - War Within Epic Edition
        [208883] = true, -- Sandbox Storm Gryphon - War Within Epic Edition
        [211931] = true, -- Abyss Caller Horn
        [215145] = true, -- Remembrance Stone
        [215147] = true, -- Beautification Iris
        [263489] = true, -- Naaru's Enfold
    },
    [11] = { -- Midnight
        ["minID"] = 258963,
        ["maxID"] = 999999,
        [243146] = true, -- Ren'dorei Struggle
        [249468] = true, -- Twilight's Blade Top Secret Strategy Training Guide
        [250319] = true, -- Researcher's Shadowgraft
        [250320] = true, -- Lightgraft
        [250974] = true, -- Akil'zon's Updraft
        [251491] = true, -- Magical Pet Clicker
        [251633] = true, -- Bursting Bounty Bundle
        [251903] = true, -- Potatoad Egg
        [252265] = true, -- Hexed Potatoad Mucus
        [253629] = true, -- Personal Key to the Arcantina
        [256552] = true, -- Verdant Rutaani Seed
        [257736] = true, -- Lightcalled Hearthstone
    }
}

-- prevent not yet updated addons from accessing a future expansion
if ADDON.db.expansion[GetClientDisplayExpansionLevel()] then
    ADDON.db.expansion[GetClientDisplayExpansionLevel()]["maxID"] = 9999999
end

ADDON.db.effect = {

    ["Appearance"] = {

        -- Modify the entire character model, giving the player a new model
        ["Full"] = {
            [1973] = true, -- Orb of Deception
            [17712] = true, -- Winter Veil Disguise Kit
            [32782] = true, -- Time-Lost Figurine
            [33079] = true, -- Murloc Costume
            [35275] = true, -- Orb of the Sin'dorei
            [37254] = true, -- Super Simian Sphere
            [43499] = true, -- Iron Boot Flask
            [44719] = true, -- Frenzyheart Brew
            [49704] = true, -- Carved Ogre Idol
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
            [72159] = true, -- Magical Ogre Idol
            [79769] = true, -- Demon Hunter's Aspect
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
            [119211] = true, -- Golden Hearthstone Card: Lord Jaraxxus
            [119215] = true, -- Robo-Gnomebulator
            [119421] = true, -- Sha'tari Defender's Medallion
            [120276] = true, -- Outrider's Bridle Chain
            [122117] = true, -- Cursed Feather of Ikzan
            [122283] = true, -- Rukhmar's Sacred Memory
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
            [140160] = true, -- Stormforged Vrykul Horn
            [140780] = true, -- Fal'dorei Egg
            [141331] = true, -- Vial of Green Goo
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
            [170154] = true, -- Book of the Unshackled
            [170155] = true, -- Carved Ankoan Charm
            [174873] = true, -- Trans-mogu-rifier
            [183847] = true, -- Acolyte's Guise
            [183903] = true, -- Smelly Jelly
            [184223] = true, -- Helm of the Dominated
            [187139] = true, -- Bottled Shade Heart
            [187155] = true, -- Guise of the Changeling
            [190457] = true, -- Protopological Cube
            [191891] = true, -- Professor Chirpsnide's Im-PECK-able Harpy Disguise
            [200178] = true, -- Infected Ichor
            [200198] = true, -- Primalist Prison
            [200249] = true, -- Mage's Chewed Wand
            [200636] = true, -- Primal Invocation Quintessence
            [200857] = true, -- Talisman of Sargha
            [200960] = true, -- Seed of Renewed Souls
            [201815] = true, -- Cloak of Many Faces
            [202253] = true, -- Primal Stave of Claw and Fur
            [203852] = true, -- Spore-Bound Essence
            [205904] = true, -- Vibrant Clacking Claw
            [208421] = true, -- Compendium of the New Moon
            [208433] = true, -- Bronze Racer's Pennant
            [208658] = true, -- Mirror of Humility
            [210467] = true, -- Magical Murkmorpher
            [216881] = true, -- Duck Disguiser
            [224783] = true, -- Sovereign's Finery Chest
            [225641] = true, -- Illusive Kobyss Lure
            [225910] = true, -- Pileus Delight
            [226373] = true, -- Everlasting Noggenfogger Elixir
            [226810] = true, -- Infiltrator's Shroud
            [228705] = true, -- Arachnoserum
            [233202] = true, -- G.O.L.E.M, Jr.
            [234950] = true, -- Atomic Regoblinator
            [235017] = true, -- Glittering Vault Shard
            [245567] = true, -- K'aresh Memory Crystal
            [245631] = true, -- Royal Visage
            [245942] = true, -- Sea-Blessed Shrine
            [246227] = true, -- Lightning-Blessed Spire
            [244792] = true, -- Etheric Brannmorpher
            [249713] = true, -- Cartel Transmorpher
            [243304] = true, -- Jubilant Snowman Costume
            [247893] = true, -- Fandral's Eternal Seed -- chinese mop classic (?)
            [256881] = true, -- Steward's Bauble
            [256893] = true, -- Wretched Dredger's Brand
            [265786] = true, -- Demon Hunter's Aspect
            [252265] = true, -- Hexed Potatoad Mucus
            [256552] = true, -- Verdant Rutaani Seed
            
        },

        -- Add to or slightly change the existing character model, keeping the same model
        ["Minor"] = {
            [35227] = true, -- Goblin Weather Machine - Prototype 01-B
            [38233] = true, -- Path of Illidan
            [46779] = true, -- Path of Cenarius
            [64361] = true, -- Druid and Priest Statue Set
            [69895] = true, -- Green Balloon
            [69896] = true, -- Yellow Balloon
            [75042] = true, -- Flimsy Yellow Balloon
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
            [138873] = true, -- Mystical Frosh Hat
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
            [180947] = true, -- Tithe Collector's Vessel
            [187840] = true, -- Sparkle Wings
            [187913] = true, -- Apprentice Slimemancer's Boots
            [188701] = true, -- Fire Festival Batons
            [188699] = true, -- Insulated Dancing Insoles
            [190926] = true, -- Infested Automa Core
            [198857] = true, -- Lucky Duck
            [201927] = true, -- Gleaming Arcanocrystal
            [202022] = true, -- Yennu's Kite
            [202042] = true, -- Aquatic Shades
            [202283] = true, -- Reading Glasses
            [205418] = true, -- Blazing Shadowflame Cinder
            [205688] = true, -- Glutinous Glitterscale Glob
            [205963] = true, -- Sniffin' Salts
            [206696] = true, -- Tricked-Out Thinking Cap
            [207730] = true, -- Idol of Ohn'ahra
            [208092] = true, -- Torch of Pyrreth
            [209944] = true, -- Friendsurge Defenders
            [210656] = true, -- Winter Veil Socks
            [217723] = true, -- Fury of Xuen
            [217724] = true, -- Kindness of Chi-ji
            [217725] = true, -- Essence of Yu'lon
            [217726] = true, -- Fortitude of Niuzao
            [220777] = true, -- Cherry Blossom Trail
            [223146] = true, -- Satchel of Stormborn Seeds
            [221964] = true, -- Filmless Camera
            [224552] = true, -- Cave Spelunker's Torch
            [225547] = true, -- Toxic Victory
            [228413] = true, -- Lampyridae Caller
            [228789] = true, -- Coldflame Ring
            [229828] = true, -- 20th Anniversary Balloon Chest
            [230727] = true, -- Explosive Victory
            [231064] = true, -- Throwaway Gangster Disguise
            [233486] = true, -- Hallowfall Supply Cache
            [235015] = true, -- Awakened Supply Crate
            [235041] = true, -- Cyrce's Circlet
            [237382] = true, -- Undermine Supply Crate
            [242323] = true, -- Chowdar's Favorite Ribbon
            [244470] = true, -- Etheric Victory
            [245946] = true, -- Brewer's Balloon
            [246903] = true, -- Guise of the Phase Diver
            [246907] = true, -- Broker Supply Crate
            [246908] = true, -- K'areshi Supply Crate
            [250319] = true, -- Researcher's Shadowgraft
            
        },

        ["Bigger"] = {
            [69775] = true, -- Vrykul Drinking Horn
            [109183] = true, -- World Shrinker
        },

        ["Smaller"] = {
            [18660] = true, -- World Enlarger
            [97919] = true, -- Whole-Body Shrinka'
            [226373] = true, -- Everlasting Noggenfogger Elixir
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
            [206993] = true, -- Investi-gator's Pocketwatch
            [243146] = true, -- Ren'dorei Struggle
            
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
            [204170] = true, -- Clan Banner
            [206267] = true, -- Obsidian Legend's Pennant
            [206343] = true, -- Crimson Legend's Pennant
            [210497] = true, -- Verdant Legend's Pennant
            [211869] = true, -- Draconic Legend's Pennant
            [225933] = true, -- Forged Legend's Pennant
            [227538] = true, -- Unbound Legend's Pennant
            [227539] = true, -- Unbound Strategist's Pennant
            [235519] = true, -- Prized Legend's Pennant
            [242636] = true, -- Astral Legend's Pennant
        },
    },

    ["Cinematics"] = {
        [142536] = true, -- Memory Cube
        [208798] = true, -- Recorded Memories of Tyr's Guard
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
            [200869] = true, -- Ohn Lite Branded Horn
            [265780] = true, -- Platinum "Little Ale"
        },

        ["Food/Water"] = {
            [86578] = true, -- Eternal Warrior's Sigil
            [113540] = true, -- Ba'ruun's Bountiful Bloom
            [116120] = true, -- Tasty Talador Lunch
            [118935] = true, -- Ever-Blooming Frond
            [128223] = true, -- Bottomless Stygana Mushroom Brew
            [130151] = true, -- The "Devilsaur" Lunchbox
            [166703] = true, -- Goldtusk Inn Breakfast Buffet
            [166808] = true, -- Bewitching Tea Set
            [183900] = true, -- Sinvyr Tea Set
            [198039] = true, -- Rock of Appreciation
            [199649] = true, -- Dragon Tea Set
            [199650] = true, -- Whale Bone Tea Set
            [234951] = true, -- Uncracked Cold Ones
            [235288] = true, -- Sha-Warped Tea Set
            [235464] = true, -- Sha-Touched Tea Set
            [265414] = true, -- Platinum Amber
        },

        ["Other"] = {
            [17716] = true, -- Snowmaster 9000
            [21540] = true, -- Elune's Lantern
            [187344] = true, -- Offering Kit Maker
            [202309] = true, -- Defective Doomsday Device
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
            [187422] = true, -- Rockin' Rollin' Racer Customizer 19.9.3
            [200878] = true, -- Wheeled Floaty Boaty Controller
        },

        ["Vision"] = {
            [122121] = true, -- Darkmoon Gazer
            [153253] = true, -- S.F.E. Interceptor
        },

        ["Other"] = {
            [228698] = true, -- Candleflexer's Dumbbell
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
            [184396] = true, -- Malfunctioning Goliath Gauntlet
            [184447] = true, -- Kevin's Party Supplies
            [187512] = true, -- Tome of Small Sins
            [199337] = true, -- Bag of Furious Winds
            [206043] = true, -- Fyrakk's Frenzy
            [215147] = true, -- Beautification Iris
            [251491] = true, -- Magical Pet Clicker
            
        },

        ["Summon"] = {
            [23767] = true, -- Crashin' Thrashin' Robot
            [32542] = true, -- Imp in a Ball
            [38506] = true, -- Don Carlos' Famous Hat
            [64881] = true, -- Pendant of the Scarab Storm
            [69227] = true, -- Fool's Gold
            [82467] = true, -- Ruthers' Harness
            [98552] = true, -- Xan'tish's Flute
            [117569] = true, -- Giant Deathweb Egg
            [122293] = true, -- Trans-Dimensional Bird Whistle
            [128328] = true, -- Skoller's Bag of Squirrel Treats
            [128794] = true, -- Sack of Spectral Spiders
            [129279] = true, -- Enchanted Stone Whistle
            [134019] = true, -- Don Carlos' Famous Hat
            [136846] = true, -- Familiar Stone
            [136855] = true, -- Hunter's Call
            [136928] = true, -- Thaumaturgist's Orb
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
            [161342] = true, -- Gem of Acquiescence
            [174445] = true, -- Glimmerfly Cocoon
            [174874] = true, -- Budget K'thir Disguise
            [183986] = true, -- Bondable Sinstone
            [183988] = true, -- Bondable Val'kyr Diadem
            [184413] = true, -- Mnemonic Attunement Pane
            [184476] = true, -- Regenerating Slime Vial
            [184487] = true, -- Gormling in a Bag
            [183901] = true, -- Bonestorm Top
            [187705] = true, -- Choofa's Call
            [200640] = true, -- Obsidian Egg Clutch
            [200999] = true, -- The Super Shellkhan Gang
            [207099] = true, -- Tiny Box of Tiny Rocks
            [208186] = true, -- Boffins
            [209859] = true, -- Festive Trans-Dimensional Bird Whistle
            [254666] = true, -- Exodar Replica
            [260622] = true, -- Exodar Replica (MoP classic)
            [251633] = true, -- Bursting Bounty Bundle
            [263244] = true, -- Enigmatic Fountain
            
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
            [182890] = true, -- Rapid Recitation Quill
            [184489] = true, -- Fae Harp
            [186702] = true, -- Pallid Bone Flute
            [187075] = true, -- Box of Rattling Chains
            [187591] = true, -- Nightborne Guard's Vigilance
            [187689] = true, -- Dance Dance Darkmoon
            [190853] = true, -- Bushel of Mysterious Fruit
            [190177] = true, -- Sphere of Enlightened Cogitation
            [192495] = true, -- Malfunctioning Stealthman 54
            [194056] = true, -- Duck-Stuffed Duck Lovie
            [198090] = true, -- Jar of Excess Slime
            [198474] = true, -- Artist's Easel
            [199902] = true, -- Wayfinder's Compass
            [200160] = true, -- Notfar's Favorite Food
            [200631] = true, -- Happy Tuskarr Palooza
            [201435] = true, -- Shuffling Sands
            [202019] = true, -- Golden Dragon Goblet
            [202711] = true, -- Lost Compass
            [203725] = true, -- Display of Strength
            [204389] = true, -- Stone Breaker
            [205045] = true, -- B.B.F. Fist
            [205463] = true, -- Molten Lava Ball
            [208096] = true, -- Familiar Journal
            [210864] = true, -- Improvised Leafbed
            [221964] = true, -- Filmless Camera
            [225659] = true, -- Arathi Book Collection
            [224552] = true, -- Cave Spelunker's Torch
            [225347] = true, -- Web-Vandal's Spinning Wheel
            [224192] = true, -- Practice Ravager
            [235050] = true, -- Desk-in-a-Box
            [236749] = true, -- Take-Home Torq
            [236751] = true, -- Take-Home Flarendo
            [259240] = true, -- Sin'dorei Wine
            [263198] = true, -- Valdekar's Special
            
        },

        ["Corpse"] = {
            [88589] = true, -- Cremating Torch
            [90175] = true, -- Gin-Ji Knife Set
            [119163] = true, -- Soul Inhaler
            [119182] = true, -- Soul Evacuation Crystal
            [163740] = true, -- Drust Ritual Knife
            [166701] = true, -- Warbeast Kraal Dinner Bell
            [166784] = true, -- Narassin's Soul Gem
            [187174] = true, -- Shaded Judgement Stone
            [194052] = true, -- Forlorn Funeral Pall
            [200469] = true, -- Khadgar's Disenchanting Rod
            [215145] = true, -- Remembrance Stone
            [264517] = true, -- Galactic Flag of Victory
        },

        ["Roll"] = {
            [36862] = true, -- Worn Troll Dice
            [36863] = true, -- Decahedral Dwarven Dice
            [44430] = true, -- Titanium Seal of Dalaran
            [63269] = true, -- Loaded Gnomish Dice
            [186686] = true, -- Pallid Oracle Bones
        },

        ["Statue"] = {
            [54212] = true, -- Instant Statue Pedestal
            [69776] = true, -- Ancient Amber
            [72161] = true, -- Spurious Sarcophagus
            [86573] = true, -- Shard of Archstone
            [88417] = true, -- Gokk'lok's Shell
            [113570] = true, -- Ancient's Bloom
            [115472] = true, -- Permanent Time Bubble
            [116125] = true, -- Klikixx's Webspinner
            [119432] = true, -- Botani Camouflage
            [130171] = true, -- Cursed Orb
            [141879] = true, -- Berglrgl Perrgl Girggrlf
            [164983] = true, -- Rhan'ka's Escape Plan
            [187416] = true, -- Jailer's Cage
            [187417] = true, -- Adamant Vaults Cell
            [187793] = true, -- Personal Containment Trap
            [198409] = true, -- Personal Shell
            [200198] = true, -- Primalist Prison
            [203734] = true, -- Snow Blanket
            [204686] = true, -- Titan's Containment Device
            [208415] = true, -- Stasis Sand
            [206347] = true, -- Mannequin Charm
            [221962] = true, -- Defective Escape Pod
            [225659] = true, -- Arathi Book Collection
            [228706] = true, -- Rockslidomancer's Stone
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
            [187834] = true, -- Tormented Banner of the Opportune
            [187957] = true, -- Encrypted Banner of the Opportune
            [187958] = true, -- Shrouded Banner of the Opportune
            [198728] = true, -- Explorer's League Banner
            [198729] = true, -- Reliquary Banner
            [199767] = true, -- Red Dragon Banner
            [199768] = true, -- Black Dragon Banner
            [199769] = true, -- Blue Dragon Banner
            [199770] = true, -- Bronze Dragon Banner
            [199771] = true, -- Green Dragon Banner
            [203716] = true, -- Thundering Banner of the Aspects
            [206008] = true, -- Nightmare Banner
            [208057] = true, -- Smoldering Banner of the Aspects
            [210042] = true, -- Chilling Celebration Banner
            [211424] = true, -- Dreaming Banner of the Aspects
            [218128] = true, -- Draconic Banner of the Aspects
            [232301] = true, -- Tempered Banner of the Algari
            [232302] = true, -- Prized Banner of the Algari
            [232303] = true, -- Unbound Banner of the Algari
            [232305] = true, -- Forged Champion's Prestigious Banner
            [232306] = true, -- Prized Champion's Prestigious Banner
            [232307] = true, -- Astral Champion's Prestigious Banner
            [235669] = true, -- Steamwheedle Cartel Banner
            [235670] = true, -- Bilgewater Cartel Banner
            [235671] = true, -- Blackwater Cartel Banner
            [235672] = true, -- Venture Co. Banner
            [238852] = true, -- Flame's Radiance Banner
            [239007] = true, -- Dastardly Banner
        },

        -- Summons a clone of the character
        ["Clone"] = {
            [64358] = true, -- Highborne Soul Mirror
            [108745] = true, -- Personal Hologram
            [129952] = true, -- Hourglass of Eternity
            [187140] = true, -- Ring of Duplicity
            [187159] = true, -- Shadow Slicing Shortsword
            [200148] = true, -- A Collection Of Me
            [224251] = true, -- Memory Chord
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
            [206038] = true, -- Flamin' Ring of Flashiness
            [219387] = true, -- Barrel of Fireworks
            [235220] = true, -- Fireworks Hat
        },

        -- stuff to litter the ground
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
            [91904] = true, -- Stackable Stag
            [109739] = true, -- Star Chart
            [116122] = true, -- Burning Legion Missive
            [118222] = true, -- Spirit of Bashiok
            [122126] = true, -- Attraction Sign
            [130170] = true, -- Tear of the Green Aspect
            [130199] = true, -- Legion Pocket Portal
            [130214] = true, -- Worn Doll
            [130232] = true, -- Moonfeather Statue
            [140363] = true, -- Pocket Fel Spreader
            [140632] = true, -- Lava Fountain
            [141297] = true, -- Arcano-Shower
            [160751] = true, -- Dance of the Dead
            [169347] = true, -- Judgment of Mechagon
            [184075] = true, -- Stonewrought Sentry
            [184318] = true, -- Battlecry of Krexus
            [184415] = true, -- Soothing Vesper
            [184418] = true, -- Acrobatic Steward
            [186501] = true, -- Doomwalker Trophy Stand
            [187154] = true, -- Ancient Korthian Runes
            [187176] = true, -- Vesper of Harmony
            [187184] = true, -- Vesper of Clarity
            [187185] = true, -- Vesper of Faith
            [187420] = true, -- Maw-Ocular Viewfinder
            [188694] = true, -- Spring Florist's Pouch
            [190734] = true, -- Makaris's Satchel of Mines
            [190754] = true, -- Firim's Specimen Container
            [193033] = true, -- Convergent Prism
            [193476] = true, -- Gnoll Tent
            [194059] = true, -- Market Tent
            [194060] = true, -- Dragonscale Expedition's Expedition Tent
            [197719] = true, -- Artisan's Sign
            [198173] = true, -- Atomic Recalibrator
            [198474] = true, -- Artist's Easel
            [198646] = true, -- Ornate Dragon Statue
            [199900] = true, -- Secondhand Survey Tools
            [201931] = true, -- Warcraft Rumble Toy: Maiev
            [202261] = true, -- Warcraft Rumble Toy: Sneed
            [202851] = true, -- Warcraft Rumble Toy: Night Elf Huntress
            [202856] = true, -- Warcraft Rumble Toy: Stonehoof Tauren
            [202859] = true, -- Warcraft Rumble Toy: Undead Ghoul
            [202862] = true, -- Warcraft Rumble Toy: Murloc
            [202865] = true, -- Warcraft Rumble Toy: Whelp Egg
            [204220] = true, -- Hraxian's Unbreakable Will
            [204256] = true, -- Holoviewer: The Scarlet Queen
            [204257] = true, -- Holoviewer: The Lady of Dreams
            [204262] = true, -- Holoviewer: The Timeless One
            [204405] = true, -- Stuffed Bear
            [206565] = true, -- Plagued Grain -- Naxxramas
            [208058] = true, -- Minute Glas
            [210411] = true, -- Fast Growing Seed
            [210725] = true, -- Owl Post
            [211931] = true, -- Abyss Caller Horn
            [211946] = true, -- Hearthstone Game Table
            [218310] = true, -- Box of Puntables
            [220692] = true, -- X-treme Water Blaster Display
            [228707] = true, -- Trial of Burning Light
            [235807] = true, -- Storefront-in-a-Box
            [236769] = true, -- Gallagio Pipeline Rerouter
            [239018] = true, -- Winner's Podium
            [245942] = true, -- Sea-Blessed Shrine
            [246227] = true, -- Lightning-Blessed Spire
            [250722] = true, -- Ethereal Stall
        },

        ["Weather"] = {
            [119003] = true, -- Void Totem
            [119145] = true, -- Firefury Totem
            [131724] = true, -- Crystalline Eye of Undravius
            [136935] = true, -- Tadpole Cloudseeder
            [163744] = true, -- Coldrage's Cooler
            [198206] = true, -- Environmental Emulator
            [198264] = true, -- Centralized Precipitation Emitter
            [209858] = true, -- Dreamsurge Remnant
            [210975] = true, -- Date Simulation Modulator
        }
    },

    ["Interactable"] = {

        -- Can sit in these
        ["Chair"] = {
            [33223] = true, -- Fishing Chair
            [45047] = true, -- Sandbox Tiger
            [70161] = true, -- Mushroom Chair
            [86596] = true, -- Nat's Fishing Chair
            [97994] = true, -- Darkmoon Seesaw
            [116689] = true, -- Pineapple Lounge Cushion
            [116690] = true, -- Safari Lounge Cushion
            [116691] = true, -- Zhevra Lounge Cushion
            [116692] = true, -- Fuzzy Green Lounge Cushion
            [129956] = true, -- Leather Love Seat
            [184410] = true, -- Aspirant's Stretcher
            [193478] = true, -- Tuskarr Beanbag
            [194057] = true, -- Cushion of Time Travel
            [194058] = true, -- Cold Cushion
            [198720] = true, -- Soft Purple Pillow
            [198721] = true, -- Skinny Reliquary Pillow
            [198722] = true, -- Small Triangular Pillow
            [199554] = true, -- S.E.A.T.
            [199897] = true, -- Blue-Covered Beanbag
            [200550] = true, -- Very Comfortable Pelt
            [200551] = true, -- Comfortable Pile of Pelts
            [208883] = true, -- Sandbox Storm Gryphon
            [218112] = true, -- Colorful Beach Chair
            [234473] = true, -- Soweezi's Comfy Lawn Chair
            [233486] = true, -- Hallowfall Supply Cache
            [235015] = true, -- Awakened Supply Crate
            [237382] = true, -- Undermine Supply Crate
            [246907] = true, -- Broker Supply Crate
            [246908] = true, -- K'areshi Supply Crate
            [255973] = true, -- Sandbox Horse
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
            [169796] = true, -- Azeroth Mini Collection: Mechagon
            [170196] = true, -- Shirakess Warning Sign
            [170197] = true, -- Swarthy Warning Sign
            [170203] = true, -- Flopping Fish
            [170476] = true, -- Underlight Sealamp
            [174920] = true, -- Coifcurl's Close Shave Kit
            [174928] = true, -- Rotten Apple
            [120857] = true, -- Barrel of Bandanas
            [151877] = true, -- Barrel of Eyepatches
            [184495] = true, -- Infested Arachnid Casing
            [186974] = true, -- Experimental Anima Cell
            [190238] = true, -- Xy'rath's Booby-Trapped Cache
            [193032] = true, -- Jeweled Offering
            [200628] = true, -- Somewhat-Stabilized Arcana
            [200707] = true, -- Armoire of Endless Cloaks
            [205419] = true, -- Dinn's Drum
            [207092] = true, -- Portable Party Platter
        },

        ["Mail"] = {
            [40768] = true, -- MOLL-E
            [156833] = true, -- Katy's Stampwhistle
            [183876] = true, -- Quill of Correspondence
            [194885] = true, -- Ohuna Perch
            [239693] = true, -- Radiant Lynx Whistle
            [264695] = true, -- Interdimensional Parcel Signal
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
            [184218] = true, -- Vulgarity Arbiter
            [184435] = true, -- Mark of Purity
            [187419] = true, -- Steward's First Feather
            [192485] = true, -- Stored Wisdom Device
            [198537] = true, -- Taivan's Trumpet
            [198647] = true, -- Fishspeaker's Lucky Lure
            [205908] = true, -- Inherited Wisdom of Senegos
            [206268] = true, -- Ethereal Transmogrifier
            [216893] = true, -- Goblin Town-in-a-Box
            [258840] = true, -- Gilded Fountain
        },

        -- Can attack these
        ["Target Dummy"] = {
            [46780] = true, -- Ogre Pinata
            [88375] = true, -- Turnip Punching Bag
            [89614] = true, -- Anatomical Dummy
            [144339] = true, -- Sturdy Love Fool
            [163201] = true, -- Gnoll Targeting Barrel
            [199830] = true, -- Tuskarr Training Dummy
            [199896] = true, -- Rubbery Fish Head
            [201933] = true, -- Black Dragon's Challenge Dummy
            [219387] = true, -- Barrel of Fireworks
            [225556] = true, -- Ancient Construct
        },
    },

    ["Game"] = {

        ["Solo"] = {
            [130251] = true, -- JewelCraft
            [132518] = true, -- Blingtron's Circuit Design Tutorial
            [166787] = true, -- Twiddle Twirler: Sentinel's Glaive
            [166788] = true, -- Twiddle Twirler: Shredder Blade
            [206696] = true, -- Tricked-Out Thinking Cap
            [238850] = true, -- Arathi Entertainer's Flame
            [267139] = true, -- Hungry Black Hole
            
        },

        ["Co-op"] = {
            [34499] = true, -- Paper Flying Machine Kit
            [45063] = true, -- Foam Sword Rack
            [71628] = true, -- Sack of Starfish
            [90427] = true, -- Pandaren Brewpack
            [90883] = true, -- The Pigskin
            [90888] = true, -- Special Edition Foot Ball
            [97994] = true, -- Darkmoon Seesaw
            [98132] = true, -- Shado-Pan Geyser Gun
            [104323] = true, -- The Swineskin
            [104324] = true, -- Foot Ball
            [116400] = true, -- Silver-Plated Turkey Shooter
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
            [178530] = true, -- Wreath-A-Rang
            [181825] = true, -- Phial of Ravenous Slime
            [184292] = true, -- Ancient Elethium Coin
            [191925] = true, -- Falling Star Flinger
            [191937] = true, -- Falling Star Catcher
            [199894] = true, -- Fisherman's Folly Rack
            [199899] = true, -- Iskaara Tug Sled
            [200597] = true, -- Lover's Bouquet
            [202020] = true, -- Chasing Storm
            [204818] = true, -- Mallard Mortar
            [205796] = true, -- Molten Lava Pack
            [208825] = true, -- Junior Timekeeper's Racing Belt
            [219387] = true, -- Barrel of Fireworks
            [223312] = true, -- Trusty Hat
            [228707] = true, -- Trial of Burning Light
            [218308] = true, -- Winter Veil Cracker
            [230924] = true, -- Spotlight Materializer 1000
            [235799] = true, -- Throwin' Sawblade
        }
    },

    ["Profession"] = {

        -- https://wow.tools/dbc/?dbc=spellcategories#page=1&colFilter[2]=exact:97
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
            [184404] = true, -- Ever-Abundant Hearth
            [188695] = true, -- Summer Cranial Skillet
            [198402] = true, -- Maruuk Cooking Pot
            [199892] = true, -- Tuskarr Traveling Soup Pot
            [203757] = true, -- Brazier of Madness
            [219403] = true, -- Stonebound Lantern
            [224643] = true, -- Pet-Sized Candle
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
            [167698] = true, -- Secret Fish Goggles
            [168016] = true, -- Hyper-Compressed Ocean
            [180993] = true, -- Bat Visage Bobber
            [202207] = true, -- Reusable Oversized Bobber
            [202360] = true, -- Dented Can
            [237345] = true, -- Limited Edition Rocket Bobber
            [237346] = true, -- Artisan Beverage Goblet Bobber
            [237347] = true, -- Organically-Sourced Wellington Bobber
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

        ["Firework"] = {
            [201930] = true, -- H.E.L.P.
        },

        ["Taunt"] = {
            [38578] = true, -- The Flag of Ownership
            [86575] = true, -- Chalice of Secrets
            [119217] = true, -- Alliance Flag of Victory
            [119218] = true, -- Horde Flag of Victory
            [119219] = true, -- Warlord's Flag of Victory
            [202021] = true, -- Breaker's Flag of Victory
            [225969] = true, -- Forged Flag of Victory
        },

        ["Transform"] = {
            [102467] = true, -- Censer of Eternal Agony
            [173951] = true, -- N'lyeth, Sliver of N'Zoth
        },
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
            [192099] = true, -- Earpieces of Tranquil Focus
            [204687] = true, -- Obsidian Battle Horn
            [205419] = true, -- Dinn's Drum
            [205936] = true, -- New Niffen No-Sniffen' Tonic
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
            [184489] = true, -- Fae Harp
            [184490] = true, -- Fae Pipes
            [188680] = true, -- Winter Veil Chorus Book
            [190333] = true, -- Jiro Circle of Song
            [200926] = true, -- Compendium of Love
        },

        ["Voice"] = {
            [119211] = true, -- Golden Hearthstone Card: Lord Jaraxxus
            [170469] = true, -- Memento of the Deeps
            [244888] = true, -- Echo of the Xal'atath, Blade of the Black Empire
        }
    },

    ["Transportation"] = {

        -- Fly or Slowfall
        ["Fly/Fall"] = {
            [40727] = true, -- Gnomish Gravity Well
            [113542] = true, -- Whispers of Rai'Vosh
            [119093] = true, -- Aviana's Feather
            [131717] = true, -- Starlight Beacon
            [131811] = true, -- Rocfeather Skyhorn Kite
            [134021] = true, -- X-52 Rocket Helmet
            [173727] = true, -- Nomi's Vintage
            [182694] = true, -- Stylish Black Parasol
            [182695] = true, -- Weathered Purple Parasol
            [182696] = true, -- The Countess's Parasol
            [182729] = true, -- Hearty Dragon Plume
            [184312] = true, -- Borr-Geth's Fiery Brimstone
            [192443] = true, -- Element-Infused Rocket Helmet
            [197961] = true, -- Whelps on Strings
            [208433] = true, -- Bronze Racer's Pennant
            [212500] = true, -- Delicate Silk Parasol
            [212523] = true, -- Delicate Jade Parasol
            [212524] = true, -- Delicate Crimson Parasol
            [212525] = true, -- Delicate Ebony Parasol
            [224554] = true, -- Silver Linin' Scepter
            [226373] = true, -- Everlasting Noggenfogger Elixir
            [242520] = true, -- Festival Hot Air Balloon
            [250974] = true, -- Akil'zon's Updraft
            [258963] = true, -- Shroom Jumper's Parachute
            
        },

        -- Unlocks flight paths
        ["Maps"] = {
            [150743] = true, -- Scouting Map: Surviving Kalimdor
            [150744] = true, -- Scouting Map: Walking Kalimdor with the Earthmother
            [150745] = true, -- Scouting Map: The Azeroth Campaign
            [150746] = true, -- Scouting Map: To Modernize the Provisioning of Azeroth
            [187869] = true, -- Scouting Map: Into the Shadowlands
            [187875] = true, -- Scouting Map: United Fronts of the Broken Isles
            [187895] = true, -- Scouting Map: The Dangers of Draenor
            [187896] = true, -- Scouting Map: A Stormstout's Guide to Pandaria
            [187897] = true, -- Scouting Map: Cataclysm's Consequences
            [187898] = true, -- Scouting Map: True Cost of the Northrend Campaign
            [187899] = true, -- Scouting Map: The Many Curiosities of Outland
            [187900] = true, -- Scouting Map: The Wonders of Kul Tiras and Zandalar
        },

        -- https://wago.tools/db2/SpellCategories?filter[Category]=1176&page=1
        ["Hearthstone"] = {
            [54452] = true, -- Ethereal Portal
            [64488] = true, -- The Innkeeper's Daughter
            [93672] = true, -- Dark Portal
            [110560] = true, -- Garrison Hearthstone
            [140192] = true, -- Dalaran Hearthstone
            [142542] = true, -- Tome of Town Portal
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
            [184871] = true, -- Dark Portal
            [188952] = true, -- Dominated Hearthstone
            [190196] = true, -- Enlightened Hearthstone
            [190237] = true, -- Broker Translocation Matrix
            [193588] = true, -- Timewalker's Hearthstone
            [200630] = true, -- Ohn'ir Windsage's Hearthstone
            [206195] = true, -- Path of the Naaru
            [209035] = true, -- Hearthstone of the Flame
            [208704] = true, -- Deepdweller's Earthen Hearthstone
            [210455] = true, -- Draenic Hologem
            [212337] = true, -- Stone of the Hearth
            [228940] = true, -- Notorious Thread's Hearthstone
            [236687] = true, -- Explosive Hearthstone
            [235016] = true, -- Redeployment Module
            [245970] = true, -- P.O.S.T. Master's Express Hearthstone
            [246565] = true, -- Cosmic Hearthstone
            [260221] = true, -- Naaru's Embrace
            [263489] = true, -- Naaru's Enfold
            [257736] = true, -- Lightcalled Hearthstone
            [265100] = true, -- Corewarden's Hearthstone
            
        },

        ["Jump"] = {
            [86590] = true, -- Essence of the Breeze
            [116113] = true, -- Breath of Talador
            [119178] = true, -- Black Whirlwind
            [138111] = true, -- Stormforged Grapple Launcher
            [134023] = true, -- Bottled Tornado
            [139773] = true, -- Emerald Winds
            [140336] = true, -- Brulfist Idol
            [262431] = true, -- Bouncy Mushroom
            
        },

        -- faster or slower ground movement
        ["Running"] = {
            [104329] = true, -- Ash-Covered Horn
            [113543] = true, -- Spirit of Shinri
            [119180] = true, -- Goren "Log" Roller
            [127669] = true, -- Skull of the Mad Chief
            [129965] = true, -- Grizzlesnout's Fang
            [131900] = true, -- Majestic Elderhorn Hoof
            [153193] = true, -- Baarut the Brisk
            [183989] = true, -- Dredger Barrow Racer
            [187339] = true, -- Silver Shardhide Whistle
            [187113] = true, -- Personal Ball and Chain
            [187860] = true, -- Mortis Mover
            [188698] = true, -- Eagger Basket
            [198827] = true, -- Magical Snow Sled
            [209052] = true, -- Brew Barrel
            [224585] = true, -- Hanna's Locket
            [245580] = true, -- Rolling Snowball
            [265774] = true, -- Platinum Boots of Expeditious Retreat
            [266999] = true, -- Swift Yak Pelt
        },

        ["Swimming"] = {
            [86582] = true, -- Aqua Jewel
            [129165] = true, -- Barnacle-Encrusted Gem
            [134024] = true, -- Cursed Swabby Helmet
            [200116] = true, -- Everlasting Horn of Lavaswimming
        },

        ["Teleport"] = {
            [18984] = true, -- Dimensional Ripper - Everlook
            [18986] = true, -- Ultrasafe Transporter: Gadgetzan
            [30542] = true, -- Dimensional Ripper - Area 52
            [30544] = true, -- Ultrasafe Transporter: Toshley's Station
            [43824] = true, -- The Schools of Arcane Magic - Mastery
            [48933] = true, -- Wormhole Generator: Northrend
            [87215] = true, -- Wormhole Generator: Pandaria
            [95567] = true, -- Kirin Tor Beacon
            [95568] = true, -- Sunreaver Beacon
            [112059] = true, -- Wormhole Centrifuge
            [129929] = true, -- Ever-Shifting Mirror
            [136849] = true, -- Nature's Beacon
            [140324] = true, -- Mobile Telemancy Beacon
            [141605] = true, -- Flight Master's Whistle
            [151016] = true, -- Fractured Necrolyte Skull
            [151652] = true, -- Wormhole Generator: Argus
            [153004] = true, -- Unstable Portal Emitter
            [168807] = true, -- Wormhole Generator: Kul Tiras
            [168808] = true, -- Wormhole Generator: Zandalar
            [169297] = true, -- Stormpike Insignia
            [169298] = true, -- Frostwolf Insignia
            [172924] = true, -- Wormhole Generator: Shadowlands
            [198156] = true, -- Wyrmhole Generator
            [205255] = true, -- Niffen Diggin' Mitts
            [211788] = true, -- Tess's Peacebloom
            [221966] = true, -- Wormhole Generator: Khaz Algar
            [230850] = true, -- Delve-O-Bot 7001
            [243056] = true, -- Delver's Mana-Bound Ethergate
            [253629] = true, -- Personal Key to the Arcantina
            [263933] = true, -- Astalor's Summons

        },

        ["Water Walking"] = {
            [85500] = true, -- Angler's Fishing Raft
            [142341] = true, -- Love Boat
            [166461] = true, -- Gnarlwood Waveboard
            [177951] = true, -- Glimmerflies on Strings
            [198428] = true, -- Tuskarr Dinghy
            [211864] = true, -- Exquisite Love Boat
            [224554] = true, -- Silver Linin' Scepter
            [235801] = true, -- Personal Fishing Barge
            [248263] = true, -- Azure Sea Boat -- mop classic (chinese?)
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
        [153194] = true, -- Legion Communication Orb
        [153204] = true, -- All-Seer's Eye
        [158149] = true, -- Overtuned Corgi Goggles
        [163200] = true, -- Cursed Spyglass
        [166678] = true, -- Brynja's Beacon
        [170187] = true, -- Shadescale
        [170380] = true, -- Jar of Sunwarmed Sand
        [174926] = true, -- Overly Sensitive Void Spectacles
        [163603] = true, -- Lucille's Handkerchief
        [197986] = true, -- Murglasses
        [198227] = true, -- Giggle Goggles
        [202283] = true, -- Reading Glasses
        [209858] = true, -- Dreamsurge Remnant
        [210974] = true, -- Eyes For You Only
        [226519] = true, -- General's Expertise
        [228914] = true, -- Arachnophile Spectacles
        [228966] = true, -- Starry-Eyed Goggles
        [246905] = true, -- Overtuned K'areshi Goggles
        [264805] = true, -- Brann-O-Vision 3000
        
    },

    ["Companion"] = {
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
            [184449] = true, -- Jiggles's Favorite Toy
            [184508] = true, -- Mawsworn Pet Leash
            [186973] = true, -- Anima-ted Leash
            [186985] = true, -- Elisive Pet Treat
            [187051] = true, -- Forgotten Feather
            [224643] = true, -- Pet-Sized Candle
            [226191] = true, -- Web Pet Leash
            [263871] = true, -- Holy Pet Leash
            
        },

        ["Hunter Pet"] = {
            --[267279] = true, -- Embers of Al'ar
        },

        -- replaces regular mount model or adds a minor effect
        ["Mount"] = {
            [69215] = true, -- War Party Hitching Post
            [112324] = true, -- Nightmarish Hitching Post
            [138202] = true, -- Sparklepony XL
            [172219] = true, -- Wild Holly
            [204675] = true, -- A Drake's Big Basket of Eggs
            [212518] = true, -- Vial of Endless Draconic Scales
        }
    },
}
