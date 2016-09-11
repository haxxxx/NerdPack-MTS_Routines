local mKey = 'MTSPalaProt'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = "Paladin Protection Settings",
	color = (function() return NeP.Core.classColor('player') end),
	width = 250,
	height = 500,
	config = {
    	{type = 'spinner', text = 'Lay on Hands (Health %)', key = 'P_LH', default = 20},
    	{type = 'spinner', text = 'Divine Protection (Health %)', key = 'P_DP', default = 90},
    	{type = 'spinner', text = 'Ardent Defender (Health %)', key = 'P_AD', default = 30},
    	{type = 'spinner', text = 'Light of the Protector (Health %)', key = 'P_LP', default = 30}
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
	{'Light of the Protector', (function() return E('player.health <= '..F('P_LP')) end)},
	{'Lay on Hands', (function() return E('player.health <= '..F('P_LH')) end)},
	{'Divine Protection', (function() return E('player.health <= '..F('P_DP')) end)},
	{'Ardent Defender', (function() return E('player.health <= '..F('P_AD')) end)}
}

local Interrupts = {
	{'Rebuke'}
}

local Cooldowns = {
}

local AoE = {
	--Consecration on cooldown.
	{'Consecration', 'target.range <= 5'},
	--Hammer of the Righteous while standing in Consecration.
	{'Hammer of the Righteous', 'player.buff(Consecration)'}
}

local ST = {
	--Shield of the Righteous to reduce damage taken.
	{'Shield of the Righteous', {
		'!player.buff(Shield of the Righteous)', 
		'player.health < 90',
		'player.buff(Consecration)'
	}},
	{'Shield of the Righteous', {
		'!player.buff(Shield of the Righteous)', 
		'player.health < 60',
	}},
	--Judgment on cooldown to further reduce the cooldown of Shield of the Righteous.
	{'Judgment'},
	--Hammer of the Righteous when available to proc Grand Crusader.
	{'Hammer of the Righteous', '!player.buff(Grand Crusader)'},
	--Avenger's Shield with or without Grand Crusader.
	{'Avenger\'s Shield'},
	--Consecration on cooldown.
	{'Consecration', 'target.range <= 5'}
}

local outCombat = {

}

NeP.Engine.registerRotation(66, '[|cff'..MTS.Interface.addonColor..'MTS|r] Paladin - Protection', 
	{ -- In-Combat
		{Survival, "player.health < 100"},
		{Interrupts, 'target.interruptsAt(50)'},
		{Cooldowns, "toggle(cooldowns)"},
		{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
		{ST, 'target.infront'}
	}, outCombat, exeOnLoad)