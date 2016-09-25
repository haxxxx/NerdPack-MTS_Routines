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
	--Keg Smash on cooldown.
	{'Keg Smash'},
	--Breath of Fire on cooldown.
	{'Breath of Fire'},
	--Expel Harm when you can use the heal and have 3 or more spheres.
	--{'Expel Harm'},
	--Blackout Strike on cooldown.
	{'Blackout Strike'},
	--Tiger Palm to dump Energy.
	{'Tiger Palm', 'player.energy > 75'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
	{'Summon Black Ox Statue', 'keybind(shift)', 'mouseover.ground'}
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{ST, {'target.range < 8', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(268, '[|cff'..MTSCR.Interface.addonColor..'MTS|r] Monk - Brewmaster', inCombat, outCombat, exeOnLoad, GUI)