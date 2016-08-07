local mKey = 'MTSPalaProt'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = "Paladin Protection Settings",
	color = NeP.Core.classColor('player'),
	width = 250,
	height = 500,
	config = {
    	{type = 'spinner', text = 'Lay on Hands (Health %)', key = 'P_LH', default = 15},
    	{type = 'spinner', text = 'Divine Protection (Health %)', key = 'P_DP', default = 90},
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
	{'Lay on Hands', (function() return E('player.health <='..F('P_LH')) end)},
	{'Divine Protection', (function() return E('player.health <='..F('P_DP')) end)}
}

local Cooldowns = {
	{'Ardent Defender', 'player.health < 30'}
}

local AoE = {
	--Consecration on cooldown.
	{'Consecration', 'target.range < 8'},
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
	--Light of the Protector as needed for self-healing.
	{'Light of the Protector', {'player.health < 95', 'player.buff(Consecration)'}},
	{'Light of the Protector', 'player.health < 60'},
	--Judgment on cooldown to further reduce the cooldown of Shield of the Righteous.
	{'Judgment'},
	--Hammer of the Righteous when available to proc Grand Crusader.
	{'Hammer of the Righteous', '!player.buff(Grand Crusader)'},
	--Avenger's Shield with or without Grand Crusader.
	{'Avenger\'s Shield'},
	--Consecration on cooldown.
	{'Consecration', 'target.range < 8'}
}

local outCombat = {

}

NeP.Engine.registerRotation(66, '[|cff'..MTS.Interface.addonColor..'MTS|r] Paladin - Protection', 
	{ -- In-Combat
		{Survival, "player.health < 100"},
		{Cooldowns, "modifier.cooldowns"},
		{AoE, {'toggle.AoE', 'player.area(8).enemies >= 3'}},
		{ST, {'target.range < 8', 'target.infront'}}
	}, outCombat, exeOnLoad)