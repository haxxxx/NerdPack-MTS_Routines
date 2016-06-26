local dynEval = NePCR.dynEval
local fetchKey = NeP.Interface.fetchKey

local config = {
	key = "NePConfPalaProt",
	profiles = true,
	title = '|T'..NeP.Interface.Logo..':10:10|t'..NeP.Info.Nick.." Config",
	subtitle = "Paladin Protection Settings",
	color = NeP.Core.classColor('player'),
	width = 250,
	height = 500,
	config = {
    
	-- General
	{ type = 'rule' },
	{ type = 'header', text = "General settings:", align = "center"},
		-- Run Faster
		{ type = "checkbox", text = "Run Faster", key = "RunFaster", default = false , desc =
       "This checkbox enables or disables the use of Speed of Light to move faster."},
       -- Buff Might//Kinds
		{ type = "dropdown",text = "Buff:", key = "Buff", 
	      	list = {
		        {text = "Kings",key = "Kings"},
		        {text = "Might",key = "Might"}
	        },
	       default = "Kings", 
	       desc = "Select What buff to use The moust..." 
       },
		-- Seal
		{ type = "dropdown",text = "Seal:", key = "seal", 
			list = {
				{text = "Insight",key = "Insight"},
				{text = "Righteousness",key = "Righteousness"},
				--[[ FIXME: Was this removed?!
				{text = "Truth",key = "Truth"}]]
			}, 
			default = "Insight", 
			desc = "Select What Seal to use..." 
		},
		-- Seal AoE
		{ type = "dropdown",text = "Seal AoE:", key = "sealAoE", 
			list = {
				{text = "Insight",key = "Insight"},
				{text = "Righteousness",key = "Righteousness"},
				--[[ FIXME: Was this removed?!
				{text = "Truth",key = "Truth"}]]
			}, 
			default = "Righteousness", 
			desc = "Select What Seal to use while in AoE..."
		},

	-- Def CD's
	{ type = 'rule' },
	{ type = 'header', text = 'Defensive Cooldowns Settings:', align = "center"},
		-- Sacred Shield
		{ type = "spinner", text = "Sacred Shield", key = "SacredShield", default = 95},
		-- Ardent Defender
		{ type = "spinner", text = "ArdentDefender", key = "ArdentDefender", default = 30},
		-- Divine Protection
		{ type = "spinner", text = "Divine Protection", key = "DivineProtection", default = 95},
		-- Guardian of Ancient Kings
		{ type = "spinner", text = "Guardian of Ancient Kings", key = "GuardianofAncientKings", default = 50},

	-- Survival
	{ type = 'rule' },
	{ type = 'header', text = 'Survival Settings:', align = "center"},
		-- Healthstone
		{ type = "spinner", text = "Healthstone", key = "Healthstone", default = 60},
		-- Lay on Hands
		{ type = "spinner", text = "Lay on Hands", key = "LayonHands", default = 20},
		-- Eternal Flame
		{ type = "spinner", text = "Eternal Flame", key = "EternalFlame", default = 85},
		-- Word of Glory
		{ type = "spinner", text = "Word of Glory", key = "WordofGlory", default = 40},

	-- Raid Heals
	{ type = 'rule' },
	{ type = 'header', text = 'Survival Settings:', align = "center"},
		{ type = "spinner", text = "Flash of Light", key = "FlashOfLightRaid", default = 40, desc = "Only with 3 stacks of Selfless Healer"},
		{ type = "spinner", text = "Lay on Hands", key = "LayOnHandsRaid", default = 10},
		{ type = "spinner", text = "Hand of Protection", key = "HandOfProtectionRaid", default = 30},
	}
}

NeP.Interface.buildGUI(config)

local exeOnLoad = function()
	NePCR.Splash()
	NeP.Interface.CreateSetting('Class Settings', function() NeP.Interface.ShowGUI('NePConfPalaProt') end)
end


