local GUI = {

}

local exeOnLoad = function()
	MTSCR.Splash()
end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(105, '[|cff'..MTSCR.Interface.addonColor..'MTS|r] Druid - Restoration', inCombat, outCombat, exeOnLoad, GUI)