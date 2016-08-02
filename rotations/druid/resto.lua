local mKey = 'MTSDdResto'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Druid Restoration Settings',
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

local Keybinds = {
	-- Pause
	{'pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(105, '[|cff'..MTS.Interface.addonColor..'MTS|r] Druid - Restoration', 
	{-- In-Combat
		{Keybinds},
	}, outCombat, exeOnLoad)