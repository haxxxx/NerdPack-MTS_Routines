local mKey = 'MTSDdBlc'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Druid Balance Settings',
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
	{'Celestial Alignment'}
}

local AoE = {
	--Sunfire and Moonfire maintained at all times.
	{'Sunfire', 'target.debuff(Sunfire).duration < 5'},
	{'Moonfire', 'target.debuff(Moonfire).duration < 5'},
	--Starfall to dump Astral Power and apply Stellar Empowerment.
	{'Starfall', nil, 'target.ground'},
	--Lunar Strike as your Astral Power builder
	{'Lunar Strike'}
}

local ST = {
	--Sunfire and Moonfire maintained at all times.
	{'Sunfire', 'target.debuff(Sunfire).duration < 5'},
	{'Moonfire', 'target.debuff(Moonfire).duration < 5'},
	--Starsurge to dump Astral Power and build Lunar Empowerment and Solar Empowerment.
	{'Starsurge', 'player.energy >= 65'},
	--Solar Wrath to consume Solar Empowerment.
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	--Lunar Strike to consume Lunar Empowerment.
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
	--Solar Wrath as a filler spell and to build Astral Power when no Empowerments are present.
	{'Solar Wrath'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybinds(alt)'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(102, '[|cff'..MTS.Interface.addonColor..'MTS|r] Druid - Balance', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'toggle(cooldowns)'},
		{AoE, {'toggle(AoE)', 'player.area(40).enemies >= 3'}},
		{ST, {'target.range < 40', 'target.infront'}}
	}, outCombat, exeOnLoad)