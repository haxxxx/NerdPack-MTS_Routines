local mKey = 'MTSHunterBM'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Hunter Beast Mastery Settings',
	color = NeP.Core.classColor('player'),
	width = 250,
	height = 500,
	config = {
		
	}
}

NeP.Interface.buildGUI(config)
local E = MTS.dynEval
local F = function(key) return NeP.Interface.fetchKey(mKey, key, 100) end

local exeOnLoad = function()
	MTS.Splash()
	MTS.ClassSetting(mKey)
end

local Survival = {

}

local Cooldowns = {
	--Bestial Wrath Use on cooldown.
	{'Bestial Wrath'},
	--Aspect of the Wild Use on cooldown.
	{'Aspect of the Wild'}
}

local Pet = {
	-- Mend Pet
	{'Mend Pet', 'pet.health < 100'},
	--Kill Command on cooldown.
	{'Kill Command', 'target.petrange < 25'},
}

local AoE = {
	--Dire Beast on cooldown.
	{'Dire Beast'},
	--Multi-Shot for Beast Cleave and to dump Focus.
	{'Multi-Shot'}
}

local ST = {
	--Cobra Shot as needed to dump Focus.
	{'Cobra Shot', 'player.focus > 65'},
	--Dire Beast on cooldown to generate Focus.
	{'Dire Beast'}
}

local Keybinds = {
	-- Pause
	{'pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(253, '[|cff'..MTS.Interface.addonColor..'MTS|r] Hunter - Beast Mastery', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{pet, {'pet.exists', 'pet.alive'}},
		{AoE, {'toggle.AoE', 'player.area(40).enemies >= 3'}},
		{ST, {'target.range < 40', 'target.infront'}}
	}, outCombat, exeOnLoad)