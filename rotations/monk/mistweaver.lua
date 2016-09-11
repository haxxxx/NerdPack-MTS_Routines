local mKey = 'MTS_Monk_Mist'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Monk - Mistweaver Settings',
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

local Tank = {

}

local Player = {

}

local Lowest = {

}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(270, '[|cff'..MTS.Interface.addonColor..'MTS|r] Monk - Mistweaver', 
	{-- In-Combat
		{Keybinds},
		{Tank, 'tank.health < 100'},
		{Player, 'player.health < 100'},
		{Lowest, 'lowest.health < 100'},
	}, outCombat, exeOnLoad)