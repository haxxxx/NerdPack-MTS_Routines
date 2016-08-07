local mKey = 'MTS_ShamanEle'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Shaman - Elemental Settings',
	color = NeP.Core.classColor('player'),
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
	--Earthquake Totem maintained at all times.
	{'Earthquake Totem', nil, 'target.ground'},
	--Earth Shock when you have >= 80 Maelstrom.
	{'Earth Shock', 'player.maelstrom >= 80'},
	--Chain Lightning as a filler and to build Maelstrom.
	{'Chain Lightning'}
}

local ST = {
	--Flame Shock to maintain the DoT with 20 Maelstrom refreshes.
	{'Flame Shock', {
		'target.debuff(Flame Shock),duration < 5',
		'player.maelstrom >= 20'
	}},
	--Lava Burst when available. Watch for Lava Surge procs.
	{'Lava Burst'},
	--Earth Shock when you have >= 80 Maelstrom.
	{'Earth Shock', 'player.maelstrom >= 80'},
	--Lightning Bolt as a filler spell and to build Maelstrom.
	{'Lightning Bolt'}
}

local Keybinds = {
	-- Pause
	{'pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(262, '[|cff'..MTS.Interface.addonColor..'MTS|r] Shaman - Elemental', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{AoE, {'toggle.AoE', 'player.area(40).enemies >= 3'}},
		{ST, {'target.range < 40', 'target.infront'}}
	}, outCombat, exeOnLoad)