local GUI = {

}

local exeOnLoad = function()
	MTSCR.ExeOnLoad()
end

local keybinds = {
	{'%pause', 'keybind(shift)'},
	{'Angelic Feather', 'keybind(control)', 'mouseover.ground'}
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
	{'Prayer of Mending', 'tank.AoEHeal(90, 3, 20)', 'tank'},
	{'Prayer of Healing', 'tank.AoEHeal(60, 4, 20)', 'lowest'},
}

local Player = {
	{'Holy Word: Serenity', 'player.health < 30', 'player'},
	{'Flash Heal', 'player.health < 60', 'player'},
	{'Renew', '!player.buff(Renew)', 'player'},
	{'Prayer of Healing', 'player.AoEHeal(60, 4, 20)', 'lowest'},
}

local Lowest = {
	{'Holy Word: Serenity', 'lowest.health < 25', 'lowest'},
	{'Flash Heal', 'lowest.health < 50', 'lowest'},
	{'Prayer of Healing', 'lowest.AoEHeal(60, 3, 20)', 'lowest'},
	{'Renew', '!lowest.buff(Renew)', 'lowest'},
	{'Heal', nil, 'lowest'}
}

local Moving = {
	{'Renew', {'!lowest.buff(Renew)', 'lowest.health < 100'}, 'lowest'}
}

local inCombat = {
	{keybinds},
	{SpiritOfRedemption, 'buff(Spirit of Redemption)'},
	{'%dispelAll'},
	{{ -- Not moving
		{FastHeals, 'lowest.health < 30'},
		{Tank, 'tank.health < 100'},
		{Player, 'health < 100'},
		{Lowest, 'lowest.health < 100'}
	}, '!moving' },
	{Moving}
}

local outCombat = {
	{keybinds},
	{{ -- Not moving
		{'Renew', {'!lowest.buff(Renew)', 'lowest.health < 100'}, 'lowest'},
		{'Heal', 'lowest.health < 100', 'lowest'},
	}, '!moving' },
}

NeP.Engine.registerRotation(257, '[|cff'..MTSCR.Interface.addonColor..'MTS|r] Priest - Holy', inCombat, outCombat, exeOnLoad, GUI)