local EmpoweredSeals = {
	{ "31801", { -- Seal of Truth
		"player.seal != 3", 					-- Seal of Truth
		"!player.buff(156990).duration > 3", 	-- Maraad's Truth
		"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
	}},
	{ "20154", { -- Seal of Righteousness
		"player.seal != 1", 					-- Seal of Righteousness
		"!player.buff(156989).duration > 3", 	-- Liadrin's Righteousness
		"player.buff(156990)", 					-- Maraad's Truth
		"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
	}},
	{ "20165", { -- Seal of Insigh
		"player.seal != 2", 					-- Seal of Insigh
		"!player.buff(156988).duration > 3", 	-- Uther's Insight
		"player.buff(156990)", 					-- Maraad's Truth
		"player.buff(156989)", 					-- Liadrin's Righteousness
		"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
	}},
		------------------------------------------------------------------------------ Judgment
	{ "20271", {
		"player.buff(156990).duration < 3", -- Maraad's Truth
		"player.seal = 3"
	}},
	{ "20271", { 
		"player.buff(156989).duration < 3", -- Liadrin's Righteousness
		"player.seal = 1"
	}},
	{ "20271", {
		"player.buff(156988).duration < 3", -- Uther's Insight
		"player.seal = 2"
	}},
}

local Seals = {
	{{ -- AoE
		{ "20165", { -- Seal of Insigh
			"player.seal != 2",
			(function() return fetchKey("NePConfPalaProt", "sealAoE") == 'Insight' end),
		}},
		{ "20154", { -- Seal of Righteousness
			"player.seal != 1",
			(function() return fetchKey("NePConfPalaProt", "sealAoE") == 'Righteousness' end),
		}},
		--[[ FIXME: Was this removed?!
			{ "31801", { -- Seal of truth
				"player.seal != 3",
				(function() return fetchKey("NePConfPalaProt", "sealAoE") == 'Truth' end),
			}},
		]]
	}, 'player.area(40).enemies >= 3' },

	{{ -- Single Target
		{ "20165", { -- Seal of Insigh
			"player.seal != 2",
			(function() return fetchKey("NePConfPalaProt", "seal") == 'Insight' end),
		}},
		{ "20154", { -- Seal of Righteousness
			"player.seal != 1",
			(function() return fetchKey("NePConfPalaProt", "seal") == 'Righteousness' end),
		}},
		--[[ FIXME: Was this removed?!
			{ "31801", { -- Seal of truth
				"player.seal != 1",
				(function() return fetchKey("NePConfPalaProt", "seal") == 'Truth' end),
			}},
		]]
	}, "!player.area(40).enemies >= 3" },
}

local Survival = {
	-- Defensive Cooldowns
	{ "20925", (function() return dynEval("player.health <= "..fetchKey('NePConfPalaProt', 'SacredShield')) end), "player" }, 	-- Sacred Shield
	{ "31850", (function() return dynEval("player.health <= "..fetchKey('NePConfPalaProt', 'ArdentDefender')) end) }, 			-- Ardent Defender
	{ "498", (function() return dynEval("player.health <= "..fetchKey('NePConfPalaProt', 'DivineProtection')) end) }, 			-- Divine Protection
	{ "86659", (function() return dynEval("player.health <= "..fetchKey('NePConfPalaProt', 'GuardianofAncientKings')) end) }, 	-- Guardian of Ancient Kings

	-- Heals
	{ "#5512", (function() return dynEval("player.health <= "..fetchKey('NePConfPalaProt', 'Healthstone')) end) }, 		-- Healthstone
	{ "633", (function() return dynEval("player.health <= "..fetchKey('NePConfPalaProt', 'LayonHands')) end), "player"}, -- Lay on Hands
	{ "114163", { ---------------------------------------------------------------------------------------------------------------- Eternal Flame
		"!player.buff(114163)", 
		"player.buff(114637).count = 5", 
		"player.holypower >= 3",
		(function() return dynEval("player.health <= "..fetchKey('NePConfPalaProt', 'EternalFlame')) end)
	}, "player"},
	{ "85673", { ---------------------------------------------------------------------------------------------------------------- Word of Glory
		"player.buff(114637).count = 5", 
		"player.holypower >= 3",
		(function() return dynEval("player.health <= "..fetchKey('NePConfPalaProt', 'WordofGlory')) end)
	}, "player" },
}

