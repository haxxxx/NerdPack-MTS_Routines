local GUI = {

}

local exeOnLoad = function()
	MTSCR.ExeOnLoad()
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
	{'Cataclysm', 'keybind(shift)', 'mouseover.ground'},
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{ST, {'target.range < 40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(267, '[|cff'..MTSCR.Interface.addonColor..'MTS|r] Warlock - Destro', inCombat, outCombat, exeOnLoad, GUI)