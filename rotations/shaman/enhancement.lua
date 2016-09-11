local mKey = 'MTS_ShamanEnh'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Shaman - Enhancement Settings',
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

}

local Melee = {
	--Flametongue to maintain the buff.
	{'Flametongue', 'target.debuff(Flametongue).duration < 5'},
	--Crash Lightning on cooldown.
	{'Crash Lightning'},
	--Stormstrike whenever available. Watch for Stormbringer procs.
	{'Stormstrike'},
	--Lava Lash to dump excess Maelstrom.
	{'Lava Lash', 'player.maelstrom > 65'},
	--Rockbiter as a filler ability to build Maelstrom.
	{'Rockbiter'}
}

local ST = {
	{Melee, 'target.range < 8' },
	--Lightning Bolt if not in melee range.
	{'Lightning Bolt'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(263, '[|cff'..MTS.Interface.addonColor..'MTS|r] Shaman - Enhancement', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
		{ST, {'target.range < 40', 'target.infront'}}
	}, outCombat, exeOnLoad)