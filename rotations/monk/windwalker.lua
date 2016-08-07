local mKey = 'MTSMonkWind'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Monk Windwalker Settings',
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

}

local ST = {
	--Fists of Fury on cooldown with >= 3 Chi.
	{'Fists of Fury', {
		'target.infront',
		'player.chi >=3'
	}},
	--Blackout Kick with proc from Combo Breaker proc.
	{'Blackout Kick', 'player.buff(Combo Breaker proc)'},
	--Rising Sun Kick when available.
	{'Rising Sun Kick'},
	--Blackout Kick to dump additional Chi.
	{'Blackout Kick'},
	--Tiger Palm as default Chi builder and to proc Combo Breaker.
	{'Tiger Palm'}
}

local Keybinds = {
	-- Pause
	{'pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(269, '[|cff'..MTS.Interface.addonColor..'MTS|r] Monk - Windwalker', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{AoE, {'toggle.AoE', 'player.area(8).enemies >= 3'}},
		{ST, {'target.range < 8', 'target.infront'}}
	}, outCombat, exeOnLoad)