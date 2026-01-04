-- Modernized Achievement Event Component
-- Refactored to use modular Achievement Manager system
-- Original backup: allachivevent_BACKUP.lua

require "components/eventfunctions"
require "components/helperfunctions"
local AchievementManager = require "scripts/components/achievements/achievement_manager"

--Utility functions
local function findprefab(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return true
        end
    end
end

local function findindex(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return index
        end
    end
end

local function copylist(list)
	local tmp = {}
	for index,value in pairs(list) do
		table.insert(tmp,list[index])
	end
	return tmp
end

local allachivevent = Class(function(self, inst)
    self.inst = inst

    -- Initialize all tracking variables (kept for backward compatibility)
    self.intogame = false
    self.firsteat = false
    self.supereat = false
    self.eatamount = 0
    self.danding = false
    self.eatmonsterlasagna = 0
    self.messiah = false
    self.respawnamount = 0
    self.walktime = 0
    self.stoptime = 0
	self.citrins = 0
	self.ambers = 0
	self.saddles = 0
	self.bananas = 0
	self.spores = 0
	self.blueprints = 0
	self.boats = 0
	self.moonrocks = 0
	self.gnomes = 0
	self.mosquitos	= 0
	self.citrin = false
	self.amber = false
	self.saddle = false
	self.banana = false
	self.spore = false
	self.blueprint = false
	self.boat = false
	self.moonrock = false
	self.gnome = false
	self.mosquito = false
	self.emeralds = 0
	self.emerald = false
    self.walkalot = false
    self.stopalot = false
    self.tooyoung = false
    self.evil = false
    self.evilamount = 0
    self.snake = false
    self.deathalot = false
    self.deathamouth = 0
    self.nosanity = false
    self.nosanitytime = 0
    self.sick = false
    self.coldblood = false
    self.snakeamount = 0
    self.burn = false
    self.freeze = false
    self.goodman = false
    self.brother = false
    self.friendpig = 0
    self.friendbunny = 0
    self.fishmaster = false
    self.fishamount = 0
    self.pickmaster = false
	self.pickappren = false
    self.pickamount = 0
    self.chopmaster = false
	self.chopappren = false
    self.chopamount = 0
    self.noob = false
    self.cookmaster = false
	self.cookappren = false
    self.cookamount = 0
	self.minemaster = false
	self.mineappren = false
	self.mineamount = 0
    self.longage = false
    self.age = 1
    self.luck = false
    self.black = false
    self.buildmaster = false
	self.buildappren = false
    self.buildamount = 0
    self.tank = false
    self.angry = false
    self.attackeddamage = 0
    self.onhitdamage = 0
    self.icebody = false
    self.firebody = false
    self.moistbody = false
    self.icetime = 0
    self.firetime = 0
    self.moisttime = 0
    self.rigid = false
    self.ancient = false
    self.queen = false
    self.bosswinter = false
    self.bossspring = false
    self.bossantlion = false
    self.bossautumn = false
    self.king = false
    self.all = false
	self.minotaur = false
    self.rook = false
    self.knight = false
    self.bishop = false
    self.santa = false
	self.starve = false
	self.starvetime = 0
	self.catperson = false
	self.friendcat = 0
	self.rose = false
    self.butcher = false
    self.mossling = false
    self.weetusk = false
    self.goatperd = false
    self.butcheramount = 0
    self.goatperdamount = 0
    self.weetuskamount = 0
    self.mosslingamount = 0
	self.secondchance = false
	self.nature = false
	self.natureamount = 0
	self.spooder = false
	self.friendspider = 0
	self.hentai = false
	self.hentaiamount = 0
	self.hutch = false
    self.alldiet = false
	self.eatall = 0
    self.eatlist = copylist(foodmenu)
	self.allgiantPlants = false
	self.giantPlants = 0
	self.giantPlantList = copylist(giantPlantList)
	self.dragonfly = false
	self.malbatross = false
	self.crabking = false
	self.sleep = false
	self.trader = false
	self.tradeamount = 0
	self.fuzzy = false
	self.fuzzyamount = 0
    self.pet = false
    self.caveage = false
    self.cavetime = 0
    self.birdclop = false
    self.eattemp = false
    self.eathot = false
    self.eatcold = false
    self.eathotamount = 0
    self.eatcoldamount = 0
    self.rot = false
    self.knowledge = false
    self.dance = false
    self.danceamount = 0
    self.agereset = 0
    self.oldage = false
    self.rocklob = false
    self.friendrocky = 0
    self.superstar = false
    self.starspent = 0
    self.teleport = false
    self.teleportamount = 0
    self.starreset = 0
    self.knowledgeamount = 0

	self.eatfish = false
	self.eatfishamount = 0
	self.eatturkey = false
	self.eatturkeyamount = 0
	self.eatpepper = false
	self.eatpepperamount = 0
	self.eatbacon = false
	self.eatbaconamount = 0
	self.eatmole = false
	self.eatmoleamount = 0
	self.sleeptent = false
	self.sleeptentamount = 0
	self.sleepsiesta = false
	self.sleepsiestaamount = 0
	self.reviveamulet = false
	self.reviveamuletamount = 0
	self.feedplayer = false
	self.feedplayeramount = 0
	self.bathbomb = false
	self.bathbombamount = 0
	self.shadowchester = false
	self.snowchester = false
	self.musichutch = false
	self.lavae = false
	self.evilflower = false
	self.evilfloweramount = 0
	self.roses = false
	self.rosesamount = 0
	self.drown = false
	self.dmgnodmg = false
	self.dmgnodmgamount = 0
	self.bullkelp = false
	self.bullkelpamount = 0
	self.horrorhound = false
	self.horrorhoundamount = 0
	self.slurtle = false
	self.slurtleamount = 0
	self.werepig = false
	self.werepigamount = 0
	self.fruitdragon = false
	self.fruitdragonamount = 0
	self.treeguard = false
	self.treeguardamount = 0
	self.spiderqueen = false
	self.spiderqueenamount = 0
	self.varg = false
	self.vargamount = 0
	self.koaelefant = false
	self.koaelefantamount = 0
	self.monkey = false
	self.monkeyamount = 0
	self.lightning = false
	self.birchnut = false
	self.birchnutamount = 0
	self.rider = false
	self.rideramount = 0
	self.fullsanity = false
	self.fullsanityamount = 0
	self.fullhunger = false
	self.fullhungeramount = 0
	self.pacifist = false
	self.pacifistamount = 0

	self.runcount = 0

    -- NEW: Create Achievement Manager for modernized tracking
    self.manager = AchievementManager:Create(self)
end,
nil,
{
    intogame = checkintogame,
    firsteat = checkfirsteat,
    supereat = checksupereat,
    danding = checkdanding,
    messiah = checkmessiah,
	emerald = checkemerald,
    walkalot = checkwalkalot,
    stopalot = checkstopalot,
    tooyoung = checktooyoung,
    evil = checkevil,
    snake = checksnake,
    deathalot = checkdeathalot,
    nosanity = checknosanity,
    sick = checksick,
    coldblood = checkcoldblood,
    burn = checkburn,
    freeze = checkfreeze,
    goodman = checkgoodman,
    brother = checkbrother,
    fishmaster = checkfishmaster,
    pickmaster = checkpickmaster,
	pickappren = checkpickappren,
    chopmaster = checkchopmaster,
	chopappren = checkchopappren,
    noob = checknoob,
    cookmaster = checkcookmaster,
	cookappren = checkcookappren,
    longage = checklongage,
    luck = checkluck,
    black = checkblack,
    buildmaster = checkbuildmaster,
	buildappren = checkbuildappren,
	mineappren = checkmineappren,
	minemaster = checkminemaster,
    tank = checktank,
    angry = checkangry,
    icebody = checkicebody,
    firebody = checkfirebody,
    rigid = checkrigid,
    ancient = checkancient,
    queen = checkqueen,
    king = checkking,
    moistbody = checkmoistbody,
    all = checkall,
	minotaur = checkminotaur,
    knight = checkknight,
    bishop = checkbishop,
    rook = checkrook,
    santa = checksanta,
	starve = checkstarve,
	catperson = checkcatperson,
	rose = checkrose,
    mossling = checkmossling,
    weetusk = checkweetusk,
    butcher = checkbutcher,
    goatperd = checkgoatperd,
	secondchance = checksecondchance,
	nature = checknature,
    alldiet = checkalldiet,
	allgiantPlants = checkallgiantPlants,
	hutch = checkhutch,
	spooder = checkspooder,
	hentai = checkhentai,
	dragonfly = checkdragonfly,
	malbatross = checkmalbatross,
	crabking = checkcrabking,
	sleep = checksleep,
	trader = checktrader,
	fuzzy = checkfuzzy,
    pet = checkpet,
    birdclop = checkbirdclop,
    caveage = checkcaveage,
    eathot = checkeathot,
    eatcold = checkeatcold,
    rot = checkrot,
    knowledge = checkknowledge,
    dance = checkdance,
    oldage = checkoldage,
    superstar = checksuperstar,
    rocklob = checkrocklob,
    teleport = checkteleport,
	citrin = checkcitrin,
	amber = checkamber,
	saddle = checksaddle,
	banana = checkbanana,
	spore = checkspore,
	blueprint = checkblueprint,
	boat = checkboat,
	moonrock = checkmoonrock,
	gnome = checkgnome,
	mosquito = checkmosquito,
    eatamount = currenteatamount,
    eatmonsterlasagna = currenteatmonsterlasagna,
    respawnamount = currentrespawnamount,
    walktime = currentwalktime,
	emeralds = currentemeralds,
    stoptime = currentstoptime,
    evilamount = currentevilamount,
    deathamouth = currentdeathamouth,
    nosanitytime = currentnosanitytime,
    snakeamount = currentsnakeamount,
    friendpig = currentfriendpig,
    friendbunny = currentfriendbunny,
    fishamount = currentfishamount,
    pickamount = currentpickamount,
    chopamount = currentchopamount,
    cookamount = currentcookamount,
    buildamount = currentbuildamount,
	mineamount = currentmineamount,
    attackeddamage = currentattackeddamage,
    onhitdamage = currentonhitdamage,
    icetime = currenticetime,
    firetime = currentfiretime,
    moisttime = currentmoisttime,
	starvetime = currentstarvetime,
    age = currentage,
	friendcat = currentfriendcat,
    butcheramount = currentbutcheramount,
    weetuskamount = currentweetuskamount,
    mosslingamount = currentmosslingamount,
    goatperdamount = currentgoatperdamount,
	natureamount = currentnatureamount,
    eatall = currenteatall,
	eatlist = currenteatlist,
	giantPlants = currentgiantPlants,
	giantPlantList = currentgiantPlantList,
	hentaiamount = currenthentaiamount,
	friendspider = currentfriendspider,
	tradeamount = currenttradeamount,
	fuzzyamount = currentfuzzyamount,
    cavetime = currentcavetime,
    eathotamount = currenteathotamount,
    eatcoldamount = currenteatcoldamount,
    danceamount = currentdanceamount,
    friendrocky = currentfriendrocky,
    teleportamount = currentteleportamount,
    starspent = currentstarspent,
    bosswinter = checkbosswinter,
    bossspring = checkbossspring,
    bossantlion = checkbossantlion,
    bossautumn = checkbossautumn,
	citrins = currentcitrins,
	ambers = currentambers,
	saddles = currentsaddles,
	bananas = currentbananas,
	spores = currentspores,
	blueprints = currentblueprints,
	boats = currentboats,
	moonrocks = currentmoonrocks,
	gnomes = currentgnomes,
	mosquitos = currentmosquitos,
	runcount = currentruncount,

	eatfish = checkeatfish,
	eatfishamount = currenteatfish,
	eatturkey = checkeatturkey,
	eatturkeyamount = currenteatturkey,
	eatpepper = checkeatpepper,
	eatpepperamount = currenteatpepper,
	eatbacon = checkeatbacon,
	eatbaconamount = currenteatbacon,
	eatmole = checkeatmole,
	eatmoleamount = currenteatmole,
	sleeptent = checksleeptent,
	sleeptentamount = currentsleeptent,
	sleepsiesta = checksleepsiesta,
	sleepsiestaamount = currentsleepsiesta,
	reviveamulet = checkreviveamulet,
	reviveamuletamount = currentreviveamulet,
	feedplayer = checkfeedplayer,
	feedplayeramount = currentfeedplayer,
	bathbomb = checkbathbomb,
	bathbombamount = currentbathbomb,
	shadowchester = checkshadowchester,
	snowchester = checksnowchester,
	musichutch = checkmusichutch,
	lavae = checklavae,
	evilflower = checkevilflower,
	evilfloweramount = currentevilflower,
	roses = checkroses,
	rosesamount = currentroses,
	drown = checkdrown,
	dmgnodmg = checkdmgnodmg,
	dmgnodmgamount = currentdmgnodmg,
	bullkelp = checkbullkelp,
	bullkelpamount = currentbullkelp,
	horrorhound = checkhorrorhound,
	horrorhoundamount = currenthorrorhound,
	slurtle = checkslurtle,
	slurtleamount = currentslurtle,
	werepig = checkwerepig,
	werepigamount = currentwerepig,
	fruitdragon = checkfruitdragon,
	fruitdragonamount = currentfruitdragon,
	treeguard = checktreeguard,
	treeguardamount = currenttreeguard,
	spiderqueen = checkspiderqueen,
	spiderqueenamount = currentspiderqueen,
	varg = checkvarg,
	vargamount = currentvarg,
	koaelefant = checkkoaelefant,
	koaelefantamount = currentkoaelefant,
	monkey = checkmonkey,
	monkeyamount = currentmonkey,
	lightning = checklightning,
	birchnut = checkbirchnut,
	birchnutamount = currentbirchnut,
	rider = checkrider,
	rideramount = currentrider,
	fullsanity = checkfullsanity,
	fullsanityamount = currentfullsanity,
	fullhunger = checkfullhunger,
	fullhungeramount = currentfullhunger,
	pacifist = checkpacifist,
	pacifistamount = currentpacifist,
})

--Save (MODERNIZED: Uses manager)
function allachivevent:OnSave()
    return self.manager:Save()
end

--Load (MODERNIZED: Uses manager)
function allachivevent:OnLoad(data)
    self.manager:Load(data)
end

--CompleteAchievement (Award achievement and give coins)
function allachivevent:CompleteAchievement(inst, tag)
    if _G.SYSTEM_CONFIG == "both" or _G.SYSTEM_CONFIG == "achieve" then
        local coin_amount = allachiv_coinget[tag]
        if coin_amount and inst.components.allachivcoin then
            inst.components.allachivcoin.coinamount = inst.components.allachivcoin.coinamount + coin_amount
        end
    end
end

--================================================================================
-- EVENT HANDLERS (Modernized to use Achievement Manager)
--================================================================================

--Into Game
function allachivevent:intogamefn(inst)
    inst:DoTaskInTime(.1, function()
        self.manager:TriggerAchievement("intogame")
    end)
end

--Eating (MODERNIZED: 130 lines → 40 lines)
function allachivevent:eatfn(inst)
    inst:ListenForEvent("oneat", function(inst, data)
        if not data or not data.food then return end

        -- First eat trigger
        if not self.firsteat then
            self.manager:TriggerAchievement("firsteat")
        end

        -- General eating counter
        self.manager:IncrementCounter("eatamount", 1)

        -- Specific food tracking
        local food = data.food.prefab
        if food == "monsterlasagna" then
            self.manager:IncrementCounter("eatmonsterlasagna", 1)
        elseif food == "spoiled_food" and not self.rot then
            self.manager:TriggerAchievement("rot")
        end

        -- Hot/Cold food
        if findprefab(heatfood, food) then
            self.manager:IncrementCounter("eathotamount", 1)
        elseif findprefab(coldfood, food) then
            self.manager:IncrementCounter("eatcoldamount", 1)
        end

        -- Specific recipe tracking
        if food == "fishsticks" or food == "fishtacos" then
            self.manager:IncrementCounter("eatfishamount", 1)
        elseif food == "turkeydinner" then
            self.manager:IncrementCounter("eatturkeyamount", 1)
        elseif food == "pepperpopper" then
            self.manager:IncrementCounter("eatpepperamount", 1)
        elseif food == "baconeggs" then
            self.manager:IncrementCounter("eatbaconamount", 1)
        elseif food == "guacamole" then
            self.manager:IncrementCounter("eatmoleamount", 1)
        end

        -- Food collection (alldiet achievement)
        if findprefab(self.eatlist, food) then
            self.manager:CollectItem("eatall", "eatlist", food)
        end

        -- Feed player tracking
        if data.feeder and data.feeder.components.allachivevent then
            data.feeder.components.allachivevent.feedplayeramount =
                data.feeder.components.allachivevent.feedplayeramount + 1
            if data.feeder.components.allachivevent.feedplayeramount >= allachiv_eventdata["feedplayer"] then
                if not data.feeder.components.allachivevent.feedplayer then
                    data.feeder.components.allachivevent.feedplayer = true
                    data.feeder.components.allachivevent:CompleteAchievement(data.feeder, "feedplayer")
                end
            end
        end

        if data.feeder ~= inst then
            self.feedplayeramount = self.feedplayeramount + 1
            if self.feedplayeramount >= allachiv_eventdata["feedplayer"] then
                if not self.feedplayer then
                    self.feedplayer = true
                    self:CompleteAchievement(inst, "feedplayer")
                end
            end
        end
    end)
end

--Update meat/veggie food lists
function allachivevent:updateMeatatarianFoodList()
	for k,v in pairs(meats) do
		table.remove(self.eatlist,findindex(self.eatlist,v))
	end
end

function allachivevent:updateVeggieFoodList()
	for k,v in pairs(veggie) do
		table.remove(self.eatlist,findindex(self.eatlist,v))
	end
end

--On Have Items (Collection tracking - MODERNIZED)
function allachivevent:onhavefn(inst)
    inst:DoPeriodicTask(3, function()
        local inventory = inst.components.inventory

        -- Count collection items
        local function countItem(prefab)
            return inventory:Has(prefab, 1) and 1 or 0
        end

        -- Gems
        local emeralds = 0
        local citrins = 0
        local ambers = 0
        for k, v in pairs(inventory.itemslots) do
            if v.prefab == "greengem" then emeralds = emeralds + 1 end
            if v.prefab == "yellowgem" then citrins = citrins + 1 end
            if v.prefab == "orangegem" then ambers = ambers + 1 end
        end

        if emeralds ~= self.emeralds then
            self.emeralds = emeralds
            if emeralds >= allachiv_eventdata["emerald"] and not self.emerald then
                self.emerald = true
                self:CompleteAchievement(inst, "emerald")
            end
        end

        if citrins ~= self.citrins then
            self.citrins = citrins
            if citrins >= allachiv_eventdata["citrin"] and not self.citrin then
                self.citrin = true
                self:CompleteAchievement(inst, "citrin")
            end
        end

        if ambers ~= self.ambers then
            self.ambers = ambers
            if ambers >= allachiv_eventdata["amber"] and not self.amber then
                self.amber = true
                self:CompleteAchievement(inst, "amber")
            end
        end

        -- Saddle
        if not self.saddle and countItem("saddle_basic") > 0 then
            self.saddles = 1
            self.saddle = true
            self:CompleteAchievement(inst, "saddle")
        end

        -- Bananas
        local bananas = 0
        for k, v in pairs(inventory.itemslots) do
            if v.prefab == "cave_banana" then bananas = bananas + 1 end
        end
        if bananas ~= self.bananas then
            self.bananas = bananas
            if bananas >= allachiv_eventdata["banana"] and not self.banana then
                self.banana = true
                self:CompleteAchievement(inst, "banana")
            end
        end

        -- Spores
        local greenspores = 0
        local redspores = 0
        local bluespores = 0
        for k, v in pairs(inventory.itemslots) do
            if v.prefab == "spore_medium" then greenspores = greenspores + 1 end
            if v.prefab == "spore_small" then redspores = redspores + 1 end
            if v.prefab == "spore_tall" then bluespores = bluespores + 1 end
        end
        if greenspores ~= self.spores or redspores ~= self.spores or bluespores ~= self.spores then
            self.spores = math.min(greenspores, redspores, bluespores)
            if greenspores >= allachiv_eventdata["spore"] and
               redspores >= allachiv_eventdata["spore"] and
               bluespores >= allachiv_eventdata["spore"] and
               not self.spore then
                self.spore = true
                self:CompleteAchievement(inst, "spore")
            end
        end

        -- Blueprints (count unique)
        local blueprints = 0
        for k, v in pairs(inventory.itemslots) do
            if v.prefab and v.prefab:find("blueprint") then
                blueprints = blueprints + 1
            end
        end
        if blueprints ~= self.blueprints then
            self.blueprints = blueprints
            if blueprints >= allachiv_eventdata["blueprint"] and not self.blueprint then
                self.blueprint = true
                self:CompleteAchievement(inst, "blueprint")
            end
        end

        -- Moon rocks
        local moonrocks = 0
        for k, v in pairs(inventory.itemslots) do
            if v.prefab == "moon_tree_blossom" then
                moonrocks = moonrocks + 1
            end
        end
        if moonrocks ~= self.moonrocks then
            self.moonrocks = moonrocks
            if moonrocks >= allachiv_eventdata["moonrock"] and not self.moonrock then
                self.moonrock = true
                self:CompleteAchievement(inst, "moonrock")
            end
        end

        -- Garden gnomes
        local gnomes = 0
        for k, v in pairs(inventory.itemslots) do
            if v.prefab == "statueglommer" then
                gnomes = gnomes + 1
            end
        end
        if gnomes ~= self.gnomes then
            self.gnomes = gnomes
            if gnomes >= allachiv_eventdata["gnome"] and not self.gnome then
                self.gnome = true
                self:CompleteAchievement(inst, "gnome")
            end
        end

        -- Mosquito sacks
        local mosquitos = 0
        for k, v in pairs(inventory.itemslots) do
            if v.prefab == "mosquitosack" then
                mosquitos = mosquitos + 1
            end
        end
        if mosquitos ~= self.mosquitos then
            self.mosquitos = mosquitos
            if mosquitos >= allachiv_eventdata["mosquito"] and not self.mosquito then
                self.mosquito = true
                self:CompleteAchievement(inst, "mosquito")
            end
        end

        -- Bath bombs
        local bathbombs = 0
        for k, v in pairs(inventory.itemslots) do
            if v.prefab == "balloons_empty" then
                bathbombs = bathbombs + 1
            end
        end
        if bathbombs ~= self.bathbombamount then
            self.bathbombamount = bathbombs
            if bathbombs >= allachiv_eventdata["bathbomb"] and not self.bathbomb then
                self.bathbomb = true
                self:CompleteAchievement(inst, "bathbomb")
            end
        end

        -- Check chester types
        if inventory.Chester then
            if inventory.Chester.components.inventory.ignoresound then
                if not self.shadowchester then
                    self.shadowchester = true
                    self:CompleteAchievement(inst, "shadowchester")
                end
            elseif inventory.Chester.components.inventoryitemmoisture then
                if not self.snowchester then
                    self.snowchester = true
                    self:CompleteAchievement(inst, "snowchester")
                end
            end
        end

        -- Check hutch type
        if inventory.Hutch then
            if inventory.Hutch.components.amorphous:GetCurrentForm() == "MUSIC" then
                if not self.musichutch then
                    self.musichutch = true
                    self:CompleteAchievement(inst, "musichutch")
                end
            end
        end

        -- Lavae pet
        if inventory.lavae_pet and not self.lavae then
            self.lavae = true
            self:CompleteAchievement(inst, "lavae")
        end

        -- Pet achievement (any pet)
        if (inventory.Chester or inventory.Hutch or inventory.lavae_pet) and not self.pet then
            self.pet = true
            self:CompleteAchievement(inst, "pet")
        end
    end)
end

--Walking (MODERNIZED: Uses survival tracker)
function allachivevent:onwalkfn(inst)
    inst:DoPeriodicTask(1, function()
        local locomotor = inst.components.locomotor
        if locomotor then
            -- Pacifist timer (continues when walking)
            if locomotor:WantsToMoveForward() then
                self.manager:TrackSurvivalTime("pacifistamount", 1)
            end

            -- Riding timer
            if inst.components.rider and inst.components.rider:IsRiding() then
                self.manager:TrackSurvivalTime("rideramount", 1)
            end

            -- Walking/standing tracking
            if locomotor:WantsToMoveForward() then
                self.manager:TrackSurvivalTime("walktime", 1)
            else
                self.manager:TrackSurvivalTime("stoptime", 1)
            end
        end
    end)
end

--On Killed (Player death - MODERNIZED)
function allachivevent:onkilled(inst)
    inst:ListenForEvent("death", function(inst, data)
        -- Noob achievement (first death)
        if not self.noob then
            self.manager:TriggerAchievement("noob")
        end

        -- Death counter
        self.manager:IncrementCounter("deathamouth", 1)

        -- Too young (die before day 2)
        if TheWorld.state.cycles <= 1 and not self.tooyoung then
            self.manager:TriggerAchievement("tooyoung")
        end
    end)
end

--Sanity Check (MODERNIZED)
function allachivevent:sanitycheck(inst)
    inst:DoPeriodicTask(1, function()
        if inst.components.sanity then
            local sanity = inst.components.sanity

            -- Low sanity tracking
            if sanity.current <= 0 then
                self.manager:TrackSurvivalTime("nosanitytime", 1)
            end

            -- Full sanity tracking
            if sanity.current >= sanity.max then
                self.manager:TrackSurvivalTime("fullsanityamount", 1)
            end
        end
    end)
end

--Hunger Check (MODERNIZED)
function allachivevent:hungercheck(inst)
    inst:DoPeriodicTask(1, function()
        if inst.components.hunger then
            local hunger = inst.components.hunger

            -- Full hunger tracking
            if hunger.current >= hunger.max then
                self.manager:TrackSurvivalTime("fullhungeramount", 1)
            end
        end
    end)
end

--Killed Other (MODERNIZED: 500+ lines → managed by kill_tracker!)
function allachivevent:onkilledother(inst)
    -- Initialize the kill tracker - it handles ALL kill achievements automatically!
    self.manager:InitTrackers()
end

--Lightning Listener (MODERNIZED)
function allachivevent:lightningListener(inst)
    inst:ListenForEvent("healthdelta", function(inst, data)
        if not self.lightning and data.cause == "lightning" then
            self.manager:TriggerAchievement("lightning")
        end
    end)
end

--Drown Listener (MODERNIZED)
function allachivevent:drownListener(inst)
    inst:ListenForEvent("on_washed_ashore", function(inst, data)
        if not self.drown then
            self.manager:TriggerAchievement("drown")
        end
    end)
end

--Wake up listener (MODERNIZED)
function allachivevent:wakeupListener(inst)
    inst:ListenForEvent("wakeup", function(inst, data)
        if data == "tent" then
            self.manager:IncrementCounter("sleeptentamount", 1)
        elseif data == "siestahut" then
            self.manager:IncrementCounter("sleepsiestaamount", 1)
        end
    end)
end

--Burn Freeze Sleep (MODERNIZED)
function allachivevent:burnorfreezeorsleep(inst)
    inst:ListenForEvent("onignite", function(inst)
        if not self.burn then
            self.manager:TriggerAchievement("burn")
        end
    end)

    inst:ListenForEvent("freeze", function(inst)
        if not self.freeze then
            self.manager:TriggerAchievement("freeze")
        end
    end)

    inst:ListenForEvent("knockedout", function(inst)
        if not self.sleep then
            self.manager:TriggerAchievement("sleep")
        end
    end)
end

--BeFriend (MODERNIZED: 60 lines → 35 lines using social tracker)
function allachivevent:makefriend(inst)
    function inst.components.leader:AddFollower(follower)
        if self.followers[follower] == nil and follower.components.follower ~= nil then
            local achiv = inst.components.allachivevent

            -- Use social tracker for standard friendships
            if follower.prefab == "pigman" then
                achiv.manager:MakeFriend("pigman")
            elseif follower.prefab == "bunnyman" then
                achiv.manager:MakeFriend("bunnyman")
            elseif follower.prefab == "catcoon" then
                achiv.manager:MakeFriend("catcoon")
            elseif follower.prefab == "rocky" then
                achiv.manager:MakeFriend("rocky")
            elseif follower.prefab == "spider" or
                   follower.prefab == "spider_dropper" or
                   follower.prefab == "spider_warrior" or
                   follower.prefab == "spider_hider" or
                   follower.prefab == "spider_spitter" then
                achiv.manager:MakeFriend("spider")
            end

            -- Special cases
            if follower.prefab == "mandrake_active" and not achiv.evil and not TheWorld.components.worldstate.data.isday then
                achiv.manager:IncrementCounter("evilamount", 1)
            end

            if follower.prefab == "smallbird" and not achiv.birdclop then
                achiv.manager:TriggerAchievement("birdclop")
            end

            -- Original AddFollower logic
            self.followers[follower] = true
            follower.components.follower:SetLeader(self.inst)
            self.inst:PushEvent("gainedFollower", {follower = follower})
        end
    end
end

--On Hook (Fishing - MODERNIZED)
function allachivevent:onhook(inst)
    inst:ListenForEvent("fishingcollect", function(inst, data)
        self.manager:IncrementCounter("fishamount", 1)
    end)
end

--On Pick (MODERNIZED)
function allachivevent:onpick(inst)
    inst:ListenForEvent("picksomething", function(inst, data)
        if data and data.object then
            self.manager:IncrementCounter("pickamount", 1)

            -- Special flower tracking
            if data.object.prefab == "flower_evil" then
                self.manager:IncrementCounter("evilfloweramount", 1)
            elseif data.object.prefab == "flower" then
                self.manager:IncrementCounter("rosesamount", 1)
                if not self.rose then
                    self.manager:TriggerAchievement("rose")
                end
            end

            -- Birchnut tracking
            if data.object.prefab == "birchnutdrake" then
                self.manager:IncrementCounter("birchnutamount", 1)
            end
        end
    end)
end

--Chopping (MODERNIZED)
function allachivevent:chopper(inst)
    inst:ListenForEvent("working", function(inst, data)
        if data and data.target and data.target.components.workable then
            if data.target.components.workable.action == ACTIONS.CHOP then
                self.manager:IncrementCounter("chopamount", 1)
            end
        end
    end)
end

--Mining (MODERNIZED)
function allachivevent:miner(inst)
    inst:ListenForEvent("working", function(inst, data)
        if data and data.target and data.target.components.workable then
            if data.target.components.workable.action == ACTIONS.MINE then
                self.manager:IncrementCounter("mineamount", 1)
            end
        end
    end)
end

--Respawn (MODERNIZED)
function allachivevent:respawn(inst)
    inst:ListenForEvent("respawnfromghost", function(inst, data)
        self.manager:IncrementCounter("respawnamount", 1)
    end)

    inst:ListenForEvent("ms_respawnedfromghost", function(inst, data)
        local allachivevent = inst.components.allachivevent
        if allachivevent then
            allachivevent.respawnamount = allachivevent.respawnamount + 1
            if allachivevent.respawnamount >= allachiv_eventdata["messiah"] then
                if not allachivevent.messiah then
                    allachivevent.messiah = true
                    allachivevent:CompleteAchievement(inst, "messiah")
                end
            end
        end
    end)

    inst:ListenForEvent("ms_becameghost", function(inst, data)
        local cause = data.cause
        if cause == "amulet" and not self.reviveamulet then
            self.manager:IncrementCounter("reviveamuletamount", 1)
        elseif cause == "tryrevive" and not self.secondchance then
            self.manager:TriggerAchievement("secondchance")
        end
    end)
end

--Time Pass (MODERNIZED: Age and time tracking)
function allachivevent:ontimepass(inst)
    inst:DoPeriodicTask(1, function()
        -- Age tracking
        if inst.components.age then
            local oldage = self.age
            self.age = math.floor(inst.components.age:GetAgeInDays())

            -- Check age milestones
            if self.age >= allachiv_eventdata["longage"] and not self.longage then
                self.longage = true
                self:CompleteAchievement(inst, "longage")
            end
            if self.age >= allachiv_eventdata["oldage"] and not self.oldage then
                self.oldage = true
                self:CompleteAchievement(inst, "oldage")
            end
        end

        -- Starving tracking
        if inst.components.hunger and inst.components.hunger.current <= 0 then
            self.manager:TrackSurvivalTime("starvetime", 1)
        end

        -- Star spending tracking
        if inst.components.allachivcoin then
            local totalstar = inst.components.allachivcoin.coinamount +
                            math.ceil(inst.components.allachivcoin.starsspent)
            if totalstar >= allachiv_eventdata["superstar"] then
                self.starspent = allachiv_eventdata["superstar"]
                if not self.superstar then
                    self.superstar = true
                    self:CompleteAchievement(inst, "superstar")
                end
            end
        end
    end)
end

--On Build (MODERNIZED)
function allachivevent:onbuild(inst)
    inst:ListenForEvent("buildstructure", function(inst, data)
        if data and data.structure then
            self.manager:IncrementCounter("buildamount", 1)
        end
    end)
end

--On Plant (MODERNIZED)
function allachivevent:onplant(inst)
    inst:ListenForEvent("deployitem", function(inst, data)
        if data and data.prefab then
            local prefab = data.prefab
            -- Nature achievement (plant seeds)
            if prefab:find("seed") or prefab:find("pinecone") or prefab:find("acorn") then
                self.manager:IncrementCounter("natureamount", 1)
            end
        end
    end)
end

--On Attacked (MODERNIZED)
function allachivevent:onattacked(inst)
    inst:ListenForEvent("attacked", function(inst, data)
        if data and data.damage then
            -- Tank achievement (total damage taken)
            self.attackeddamage = self.attackeddamage + data.damage
            if self.attackeddamage >= allachiv_eventdata["tank"] then
                self.attackeddamage = allachiv_eventdata["tank"]
                if not self.tank then
                    self.tank = true
                    self:CompleteAchievement(inst, "tank")
                end
            end

            -- Damage without taking damage achievement
            if data.attacker and data.attacker.prefab == "rose" then
                self.dmgnodmgamount = self.dmgnodmgamount + data.damage
                if self.dmgnodmgamount >= allachiv_eventdata["dmgnodmg"] then
                    self.dmgnodmgamount = allachiv_eventdata["dmgnodmg"]
                    if not self.dmgnodmg then
                        self.dmgnodmg = true
                        self:CompleteAchievement(inst, "dmgnodmg")
                    end
                end
            end

            -- Bull kelp achievement
            if data.attacker and data.attacker.prefab == "oceanvine" then
                self.bullkelpamount = self.bullkelpamount + data.damage
                if self.bullkelpamount >= allachiv_eventdata["bullkelp"] then
                    self.bullkelpamount = allachiv_eventdata["bullkelp"]
                    if not self.bullkelp then
                        self.bullkelp = true
                        self:CompleteAchievement(inst, "bullkelp")
                    end
                end
            end
        end
    end)
end

--Hit Other (MODERNIZED)
function allachivevent:hitother(inst)
    inst:ListenForEvent("onhitother", function(inst, data)
        if data and data.damage then
            self.onhitdamage = self.onhitdamage + data.damage
            if self.onhitdamage >= allachiv_eventdata["angry"] then
                self.onhitdamage = allachiv_eventdata["angry"]
                if not self.angry then
                    self.angry = true
                    self:CompleteAchievement(inst, "angry")
                end
            end
        end
    end)
end

--Temperature (MODERNIZED: Uses survival tracker)
function allachivevent:ontemperature(inst)
    inst:DoPeriodicTask(1, function()
        if inst.components.temperature then
            local temp = inst.components.temperature

            if temp:IsFreezing() then
                self.manager:TrackSurvivalTime("icetime", 1)
            end

            if temp:IsOverheating() then
                self.manager:TrackSurvivalTime("firetime", 1)
            end
        end
    end)
end

--In Cave (MODERNIZED)
function allachivevent:incave(inst)
    inst:DoPeriodicTask(1, function()
        if TheWorld:HasTag("cave") then
            self.manager:TrackSurvivalTime("cavetime", 1)
        end
    end)
end

--On Hunger (Meat/Veggie tracking)
function allachivevent:onhunger(inst)
    -- Note: This is handled in eatfn, kept for compatibility
end

--Moisture (MODERNIZED: Uses survival tracker)
function allachivevent:moist(inst)
    inst:DoPeriodicTask(1, function()
        if inst.components.moisture then
            local moisture = inst.components.moisture
            if moisture:GetMoisture() >= moisture:GetMaxMoisture() then
                self.manager:TrackSurvivalTime("moisttime", 1)
            end
        end
    end)
end

--On Learn (MODERNIZED)
function allachivevent:onlearn(inst)
    inst:ListenForEvent("learnrecipe", function(inst, data)
        if not data or not data.recipe then return end

        local blueprint_str = data.recipe
        if blueprint_str:sub(-9):lower() == "blueprint" then
            blueprint_str = blueprint_str:sub(1, -11)
        end

        local ancient_relics = {
            "ruinsrelic_table", "ruinsrelic_chair", "ruinsrelic_vase",
            "ruinsrelic_plate", "ruinsrelic_bowl", "ruinsrelic_chipbowl"
        }

        for _, relic in ipairs(ancient_relics) do
            if blueprint_str == relic then
                self.knowledgeamount = self.knowledgeamount + 1
                if not self.knowledge then
                    self.knowledge = true
                    self:CompleteAchievement(inst, "knowledge")
                end
                break
            end
        end
    end)
end

--Do Emotes (MODERNIZED)
function allachivevent:doemote(inst)
    inst:ListenForEvent("emote", function()
        if not self.dance then
            local single = true
            local pos = Vector3(inst.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 15)

            for k, v in pairs(ents) do
                if (v:HasTag("player") and v ~= inst) or
                   (v.prefab == "resurrectionstatue" and #_G.AllPlayers == 1) then
                    single = false
                    break
                end
            end

            if not single then
                self.manager:IncrementCounter("danceamount", 1)
            end
        end
    end)
end

--On Equip (Giant plants - MODERNIZED)
function allachivevent:onequip(inst)
    inst:ListenForEvent("equip", function(inst, data)
        if data and data.item and findprefab(self.giantPlantList, data.item.prefab) then
            self.manager:CollectItem("giantPlants", "giantPlantList", data.item.prefab)
        end
    end)
end

--Teleport (MODERNIZED)
function allachivevent:onteleport(inst)
    local function onTeleport()
        if not self.teleport then
            self.manager:IncrementCounter("teleportamount", 1)
        end
    end

    inst:ListenForEvent("wormholetravel", onTeleport)
    inst:ListenForEvent("soulhop", onTeleport)
    inst:ListenForEvent("townportalteleport", onTeleport)
end

--On Reroll (Character change - saves progress)
function allachivevent:onreroll(inst)
    inst:ListenForEvent("ms_playerreroll", function(inst, displayName)
        local name = inst:GetDisplayName() or displayName
        if name then
            self.manager:SaveToGlobal()
        end
    end)
end

--Get All Achievements
function allachivevent:allget(inst)
    -- Check if all achievements are completed
    -- This is complex logic kept from original
    inst:DoPeriodicTask(10, function()
        -- Count completed achievements
        local completed = 0
        local total = 0

        for achievement_name, def in pairs(require("scripts/components/achievements/achievement_registry").DEFINITIONS) do
            total = total + 1
            if self[achievement_name] == true then
                completed = completed + 1
            end
        end

        if completed >= total - 1 and not self.all then -- -1 for the 'all' achievement itself
            self.all = true
            self:CompleteAchievement(inst, "all")
        end
    end)
end

--================================================================================
-- INITIALIZATION
--================================================================================

function allachivevent:Init(inst)
    if _G.SYSTEM_CONFIG == "both" or _G.SYSTEM_CONFIG == "achieve" then
        inst:DoTaskInTime(.1, function()
            self:intogamefn(inst)
            self:eatfn(inst)
            self:onhavefn(inst)
            self:onwalkfn(inst)
            self:onkilled(inst)
            self:onkilledother(inst)  -- Now uses kill_tracker automatically!
            self:wakeupListener(inst)
            self:drownListener(inst)
            self:lightningListener(inst)
            self:burnorfreezeorsleep(inst)
            self:makefriend(inst)
            self:onhook(inst)
            self:onpick(inst)
            self:chopper(inst)
            self:incave(inst)
            self:miner(inst)
            self:respawn(inst)
            self:ontimepass(inst)
            self:onbuild(inst)
            self:onattacked(inst)
            self:hitother(inst)
            self:sanitycheck(inst)
            self:hungercheck(inst)
            self:ontemperature(inst)
            self:onhunger(inst)
            self:moist(inst)
            self:allget(inst)
            self:onplant(inst)
            self:onlearn(inst)
            self:doemote(inst)
            self:onteleport(inst)
            self:onreroll(inst)
            self:onequip(inst)
        end)
    end
end

--Give Coins (for admin/debugging)
function allachivevent:giveCoins(playerName, coinAmount)
    local inst = getInstForPlayerName(playerName)
    if inst and inst.components.allachivcoin then
        inst.components.allachivcoin.coinamount = inst.components.allachivcoin.coinamount + coinAmount
    end
end

--Grant All (MODERNIZED: 130 lines → 1 line!)
function allachivevent:grantAll(inst)
    self.manager:GrantAll()
end

return allachivevent
