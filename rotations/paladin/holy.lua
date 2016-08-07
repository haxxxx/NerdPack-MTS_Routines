local mKey = 'MTSPalaHoly'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Paladin Holy Settings',
	color = NeP.Core.classColor('player'),
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

local Lowest = {
	--Beacon of Light maintain on your primary target at all times.
	{'Beacon of Light', '!tank.buff(Beacon of Light)', 'tank'},
	{'Beacon of Faith', '!tank2.buff(Beacon of Faith)', 'tank2'},
	{{--Consume Infusion of Light procs using the appropriate heal before your next Holy Shock
		{'Flash of Light', 'lowest.health < 60', 'lowest'},
		{'Holy Light', 'lowest.health < 100', 'lowest'}
	}, 'player.buff(Infusion of Light)' },
	{'Light of Dawn', {'toggle.AoE', 'AoEHeal(80, 3, 15)'}},
	--Holy Shock use on cooldown to generate Infusion of Light procs.
	{'Holy Shock', 'lowest.health < 100', 'lowest'},
	--Light of the Martyr a potent emergency heal as long as you heave health to spare.
	{'Light of the Martyr', {
		'player.health > 40',
		'lowest.health < 30'
	}, 'lowest'},
	--Flash of Light use as an emergency heal to save players facing death.
	{'Flash of Light', 'lowest.health < 50', 'lowest'},
	--Holy Light use to heal moderate to high damage.
	{'Holy Light', 'lowest.health < 100', 'lowest'}
}

local ouCombat = {
	{'Holy Light', 'lowest.health < 100', 'lowest'}
}

NeP.Engine.registerRotation(65, '[|cff'..MTS.Interface.addonColor..'MTS|r] Paladin - Holy', 
	{-- In-Combat
		{'Cleanse', 'dispellAll(Cleanse)'},
		{Lowest}
	},ouCombat, lib)