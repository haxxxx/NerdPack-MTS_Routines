local mKey = 'MTS_Mage_Fire'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Mage - Fire Settings',
	color = (function() return NeP.Core.classColor('player') end),
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
	{'%pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(63, '[|cff'..MTS.Interface.addonColor..'MTS|r] Mage - Fire', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Moving, 'player.moving'},
		{Cooldowns, 'modifier.cooldowns'},
		{AoE, {'toggle.AoE', 'player.area(8).enemies >= 3'}},
		{ST, {'target.range <= 40', 'target.infront'}}
	}, outCombat, exeOnLoad)