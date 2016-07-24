local mKey = 'MTSMonkBrew'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Monk Brewmaster Settings',
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

}

local AoE = {

}

local ST = {
	--Keg Smash on cooldown.
	{'Keg Smash'},
	--Breath of Fire on cooldown.
	{'Breath of Fire'},
	--Expel Harm when you can use the heal and have 3 or more spheres.
	--{'Expel Harm'},
	--Blackout Strike on cooldown.
	{'Blackout Strike'},
	--Tiger Palm to dump Energy.
	{'Tiger Palm', 'player.energy > 75'}
}

local Keybinds = {
	-- Pause
	{'pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(268, '[|cff'..MTS.Interface.addonColor..'MTS|r] Monk - Brewmaster', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{AoE, 'player.area(8).enemies >= 3'},
		{ST}
	}, outCombat, exeOnLoad)