local RaidHeal = {
	{ "Flash of Light", { 
		"player.buff(Selfless Healer).count = 3", 
		(function() return dynEval("lowest.health <= "..fetchKey('NePConfPalaProt', 'FlashOfLightRaid')) end), 
	}, "lowest" },		
	{ "Lay on Hands", (function() return dynEval("lowest.health <= "..fetchKey('NePConfPalaProt', 'LayOnHandsRaid')) end), "lowest" },
	--{ "Hand of Protection", (function() return dynEval("lowest.health <= "..fetchKey('NePConfPalaProt', 'HandOfProtectionRaid')) end), "lowest" },
}

local Cooldowns = {
	-- Avenging Wrath
	{ "31884" },
	-- Holy Avenger
	{ "105809" },
	-- Light´s Hammer
	{ "114158", "target.range <= 30", "target.ground" },
	-- Gloves
	{ "#gloves" },
}

local Seraphim = {
	-- Seraphim
	{ "Seraphim" },
	-- Holy Avenger
	{ "Holy Avenger", {
		"player.holypower < 3",
		"player.buff(Seraphim)",
	}},
}

local All = {
	-- Kings
	{ "20217", {
		"!player.buffs.stats",
		(function() return fetchKey("NePConfPalaProt", "Buff") == 'Kings' end)
	}},
	-- Might
	{ "19740", {
		"!player.buffs.mastery",
		(function() return fetchKey("NePConfPalaProt", "Buff") == 'Might' end)
	}},

	-- Keybinds
	{ "105593", "modifier.control", "target" }, -- Fist of Justice
	{ "853", "modifier.control", "target" }, -- Hammer of Justice
	{ "114158", "modifier.shift", "target.ground" }, -- Light´s Hammer
}

local AoE = {
	-- Hammer of the Righteous
	{ "53595", "target.spell(Crusader Strike).range", "target" },
	-- Avenger's Shield
	{ "31935" }, 
	-- Consecration
	{ "26573", {
		"target.range <= 10", 
		"!player.moving"
	}},
	-- Holy Wrath
	{ "119072", "target.range <= 10" },
}

local InCombat = {
	-- Shield of Righteous
	{ "53600", {
		"target.spell(53600).range", 	-- Spell in range
		"player.holypower > 3"			-- 3 Holy Power
	}, "target" },
	-- Crusader Strike
	{ "35395", "target.spell(35395).range", "target" },
	-- Judgment
	{ "20271", "target.spell(20271).range", "target" },
	-- Avenger´s Shield
	{ "31935", "target.spell(31935).range", "target" },
	-- Hammer of Wrath
	{ "24275", "target.health <= 20", "target" },
	-- Consecration
	{ "26573", "target.range <= 6", "target.ground" },
	-- Holy Wrath
	{ "119072", "target.range <= 10" },
	-- Holy Prism
	{ "114165", {
		"target.spell(114165).range",
		"talent(5, 1)"
	}, "target"},
	-- Execution Sentence
	{ "114157", "target.spell(114157).range", "target" },
}

local outCombat = {
	{All}
}

NeP.Engine.registerRotation(66, '[|cff'..NeP.Interface.addonColor..'NeP|r] Paladin - Protection', 
	{ -- In-Combat
		{All},
		{Survival, "player.health < 100"},
		{RaidHeal},
		{Cooldowns, "modifier.cooldowns"},
		{Seraphim, {"talent(7, 2)", "modifier.cooldowns"}},
		-- Rebuke
		{ "96231", "target.interruptAt(40)" },
		-- ReckoningNeP.Interface.fetchKey
		{ "62124", 'modifier.taunt' }, 
		-- Avenger's Shield // Proc
		{ "31935", "player.buff(Grand Crusader)", "target" },
		{EmpoweredSeals, "talent(7,1)"},
		{Seals, "!talent(7,1)"},
		{AoE, 'player.area(40).enemies >= 3'},
		{InCombat}
	}, outCombat, exeOnLoad)