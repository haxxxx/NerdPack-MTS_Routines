local mKey = 'MTSPalaHoly'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Paladin Holy Settings',
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

local FastHeals = {
	--{'Cleanse', 'dispellAll(Cleanse)'},
	{{--Consume Infusion of Light procs using the appropriate heal before your next Holy Shock
		{'Flash of Light', 'lowest.health < 60', 'lowest'},
		{'Holy Light', 'lowest.health < 100', 'lowest'}
	}, 'player.buff(Infusion of Light)' },
	--Holy Shock use on cooldown to generate Infusion of Light procs.
	{'Holy Shock', 'lowest.health < 100', 'lowest'},
	--Light of the Martyr a potent emergency heal as long as you heave health to spare.
	{'Light of the Martyr', {
		'player.health > 40',
		'lowest.health < 30'
	}, 'lowest'},
}

local Tank = {
	--Beacon of Light maintain on your primary target at all times.
	{'Beacon of Light', '!tank.buff(Beacon of Light)', 'tank'},
	{'Beacon of Faith', '!tank2.buff(Beacon of Faith)', 'tank2'},
}

local Moving = {
	{'Bestow Faith', 'lowest.health < 100', 'lowest'},
	--Holy Shock use on cooldown to generate Infusion of Light procs.
	{'Holy Shock', 'lowest.health < 100', 'lowest'},
}

local Lowest = {
	{'Light of Dawn', {'toggle.AoE', 'HealInfront(80, 2, 15)'}},
	--Flash of Light use as an emergency heal to save players facing death.
	{'Flash of Light', 'lowest.health < 50', 'lowest'},
	--Holy Light use to heal moderate to high damage.
	{'Holy Light', 'lowest.health < 100', 'lowest'}
}

local outCombat = {
	{Moving},
	{{ -- Not moving
		{'Holy Light', 'lowest.health < 100', 'lowest'}
	}, '!player.moving' },
}

NeP.Engine.registerRotation(65, '[|cff'..MTS.Interface.addonColor..'MTS|r] Paladin - Holy', 
	{-- In-Combat
		{{ -- Not moving
			{FastHeals},
			{Tank},
			{Lowest, 'lowest.health < 100'}
		}, '!player.moving' },
		{Moving}
	}, outCombat, lib)