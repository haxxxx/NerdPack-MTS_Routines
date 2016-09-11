local mKey = 'MTS_RogueAssassination'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Rogue - Assassination Settings',
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
	{'Vendetta'}
}

local InCombat = {
	-- Poisons
	{'Deadly Poison', '!player.buff(Deadly Poison)'},
	{'Crippling Poison', '!player.buff(Crippling Poison)'},
	--Rupture maintained with 5 Combo Points.
	{'Rupture', {'player.combopoints >= 5', 'target.debuff(Rupture).duration < 5'}},
	--Garrote to maintain the DoT.
	{'Garrote', '!target.debuff(Garrote)'},
	--Envenom to dump excess Combo Points.
	{'Envenom', 'player.combopoints >= 5'},
	--Mutilate or  to build Combo Points.
	{'Fan of Knives', {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{'Mutilate'},
}

local Keybinds = {
	-- Pause
	--{'%pause', 'keybind.alt'},
}

local outCombat = {
	{Keybinds},
	-- Poisons
	{'Deadly Poison', '!player.buff(Deadly Poison)'},
	{'Crippling Poison', '!player.buff(Crippling Poison)'},
}

NeP.Engine.registerRotation(259, '[|cff'..MTS.Interface.addonColor..'MTS|r] Rogue - Assassination', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'toggle(cooldowns)'},
		{InCombat, {'target.range < 8', 'target.infront'}}
	}, outCombat, exeOnLoad)