-- Achievement Registry
-- Defines all achievements in a data-driven way to eliminate duplication
-- This file categorizes and configures all achievements in the mod

require "scripts/AllAchiv/allachivbalance"

local AchievementRegistry = {}

-- Achievement Types
AchievementRegistry.TYPES = {
    SIMPLE_COUNTER = "simple_counter",      -- Count to threshold (eat 100 foods, mine 400 rocks)
    AREA_KILL = "area_kill",                -- Kill creature, award nearby players
    SOLO_KILL = "solo_kill",                -- Kill creature with no helpers nearby
    TRIGGER = "trigger",                    -- One-time trigger (enter game, kill specific mob)
    TIME_BASED = "time_based",              -- Track time in state (freezing, starving, walking)
    COLLECTION = "collection",              -- Track unique items collected
    DAMAGE = "damage",                      -- Track cumulative damage
    SPECIAL = "special",                    -- Custom logic handled separately
}

-- Achievement Categories for organization
AchievementRegistry.CATEGORIES = {
    FOOD = "food",
    LIFE = "life",
    WORK = "work",
    HAVE = "have",
    LIKE = "like",
    PAIN = "pain",
    FIGHT = "fight",
    HUNT = "hunt",
    BOSS = "boss",
    MISC = "misc",
    MILESTONE = "milestone",
}

