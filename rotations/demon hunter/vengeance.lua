local mKey = 'MTS_DH_veng'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = "Demon Hunter - Vengeance Settings",
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

local Interrupts = {

}

local Cooldowns = {
}

local AoE = {

}

local ST = {

}

local outCombat = {

}

NeP.Engine.registerRotation(581, '[|cff'..MTS.Interface.addonColor..'MTS|r] Demon Hunter - Vengeance', 
	{ -- In-Combat
		{Survival, "player.health < 100"},
		{Interrupts, 'target.interruptsAt(50)'},
		{Cooldowns, "modifier.cooldowns"},
		{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
		{ST, 'target.infront'}
	}, outCombat, exeOnLoad)