local mKey = 'MTSDKBlood'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Death Knight Blood! Settings',
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

local ST = {
	--Blood Boil to maintain Blood Plague.
	{'Blood Boil', '!target.debuff(Blood Plague)'},
	--Death and Decay whenever available. Watch for Crimson Scourge procs.
	
	--Marrowrend to maintain 5 undefined.
	{'Marrowrend'},
	--Blood Boil with 2 charges.
	{'Blood Boil', 'player.spell(Blood Boil).charges >= 2'},
	--Death Strike to dump Runic Power.
	{'Death Strike', 'player.energy >= 75'},
	--Heart Strike as a filler to build Runic Power.
	{'Heart Strike'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(250, '[|cff'..MTS.Interface.addonColor..'MTS|r] Death Knight - Beast Blood', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'toggle(cooldowns)'},
		{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
		{ST, {'target.range < 8', 'target.infront'}}
	}, outCombat, exeOnLoad)