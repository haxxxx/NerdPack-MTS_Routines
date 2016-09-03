local mKey = 'MTS_PriestHoly'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Priest - Holy Settings',
	color = (function() return NeP.Core.classColor('player') end),
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

local keybinds = {
	{'%pause', 'modifier.shift'},
	{'Angelic Fearther', 'modifier.control'}
}

local SpiritOfRedemption = {
	{'Holy Word: Serenity', 'lowest.health < 50', 'lowest'},
	{'Flash Heal', 'lowest.health < 100', 'lowest'}
}

local FastHeals = {
	{'!Holy Word: Serenity', nil, 'lowest'},
	{'!Flash Heal', nil, 'lowest'}
}

local Tank = {
	{'Holy Word: Serenity', 'tank.health < 30', 'tank'},
	{'Flash Heal', 'tank.health < 60', 'tank'},
	{'Renew', '!tank.buff(Renew)', 'tank'},
	{'Prayer of Healing', 'tank.AoEHeal(60, 4, 20)', 'lowest'},
}

local Player = {
	{'Holy Word: Serenity', 'player.health < 30', 'player'},
	{'Flash Heal', 'player.health < 60', 'player'},
	{'Renew', '!player.buff(Renew)', 'player'},
	{'Prayer of Mending', 'lowest.AoEHeal(90, 3, 20)'},
	{'Prayer of Healing', 'player.AoEHeal(60, 4, 20)', 'lowest'},
}

local Lowest = {
	{'Holy Word: Serenity', 'lowest.health < 25', 'lowest'},
	{'Flash Heal', 'lowest.health < 50', 'lowest'},
	{'Prayer of Mending', 'lowest.AoEHeal(90, 3, 20)'},
	{'Prayer of Healing', 'lowest.AoEHeal(60, 3, 20)', 'lowest'},
	{'Renew', '!lowest.buff(Renew)', 'lowest'},
	{'Heal', nil, 'lowest'}
}

local outCombat = {
	{keybinds},
	{'Renew', {'!lowest.buff(Renew)', 'lowest.health < 100'}, 'lowest'},
	{'Heal', 'lowest.health < 100', 'lowest'},
}

local moving = {
	{'Renew', {'!lowest.buff(Renew)', 'lowest.health < 100'}, 'lowest'}
}

NeP.Engine.registerRotation(257, '[|cff'..MTS.Interface.addonColor..'MTS|r] Priest - Holy', 
	{-- In-Combat
		{keybinds},
		{SpiritOfRedemption, 'player.buff(Spirit of Redemption)'},
		{'Purify', 'dispellAll(Purity)'},
		{{ -- Not moving
			{FastHeals, 'lowest.health < 30'},
			{Tank, 'tank.health < 100'},
			{Player, 'player.health < 100'},
			{Lowest, 'lowest.health < 100'}
		}, '!player.moving' },
		{moving, 'player.moving' }
	},outCombat, lib)