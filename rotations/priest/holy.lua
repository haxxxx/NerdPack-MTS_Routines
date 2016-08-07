local mKey = 'MTS_PriestHoly'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Priest - Holy Settings',
	color = NeP.Core.classColor('player'),
	width = 250,
	height = 500,
	config = {
   
	}
}

local E = MTS.dynEval
local F = function(key) return NeP.Interface.fetchKey(mKey, key, 100) end

local lib = function()
	MTS.Splash()
	NeP.Interface.buildGUI(config)
	MTS.ClassSetting(mKey)
end

local Lowest = {

}

local ouCombat = {

}

NeP.Engine.registerRotation(257, '[|cff'..MTS.Interface.addonColor..'MTS|r] Priest - Holy', 
	{-- In-Combat
		{Lowest}
	},ouCombat, lib)