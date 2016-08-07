local mKey = 'MTS_PriestShadow'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Priest - Shadow Settings',
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


local ouCombat = {

}

NeP.Engine.registerRotation(258, '[|cff'..MTS.Interface.addonColor..'MTS|r] Priest - Shadow', 
	{-- In-Combat

	},ouCombat, lib)