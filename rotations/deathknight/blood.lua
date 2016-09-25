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
	--Blood Boil to maintain Blood Plague.
	{'Blood Boil', '!target.debuff(Blood Plague)'},
	--Death and Decay whenever available. Watch for Crimson Scourge procs.
	
	--Marrowrend to maintain 5 undefined.
	{'Marrowrend'},
	--Blood Boil with 2 charges.
	{'Blood Boil', 'player.spell(Blood Boil).charges >= 2'},
	--Death Strike to dump Runic Power.
	{'Death Strike', 'player.energy >= 75'},
	--Heart Strike as a filler to build Runic Power.
	{'Heart Strike'}
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
	{ST, {'target.range < 8', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(250, '[|cff'..MTSCR.Interface.addonColor..'MTS|r] Death Knight - Beast Blood', inCombat, outCombat, exeOnLoad, GUI)