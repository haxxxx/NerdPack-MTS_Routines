local GUI = {

}

local exeOnLoad = function()
	MTSCR.Splash()
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
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{ST, {'target.range <= 40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(64, '[|cff'..MTSCR.Interface.addonColor..'MTS|r] Mage - Frost', inCombat, outCombat, exeOnLoad, GUI)