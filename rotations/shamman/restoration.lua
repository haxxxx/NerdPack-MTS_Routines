local mKey = 'MTS_ShammanResto'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Shaman - Restoration Settings',
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

local Lowest = {
	{'Purify Spirit', 'dispellAll(Purify Spirit)'},
	--Riptide placed on as many targets as possible. Provides Tidal Waves.
	{'Riptide', 'lowest.buff(Riptide).duration < 5', 'lowest'},
	--Healing Surge is an emergency heal to save players facing death. Consumes Tidal Waves.
	{'Healing Surge', 'lowest.health < 60', 'lowest'},
	--Chain Heal used to heal moderate to high damage. Provides Tidal Waves.
	{'Chain Heal', 'AoEHeal(80, 3)'},
	--Healing Wave used to heal moderate to high damage. Consumes Tidal Waves.
	{'Healing Wave', 'lowest.health < 100', 'lowest'}
}

local Keybinds = {
	-- Pause
	{'pause', 'modifier.alt'},
	--Healing Rain used to heal heavy area damage.
	{'Healing Rain', 'modifier.shift', 'mouseover.ground'}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(264, '[|cff'..MTS.Interface.addonColor..'MTS|r] Shaman - Restoration', 
	{-- In-Combat
		{Keybinds},
		{Lowest, 'lowest.health < 100'}
	}, outCombat, exeOnLoad)