-- Achievement Definitions
-- Each achievement has:
--   - category: logical grouping
--   - type: how it's tracked (see TYPES above)
--   - threshold: required value (nil = trigger-based)
--   - config: type-specific configuration
AchievementRegistry.DEFINITIONS = {
    -- FOOD
    firsteat = {
        category = AchievementRegistry.CATEGORIES.FOOD,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Eat any food"
    },
    supereat = {
        category = AchievementRegistry.CATEGORIES.FOOD,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["supereat"],
        counter_field = "eatamount"
    },
    danding = {
        category = AchievementRegistry.CATEGORIES.FOOD,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["danding"],
        counter_field = "eatmonsterlasagna"
    },
    eatfish = {
        category = AchievementRegistry.CATEGORIES.FOOD,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["eatfish"],
        counter_field = "eatfishamount"
    },
    eatturkey = {
        category = AchievementRegistry.CATEGORIES.FOOD,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["eatturkey"],
        counter_field = "eatturkeyamount"
    },
    eatpepper = {
        category = AchievementRegistry.CATEGORIES.FOOD,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["eatpepper"],
        counter_field = "eatpepperamount"
    },
    eatbacon = {
        category = AchievementRegistry.CATEGORIES.FOOD,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["eatbacon"],
        counter_field = "eatbaconamount"
    },
    eatmole = {
        category = AchievementRegistry.CATEGORIES.FOOD,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["eatmole"],
        counter_field = "eatmoleamount"
    },
    eathot = {
        category = AchievementRegistry.CATEGORIES.FOOD,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["eathot"],
        counter_field = "eathotamount"
    },
    eatcold = {
        category = AchievementRegistry.CATEGORIES.FOOD,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["eatcold"],
        counter_field = "eatcoldamount"
    },
    alldiet = {
        category = AchievementRegistry.CATEGORIES.FOOD,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["alldiet"],
        counter_field = "eatall",
        list_field = "eatlist"
    },

    -- LIFE
    noob = {
        category = AchievementRegistry.CATEGORIES.LIFE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Die for the first time"
    },
    tooyoung = {
        category = AchievementRegistry.CATEGORIES.LIFE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Die before day 2"
    },
    rose = {
        category = AchievementRegistry.CATEGORIES.LIFE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Find a rose"
    },
    rot = {
        category = AchievementRegistry.CATEGORIES.LIFE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Eat rot"
    },
    deathalot = {
        category = AchievementRegistry.CATEGORIES.LIFE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["deathalot"],
        counter_field = "deathamouth"
    },
    secondchance = {
        category = AchievementRegistry.CATEGORIES.LIFE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Use a Life Giving Amulet"
    },
    messiah = {
        category = AchievementRegistry.CATEGORIES.LIFE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["messiah"],
        counter_field = "respawnamount"
    },
    sleeptent = {
        category = AchievementRegistry.CATEGORIES.LIFE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["sleeptent"],
        counter_field = "sleeptentamount"
    },
    sleepsiesta = {
        category = AchievementRegistry.CATEGORIES.LIFE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["sleepsiesta"],
        counter_field = "sleepsiestaamount"
    },
    reviveamulet = {
        category = AchievementRegistry.CATEGORIES.LIFE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["reviveamulet"],
        counter_field = "reviveamuletamount"
    },
    feedplayer = {
        category = AchievementRegistry.CATEGORIES.LIFE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["feedplayer"],
        counter_field = "feedplayeramount"
    },

    -- WORK
    nature = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["nature"],
        counter_field = "natureamount"
    },
    fishmaster = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["fishmaster"],
        counter_field = "fishamount"
    },
    pickappren = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["pickappren"],
        counter_field = "pickamount"
    },
    pickmaster = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["pickmaster"],
        counter_field = "pickamount"
    },
    chopappren = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["chopappren"],
        counter_field = "chopamount"
    },
    chopmaster = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["chopmaster"],
        counter_field = "chopamount"
    },
    mineappren = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["mineappren"],
        counter_field = "mineamount"
    },
    minemaster = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["minemaster"],
        counter_field = "mineamount"
    },
    cookappren = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["cookappren"],
        counter_field = "cookamount"
    },
    cookmaster = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["cookmaster"],
        counter_field = "cookamount"
    },
    buildappren = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["buildappren"],
        counter_field = "buildamount"
    },
    buildmaster = {
        category = AchievementRegistry.CATEGORIES.WORK,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["buildmaster"],
        counter_field = "buildamount"
    },

    -- HAVE (Collection achievements)
    emerald = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["emerald"],
        counter_field = "emeralds"
    },
    citrin = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["citrin"],
        counter_field = "citrins"
    },
    amber = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["amber"],
        counter_field = "ambers"
    },
    saddle = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["saddle"],
        counter_field = "saddles"
    },
    banana = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["banana"],
        counter_field = "bananas"
    },
    spore = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["spore"],
        counter_field = "spores"
    },
    blueprint = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["blueprint"],
        counter_field = "blueprints"
    },
    boat = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["boat"],
        counter_field = "boats"
    },
    moonrock = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["moonrock"],
        counter_field = "moonrocks"
    },
    gnome = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["gnome"],
        counter_field = "gnomes"
    },
    mosquito = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["mosquito"],
        counter_field = "mosquitos"
    },
    bathbomb = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["bathbomb"],
        counter_field = "bathbombamount"
    },
    allgiantPlants = {
        category = AchievementRegistry.CATEGORIES.HAVE,
        type = AchievementRegistry.TYPES.COLLECTION,
        threshold = allachiv_eventdata["allgiantPlants"],
        counter_field = "giantPlants",
        list_field = "giantPlantList"
    },

    -- LIKE (Friendship/Social)
    goodman = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["goodman"],
        counter_field = "friendpig"
    },
    brother = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["brother"],
        counter_field = "friendbunny"
    },
    catperson = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["catperson"],
        counter_field = "friendcat"
    },
    rocklob = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["rocklob"],
        counter_field = "friendrocky"
    },
    spooder = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["spooder"],
        counter_field = "friendspider"
    },
    evil = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["evil"],
        counter_field = "evilamount"
    },
    birdclop = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Befriend a Tall Bird"
    },
    pet = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Have a pet"
    },
    shadowchester = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Get Shadow Chester"
    },
    snowchester = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Get Snow Chester"
    },
    musichutch = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Get Music Hutch"
    },
    lavae = {
        category = AchievementRegistry.CATEGORIES.LIKE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Adopt a Lavae"
    },

    -- PAIN (Survival challenges)
    burn = {
        category = AchievementRegistry.CATEGORIES.PAIN,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Catch on fire"
    },
    freeze = {
        category = AchievementRegistry.CATEGORIES.PAIN,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Freeze"
    },
    sleep = {
        category = AchievementRegistry.CATEGORIES.PAIN,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Fall asleep"
    },
    starve = {
        category = AchievementRegistry.CATEGORIES.PAIN,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["starve"],
        counter_field = "starvetime"
    },
    nosanity = {
        category = AchievementRegistry.CATEGORIES.PAIN,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["nosanity"],
        counter_field = "nosanitytime"
    },
    icebody = {
        category = AchievementRegistry.CATEGORIES.PAIN,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["icebody"],
        counter_field = "icetime"
    },
    firebody = {
        category = AchievementRegistry.CATEGORIES.PAIN,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["firebody"],
        counter_field = "firetime"
    },
    moistbody = {
        category = AchievementRegistry.CATEGORIES.PAIN,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["moistbody"],
        counter_field = "moisttime"
    },
    evilflower = {
        category = AchievementRegistry.CATEGORIES.PAIN,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["evilflower"],
        counter_field = "evilfloweramount"
    },
    roses = {
        category = AchievementRegistry.CATEGORIES.PAIN,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["roses"],
        counter_field = "rosesamount"
    },
    drown = {
        category = AchievementRegistry.CATEGORIES.PAIN,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Drown"
    },

    -- FIGHT (Combat achievements)
    angry = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.DAMAGE,
        threshold = allachiv_eventdata["angry"],
        counter_field = "onhitdamage"
    },
    tank = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.DAMAGE,
        threshold = allachiv_eventdata["tank"],
        counter_field = "attackeddamage"
    },
    dmgnodmg = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.DAMAGE,
        threshold = allachiv_eventdata["dmgnodmg"],
        counter_field = "dmgnodmgamount"
    },
    bullkelp = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.DAMAGE,
        threshold = allachiv_eventdata["bullkelp"],
        counter_field = "bullkelpamount"
    },
    butcher = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["butcher"],
        counter_field = "butcheramount",
        prefab = "beefalo",
        condition = function(victim) return victim:HasTag("scarytoprey") end,
        radius = 30
    },
    horrorhound = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["horrorhound"],
        counter_field = "horrorhoundamount",
        prefab = "mutatedhound",
        radius = 30
    },
    slurtle = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["slurtle"],
        counter_field = "slurtleamount",
        prefab = "slurtle",
        radius = 30
    },
    werepig = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["werepig"],
        counter_field = "werepigamount",
        prefabs = {"moonpig", "pigman"},
        condition = function(victim)
            return victim.prefab == "moonpig" or
                   (victim.prefab == "pigman" and victim.components.werebeast and victim.components.werebeast:IsInWereState())
        end,
        radius = 30
    },
    fruitdragon = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["fruitdragon"],
        counter_field = "fruitdragonamount",
        prefab = "fruitdragon",
        condition = function(victim) return victim._is_ripe end,
        radius = 30
    },
    sick = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.SPECIAL,
        description = "Be near when Glommer dies"
    },
    coldblood = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Chester"
    },
    hutch = {
        category = AchievementRegistry.CATEGORIES.FIGHT,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Fugu Hutch at low health"
    },

    -- HUNT (Hunting achievements)
    goatperd = {
        category = AchievementRegistry.CATEGORIES.HUNT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["goatperd"],
        counter_field = "goatperdamount",
        prefab = "lightninggoat",
        condition = function(victim) return victim:HasTag("charged") end,
        radius = 30
    },
    mossling = {
        category = AchievementRegistry.CATEGORIES.HUNT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["mossling"],
        counter_field = "mosslingamount",
        prefab = "mossling",
        radius = 30
    },
    weetusk = {
        category = AchievementRegistry.CATEGORIES.HUNT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["weetusk"],
        counter_field = "weetuskamount",
        prefab = "little_walrus",
        radius = 30
    },
    snake = {
        category = AchievementRegistry.CATEGORIES.HUNT,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["snake"],
        counter_field = "snakeamount"
    },
    black = {
        category = AchievementRegistry.CATEGORIES.HUNT,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Shadow Pieces"
    },
    hentai = {
        category = AchievementRegistry.CATEGORIES.HUNT,
        type = AchievementRegistry.TYPES.SOLO_KILL,
        threshold = allachiv_eventdata["hentai"],
        counter_field = "hentaiamount",
        prefab = "tentacle_pillar",
        radius = 15
    },
    treeguard = {
        category = AchievementRegistry.CATEGORIES.HUNT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["treeguard"],
        counter_field = "treeguardamount",
        prefabs = {"leif", "leif_sparse"},
        radius = 30
    },
    spiderqueen = {
        category = AchievementRegistry.CATEGORIES.HUNT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["spiderqueen"],
        counter_field = "spiderqueenamount",
        prefab = "spiderqueen",
        radius = 30
    },
    varg = {
        category = AchievementRegistry.CATEGORIES.HUNT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["varg"],
        counter_field = "vargamount",
        prefab = "warg",
        radius = 30
    },
    koaelefant = {
        category = AchievementRegistry.CATEGORIES.HUNT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["koaelefant"],
        counter_field = "koaelefantamount",
        prefabs = {"koalefant_summer", "koalefant_winter"},
        radius = 30
    },
    monkey = {
        category = AchievementRegistry.CATEGORIES.HUNT,
        type = AchievementRegistry.TYPES.AREA_KILL,
        threshold = allachiv_eventdata["monkey"],
        counter_field = "monkeyamount",
        prefab = "monkey",
        radius = 30
    },

    -- BOSS
    santa = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.SPECIAL,
        description = "Kill Klaus"
    },
    dragonfly = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Dragonfly"
    },
    malbatross = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Malbatross"
    },
    crabking = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Crab King"
    },
    knight = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Knight"
    },
    bishop = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Bishop"
    },
    rook = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Rook"
    },
    minotaur = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Ancient Fuelweaver"
    },
    ancient = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Ancient Guardian"
    },
    rigid = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Celestial Champion"
    },
    queen = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Bee Queen"
    },
    king = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill all seasonal bosses"
    },
    bosswinter = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Deerclops"
    },
    bossspring = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Moose/Goose"
    },
    bossantlion = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Antlion"
    },
    bossautumn = {
        category = AchievementRegistry.CATEGORIES.BOSS,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Kill Bearger"
    },

    -- MISC
    intogame = {
        category = AchievementRegistry.CATEGORIES.MISC,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Enter the game"
    },
    trader = {
        category = AchievementRegistry.CATEGORIES.MISC,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["trader"],
        counter_field = "tradeamount"
    },
    fuzzy = {
        category = AchievementRegistry.CATEGORIES.MISC,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["fuzzy"],
        counter_field = "fuzzyamount"
    },
    knowledge = {
        category = AchievementRegistry.CATEGORIES.MISC,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Use Wickerbottom's books"
    },
    dance = {
        category = AchievementRegistry.CATEGORIES.MISC,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["dance"],
        counter_field = "danceamount"
    },
    teleport = {
        category = AchievementRegistry.CATEGORIES.MISC,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["teleport"],
        counter_field = "teleportamount"
    },
    luck = {
        category = AchievementRegistry.CATEGORIES.MISC,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Get Krampus Sack"
    },
    lightning = {
        category = AchievementRegistry.CATEGORIES.MISC,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Get struck by lightning"
    },
    birchnut = {
        category = AchievementRegistry.CATEGORIES.MISC,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["birchnut"],
        counter_field = "birchnutamount"
    },

    -- MILESTONE
    all = {
        category = AchievementRegistry.CATEGORIES.MILESTONE,
        type = AchievementRegistry.TYPES.TRIGGER,
        description = "Complete all achievements"
    },
    longage = {
        category = AchievementRegistry.CATEGORIES.MILESTONE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["longage"],
        counter_field = "age"
    },
    oldage = {
        category = AchievementRegistry.CATEGORIES.MILESTONE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["oldage"],
        counter_field = "age"
    },
    walkalot = {
        category = AchievementRegistry.CATEGORIES.MILESTONE,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["walkalot"],
        counter_field = "walktime"
    },
    stopalot = {
        category = AchievementRegistry.CATEGORIES.MILESTONE,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["stopalot"],
        counter_field = "stoptime"
    },
    caveage = {
        category = AchievementRegistry.CATEGORIES.MILESTONE,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["caveage"],
        counter_field = "cavetime"
    },
    superstar = {
        category = AchievementRegistry.CATEGORIES.MILESTONE,
        type = AchievementRegistry.TYPES.SIMPLE_COUNTER,
        threshold = allachiv_eventdata["superstar"],
        counter_field = "starspent"
    },
    rider = {
        category = AchievementRegistry.CATEGORIES.MILESTONE,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["rider"],
        counter_field = "rideramount"
    },
    fullsanity = {
        category = AchievementRegistry.CATEGORIES.MILESTONE,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["fullsanity"],
        counter_field = "fullsanityamount"
    },
    fullhunger = {
        category = AchievementRegistry.CATEGORIES.MILESTONE,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["fullhunger"],
        counter_field = "fullhungeramount"
    },
    pacifist = {
        category = AchievementRegistry.CATEGORIES.MILESTONE,
        type = AchievementRegistry.TYPES.TIME_BASED,
        threshold = allachiv_eventdata["pacifist"],
        counter_field = "pacifistamount"
    },
}

-- Helper functions to query the registry
function AchievementRegistry:GetDefinition(achievement_name)
    return self.DEFINITIONS[achievement_name]
end

function AchievementRegistry:GetByCategory(category)
    local results = {}
    for name, def in pairs(self.DEFINITIONS) do
        if def.category == category then
            results[name] = def
        end
    end
    return results
end

function AchievementRegistry:GetByType(achievement_type)
    local results = {}
    for name, def in pairs(self.DEFINITIONS) do
        if def.type == achievement_type then
            results[name] = def
        end
    end
    return results
end

function AchievementRegistry:GetAllNames()
    local names = {}
    for name, _ in pairs(self.DEFINITIONS) do
        table.insert(names, name)
    end
    return names
end

return AchievementRegistry
