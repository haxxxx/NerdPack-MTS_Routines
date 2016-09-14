local mKey = 'MTS_DH_havoc'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = "Demon Hunter - Havoc Settings",
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
	{'Blur', 'player.health <= 60'}
}

local Interrupts = {
	{'Consume Magic'}
}

local Keybinds = {
	{'%pause', 'keybind(alt)'},
	{(function() print('hit') end), 'keybind(lshift)'}
}

local Cooldowns = {
	{'Metamorphosis', nil, 'target.ground'}
}

local inCombat = {
	{'Vengeful Retreat', {'target.range <= 6', 'player.spell(Fel Rush).charges >= 2', 'player.fury <= 85'}},
	{'Fel Rush', {'player.spell(Fel Rush).charges >= 2', 'target.range > 5'}},
	{'Blade Dance', {'toggle(AoE)', 'player.area(8).enemies >= 4'}},
	{'Chaos Strike', 'player.fury >= 70'},
	{'Demon\'s Bite'},
}

local outCombat = {
	{'#trinket1'},
	{Keybinds}
}

NeP.Engine.registerRotation(577, '[|cff'..MTS.Interface.addonColor..'MTS|r] Demon Hunter - Havoc', 
	{ -- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Interrupts, 'target.interruptAt(50)'},
		{Cooldowns, 'toggle(cooldowns)'},
		{inCombat, 'target.infront'}
	}, outCombat, exeOnLoad)