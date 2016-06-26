local dynEval = NePCR.dynEval
local PeFetch = NeP.Interface.fetchKey

local n = GetSpellInfo('5118')

local config = {
	key = 'NePConfigHunterMM',
	profiles = true,
	title = '|T'..NeP.Interface.Logo..':10:10|t'..NeP.Info.Nick..' Config',
	subtitle = 'Hunter Marksmanship Settings',
	color = NeP.Core.classColor('player'),
	width = 250,
	height = 500,
	config = {
		
		-- General
		{type = 'rule'},
		{type = 'header', text = 'General:', align = 'center'},
			--To be added
		
		{type = 'spacer'},{ type = 'rule'},
		{type = 'header', text = 'Survival', align = 'center'},
			
			-- Survival Settings:
			{type = 'spinner', text = 'Healthstone - HP', key = 'Healthstone', default = 75},
	}
}

NeP.Interface.buildGUI(config)

local lib = function()
	NePCR.Splash()
	NeP.Interface.CreateSetting('Class Settings', function() NeP.Interface.ShowGUI('NePConfigHunterMM') end)
	NeP.Interface.CreateToggle(
		'ressPet',
		'Interface\\Icons\\Inv_misc_head_tiger_01.png',
		'Pet Ress',
		'Automatically ress your pet when it dies.')
end

local Keybinds = {
	{'82939', 'modifier.alt', 'target.ground'}, -- Explosive Trap
	{'60192', 'modifier.shift', 'target.ground'}, -- Freezing Trap
	{'82941', 'modifier.shift', 'target.ground'}, -- Ice Trap
}

local Buffs = {
	-- Trap Launcher
	{'77769', '!player.buff(77769)'}, 
}

local Pet = {
	{'/cast Call Pet 1', '!pet.exists'},
  	{{ -- Pet Dead
		{'55709', '!player.debuff(55711)'}, -- Heart of the Phoenix
		{'982'} -- Revive Pet
	}, {'pet.dead', 'toggle.ressPet'}},	
}

local Pet_inCombat = {
	{'53271', 'player.state.stun'}, -- Master's Call
	{'53271', 'player.state.root'}, -- Master's Call
	{'53271', { -- Master's Call
		'player.state.snare', 
		'!player.debuff(Dazed)' 
	}},
	{'53271', 'player.state.disorient'}, -- Master's Call
	{'136', { -- Mend Pet
		'pet.health <= 75', 
		'!pet.buff(136)'
	}}, 
	{'34477', { -- Missdirect // PET 
		'!player.buff(35079)', 
		'!focus.exists', 
		'target.threat > 85' 
	}, 'pet'},
	-- Missdirect // Focus
	{'34477', { 
		'focus.exists', 
		'!player.buff(35079)', 
		'target.threat > 60' 
	}, 'focus'},
}

local Cooldowns = {
	{'82939', nil, 'target.ground'}, -- Explosive Trap
	{'121818', 'player.proc.any'}, -- Stampede
	{'121818', 'player.hashero'}, -- Stampede
	{'121818', 'player.buff(19615).count >= 4'}, --Stampede w/ Frenzy
	{'131894'}, -- A Murder of Crows
	{'3045'}, -- Rapid Fire
	{'Lifeblood'},
	{'Berserking'},
	{'Blood Fury'},
	{'#trinket1'},
	{'#trinket2'},
}

local Survival = {
	{'5384', {'player.aggro >= 100', 'modifier.party', '!player.moving'}}, -- Fake death
	{'109304', 'player.health < 50'}, -- Exhiliration
	{'Deterrence', 'player.health < 10'}, -- Deterrence as a last resort
	{'#109223', 'player.health < 40'}, -- Healing Tonic
	{'#5512', (function() return dynEval('player.health <= ' .. PeFetch('NePConfigHunterMM', 'Healthstone')) end)}, --Healthstone
	{'#109223', 'player.health < 40'}, -- Healing Tonic
}

local focusFire = {	
	{'82692', 'player.buff(19615).count = 5'}, -- Frenzy
	{'!82692', 'player.buff(19615).duration <= 1'}, -- Frenzy
	{'82692', 'player.spell(121818).cooldown >= 260'}, -- Stampede
}

local Loneworlf = {
	-- Dismiss pet if it exists...
	-- Use selected buff from GUI
}

local Interrupts = {
	-- Counter Shot
	{'!147362'},
	-- Intimidation
	{'!19577'},
	-- Wyrven Sting
	{'!19386'},
}

local inCombat = {
	{{ -- Steady Focus // TALENT
		{'Steady Shot', 'player.buff(177667).duration < 3', 'target'}, -- Cobra Shot
	}, {'talent(4,1)', 'lastcast(77767)'} },
	{'157708', '@NePCR.instaKill(35)'},-- Kill Shot
	{'53209'}, -- Chimaera Shot
	{'117050'}, -- Glaive Toss // TALENT
	-- Multi-Shot
	{'2643', {'player.focus > 60', 'player.area(40).enemies >= 3'}, 'target'}, 
	{'19434', 'player.focus > 60', 'target'}, -- Aimed Shot
	{'163485', '!player.moving', 'target'}, -- Focusing Shot // TALENT
	{'Steady Shot'}
}

local outCombat = {
	{Keybinds},
	{Buffs},
	{Pet, '!talent(7, 3)'}
}

NeP.Engine.registerRotation(254, '[|cff'..NeP.Interface.addonColor..'NeP|r] Hunter - Marksmanship',
	{ -- In-Combat
		-- Pause for Feign Death
		{'pause', 'player.buff(5384)'},
		{Keybinds},
		{Buffs},
		{Interrupts, 'target.interruptAt(40)'},
		{{ -- General Conditions
			{Survival, 'player.health < 100'},
			{Cooldowns, 'modifier.cooldowns'},
			{Loneworlf, 'talent(7, 3)'},
			{{ -- Stop if Loneworlf
				--{Pet},
				--{Pet_inCombat, {'player.alive', 'pet.exists'} },
			}, '!talent(7, 3)' },
			{focusFire, { 
				'pet.exists', 
				'!player.buff(Focus Fire)', 
				'!lastcast(Cobra Shot)', 
				'player.buff(19615).count >= 1' 
			}},
			{inCombat, {'target.infront', 'target.range <= 40'}},
		}, '!player.channeling'}
	}, outCombat, lib)