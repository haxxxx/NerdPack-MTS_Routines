<<<<<<< HEAD
=======
local E = MTS.dynEval
local F = function(key) NeP.Interface.fetchKey('NePConfPalaRet', key) end

>>>>>>> origin/master
local config = {
	key = 'MTSPalaRet',
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Paladin Retribution Settings',
	color = NeP.Core.classColor('player'),
	width = 250,
	height = 500,
	config = {
		
	}
}

NeP.Interface.buildGUI(config)
local E = MTS.dynEval
local F = function(key) NeP.Interface.fetchKey('MTSPalaRet', key) end

local exeOnLoad = function()
	MTS.Splash()
	NeP.Interface.CreateSetting('Class Settings', function() NeP.Interface.ShowGUI('MTSPalaRet') end)
end

local Buffs = {
	-- Greater Blessing of Wisdom
	{'203539', '!player.buff(203539).any', 'player'},
	-- Greater Blessing of Might
	{'203528', '!player.buff(203528).any', 'player'},
	-- Greater Blessing of Kings
	{'203538', '!player.buff(203538).any', 'player'}
}

local Survival = {
	{'Lay on Hands', 'player.health <= 20'},
	--{'Flash of Light', 'player.health <= 40'},
}

local Cooldowns = {
	{'Crusade'}
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
	{Buffs},
	{Seals},
}

NeP.Engine.registerRotation(70, '[|cff'..MTS.Interface.addonColor..'MTS|r] Paladin - Retribution', 
	{-- In-Combat
		{Buffs},
		{Keybinds},
		{All},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{AoE, 'player.area(8).enemies >= 3'},
		{ST}
	}, outCombat, exeOnLoad)