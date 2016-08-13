local mKey = 'MTSDdGuard'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Druid Guardian Settings',
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
	--Mangle whenever available to generate Rage. Watch for Gore procs.
	{'Mangle'},
	--Thrash on cooldown.
	{'Thrash'},
	--Moonfire on as many targets as possible.
	{'Moonfire', 'target.debuff(Moonfire).duration < 5'},
	--Swipe as often as possible.
	{'Swipe'}
}

local ST = {
	--Mangle whenever available to generate Rage. Watch for Gore procs.
	{'Mangle'},
	--Thrash on cooldown.
	{'Thrash'},
	--Moonfire to maintain the DoT.
	{'Moonfire', 'target.debuff(Moonfire).duration < 5'},
	--Maul to dump excess Rage
	{'Maul'}
}

local Keybinds = {
	-- Pause
	{'pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(104, '[|cff'..MTS.Interface.addonColor..'MTS|r] Druid - Guardian', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{AoE, {'toggle.AoE', 'player.area(8).enemies >= 3'}},
		{ST, {'target.range < 8', 'target.infront'}}
	}, outCombat, exeOnLoad)