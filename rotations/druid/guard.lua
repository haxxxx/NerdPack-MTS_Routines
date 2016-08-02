local mKey = 'MTSDdGuard'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Druid Guardian Settings',
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