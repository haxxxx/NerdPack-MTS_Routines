local mKey = 'MTSHunterSV'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Hunter Survival Settings',
	color = (function() return NeP.Core.classColor('player') end),
	width = 250,
	height = 500,
	config = {
		
	}
}

local E = MTS.dynEval
local F = function(key) return NeP.Interface.fetchKey(mKey, key, 100) end

local exeOnLoad = function()
	MTS.Splash()
	NeP.Interface.buildGUI(config)
	MTS.ClassSetting(mKey)
end

local Survival = {

}

local Cooldowns = {
	--Aspect of the Eagle Use on every cooldown.
	{'Aspect of the Eagle'}
}

local Pet = {
	-- Mend Pet
	{'Mend Pet', 'pet.health < 100'},
}

local AoE = {
	--Carve to dump excess Focus.
	{'Carve', 'player.focus > 65'}
}

local ST = {
	--Explosive Trap
	{'Explosive Trap'},
	--Lacerate maintained at all times.
	{'Lacerate', 'target.debuff(Lacerate).duration < 4'},
	--Mongoose Bite dump all charges when they stack to 3.
	{'Mongoose Bite', 'player.spell(Mongoose Bite).charges >= 3'},
	--Flanking Strike on cooldown.
	{'Flanking Strike'},
	--Raptor Strike to dump any extra Focus.
	{'Raptor Strike'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(255, '[|cff'..MTS.Interface.addonColor..'MTS|r] Hunter - Survival', 
	{-- In-Combat
		{'Mongoose Bite', 'lastcast(Mongoose Bite)'},
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{pet, {'pet.exists', 'pet.alive'}},
		{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
		{ST, {'target.range < 8', 'target.infront'}}
	}, outCombat, exeOnLoad)