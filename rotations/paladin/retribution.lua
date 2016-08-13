local mKey = 'MTSPalaRet'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Paladin Retribution Settings',
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
	{'Lay on Hands', 'player.health <= 20'},
	--{'Flash of Light', 'player.health <= 40'},
}

local Cooldowns = {
	{'Crusade'},
	{'Avenging Wrath'}
}

local AoE = {
	--Divine Storm to spend Holy Power.
	{'Divine Storm'}
}

local ST = {
	--Templar's Verdict with >= 5 Holy Power.
	{'Templar\'s Verdict', 'player.holypower >= 5'},
	--Judgment to build Holy Power.
	{'Judgment'},
	--Blade of Justice with 3 or less Holy Power.
	{'Blade of Justice', 'player.holypower <= 3'},
	--Crusader Strike with 4 or less Holy Power.
	{'Crusader Strike', 'player.holypower <= 4'}
}

local Keybinds = {
	-- Pause
	{'pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
	-- Greater Blessing of Wisdom
	{'203539', '!player.buff(203539).any', 'player'},
	-- Greater Blessing of Might
	{'203528', '!player.buff(203528).any', 'player'},
	-- Greater Blessing of Kings
	{'203538', '!player.buff(203538).any', 'player'}
}

NeP.Engine.registerRotation(70, '[|cff'..MTS.Interface.addonColor..'MTS|r] Paladin - Retribution', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{AoE, {'toggle.AoE', 'player.area(8).enemies >= 3'}},
		{ST, {'target.range < 8', 'target.infront'}}
	}, outCombat, exeOnLoad)