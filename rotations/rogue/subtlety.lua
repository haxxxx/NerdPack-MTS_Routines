local mKey = 'MTS_RogueSubtlely'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Rogue - Subtlely Settings',
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
	{'Shadow Blades'}
}

local ST = {
	--Symbols of Death to maintain the buff.
	{'Symbols of Death', '!target.debuff(Symbols of Death).duration < 5'},
	--Nightblade maintained with >= 5 Combo Point refreshes.
	{'Nightblade', {'player.combopoints >= 5', 'target.debuff(Nightblade).duration < 5'}},
	--Shadow Dance with 2 or more charges.
	{'Shadow Dance', 'player.spell(Shadow Dance).charges >= 2'},
	--Eviscerate to dump excess Combo Points.
	{'Eviscerate', 'player.combopoints >= 5'},
	--Shadowstrike when available to build Combo Points.
	{'Shadowstrike'},
	--Backstab or Shuriken Storm to build Combo Points.
	{'Shuriken Storm', {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{'Backstab'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(261, '[|cff'..MTS.Interface.addonColor..'MTS|r] Rogue - Subtlely', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{ST, {'target.range < 8', 'target.infront'}}
	}, outCombat, exeOnLoad)