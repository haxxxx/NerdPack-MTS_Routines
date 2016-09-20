local GUI = {

}
local exeOnLoad = function()
	MTS.Splash()
end

local Survival = {

}

local Cooldowns = {
	--Combustion Use on cooldown.
	{'Combustion'}
}

local AoE = {

}

local ST = {
	--Rune of Power with 2 charges (if selected).
	{'Rune of Power', 'player.spell(Rune of Power).charges >= 2'},
	--Pyroblast with Hot Streak.
	{'Pyroblast', 'player.buff(Hot Streak)'},
	--Meteor when available (if selected).
	{'Meteor'},
	--Flame On when available and you have no Fire Blast charges (if selected).
	{'Flame On', 'player.spell(Fire Blast).charges = 0'},
	--Dragon's Breath if you can safely cast.
	{'Dragon\'s Breath'},
	--Fire Blast with Heating Up proc.
	{'Fire Blast', 'player.buff(Heating Up)'},
	--Fire Blast with 2 charges.
	{'Fire Blast', 'player.spell(Fire Blast).charges >= 2'},
	--Fireball as a filler spell.
	{'Fireball'}
}

local Moving = {
	--Scorch as a filler spell when moving.
	{'Scorch'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Moving, 'player.moving'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{ST, {'target.range <= 40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(63, '[|cff'..MTS.Interface.addonColor..'MTS|r] Mage - Fire', inCombat, outCombat, exeOnLoad, GUI)