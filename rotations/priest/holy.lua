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

local SpiritOfRedemption = {
	{'Holy Word: Serenity', 'lowest.health < 50', 'lowest'},
	{'Flash Heal', 'lowest.health < 100', 'lowest'},
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
	{'Prayer of Healing', 'player.AoEHeal(60, 4, 20)', 'lowest'},
}

local Lowest = {
	{'Holy Word: Serenity', 'lowest.health < 25', 'lowest'},
	{'Flash Heal', 'lowest.health < 50', 'lowest'},
	{'Prayer of Healing', 'lowest.AoEHeal(60, 4, 20)', 'lowest'},
	{'Renew', '!lowest.buff(Renew)', 'lowest'},
	--{'Prayer of Mending', 'lowest.health < 100'},
	{'Heal', 'lowest.health < 100', 'lowest'}
}

local outCombat = {
	{'Renew', {'!lowest.buff(Renew)', 'lowest.health < 100'}, 'lowest'},
	{'Heal', 'lowest.health < 100', 'lowest'},
}

local moving = {
	{'Renew', {'!lowest.buff(Renew)', 'lowest.health < 100'}, 'lowest'}
}

NeP.Engine.registerRotation(257, '[|cff'..MTS.Interface.addonColor..'MTS|r] Priest - Holy', 
	{-- In-Combat
		{SpiritOfRedemption, 'player.buff(Spirit of Redemption)'},
		{{ -- Not moving
			{Tank, 'tank.health < 100'},
			{Player, 'player.health < 100'},
			{Lowest, 'lowest.health < 100'}
		}, '!player.moving' },
		{moving, 'player.moving' }
	},outCombat, lib)