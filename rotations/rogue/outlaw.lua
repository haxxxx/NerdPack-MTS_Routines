local mKey = 'MTS_RogueOutlaw'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Rogue - Outlaw Settings',
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

}

local AoE = {
	{'Blade Flurry', '!player.buff(Blade Flurry)'}
}

local ST = {
	-- Remove Blade Flurry
	{'Blade Flurry', {
		'!player.buff(Blade Flurry)',
		'!player.area(8).enemies >= 3'
	}},
	--Roll the Bones with >= 5 Combo Points to maintain the random buffs.
	{'Roll the Bones', 'player.combopoints >= 5'},
	--Run Through to dump excess Combo Points.
	{'Roll the Bones', 'player.combopoints >= 5'},
	--Pistol Shot when buffed from Saber Slash.
	{'Pistol Shot', 'player.buff(Opportunity)'},
	--Ambush when possible to generate Combo Points.
	{'Ambush'},
	--Saber Slash or to build Combo Points.
	{'Saber Slash'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(260, '[|cff'..MTS.Interface.addonColor..'MTS|r] Rogue - Outlaw', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{AoE, {'toggle.AoE', 'player.area(8).enemies >= 3'}},
		{ST, {'target.range < 8', 'target.infront'}}
	}, outCombat, exeOnLoad)