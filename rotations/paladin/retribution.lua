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

local Interupts = {
	{'Rebuke'}
}

local Cooldowns = {
	--actions+=/potion,name=deadly_grace,if=(buff.bloodlust.react|buff.avenging_wrath.up|buff.crusade.up|target.time_to_die<=40)
	--actions+=/use_item,name=faulty_countermeasure,if=(buff.avenging_wrath.up|buff.crusade.up)
	--actions+=/holy_wrath
	{'Holy Wrath'},
	--actions+=/avenging_wrath
	{'Avenging Wrath'},
	--actions+=/crusade,if=holy_power>=5
	{'Crusade', 'player.holypower >= 5'},
	--actions+=/wake_of_ashes,if=holy_power>=0&time<2
	--actions+=/execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.67)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)
	{'Execution Sentence', {
		'player.area(6).enemies <=3', 
		{'spell(Judgment).cooldown < gcd * 4.5', 'or', 'target.debuff(judgment).duration > gcd * 4.5'},
		{'!talent(7,2)', 'or', 'spell(Crusade).cooldown > gcd * 2'}
	},'target'},
	--actions+=/blood_fury
	{'Blood Fury'},
	--actions+=/berserking
	{'berserking'},
	--actions+=/arcane_torrent,if=holy_power<5
	{'Arcane Torrent', 'player.holypower < 5'}
}

local virtues_blade = {
	{{
		{{
			--actions.VB=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
			{'Divine Storm', 'player.buff(Divine Purpose).duration < gcd * 2', 'target'},
			--actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
			{'Divine Storm', {'player.holypower >= 5', 'player.buff(Divine Purpose)'}, 'target'},
			--actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
			{'Divine Storm', 'player.holypower >= 5', {'!talent(7,2)', 'or', 'spell(Crusade).cooldown > gcd * 3'}, 'target'},
		}, 'player.area(6).enemies >= 2' },
		--actions.VB+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
		{'Justicar\'s Vengeance', {'player.buff(Divine Purpose)', '!equipped(Whisper of the Nathrezim)'}, 'target'},
		--actions.VB+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
			-- NOT NEEDED!
		--actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
		{'Templar\'s Verdict', 'player.buff(Divine Purpose).duration < gcd * 2', 'target'},
		--actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
		{'Templar\'s Verdict', {'player.holypower >= 5', 'player.buff(Divine Purpose)'}, 'target'},
		--actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
		{'Templar\'s Verdict', {'player.holypower >= 5', {'!talent(7,2)', 'spell(Crusade).cooldown > gcd * 3'}}, 'target'},
		{{
			--actions.VB+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
			{'Divine Storm', {
				'player.area(6).enemies >= 2',
				{'spell(Wake of Ashes).duration < gcd * 2', 'or', 'player.buff(Whisper of the Nathrezim).duration < gcd'},
				{'!talent(7,2)', 'or', 'spell(Crusade).duration > gcd * 4'}
			}, 'target' },
			--actions.VB+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
			{'Justicar\'s Vengeance', {'spell(Wake of Ashes).duration < gcd * 2', '!equipped(Whisper of the Nathrezim)'}},
			--actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
			{'Templar\'s Verdict', {
				{'spell(Wake of Ashes).duration < gcd * 2', 'or', 'player.buff(Whisper of the Nathrezim).duration < gcd'},
				{'!talent(7,2)', 'or', 'spell(Crusade).cooldown > gcd * 4'}
			}, 'target', },
		}, 'player.holypower >= 3'},
	}, 'target.debuff(Judgment)' },
	--actions.VB+=/wake_of_ashes,if=holy_power=0|holy_power=1&cooldown.blade_of_justice.remains>gcd|holy_power=2&(cooldown.zeal.charges_fractional<=0.34|cooldown.crusader_strike.charges_fractional<=0.34)
	{'Wake of Ashes', {
		'player.holypower == 0', 'or', 'player.holypower = 1', 'spell(Blade of Justice).cooldown > gcd', 'or', 'player.holypower = 2',
		{'spell(Zeal).charges <= 0.34', 'or', 'spell(Crusader Strike).charges <= 0.34'}
	}},
	--actions.VB+=/zeal,if=charges=2&holy_power<=4
	{'Zeal', {'spell.charges = 2', 'player.holypower <= 4'}},
	--actions.VB+=/crusader_strike,if=charges=2&holy_power<=4
	{'Crusader Strike', {'spell.charges = 2', 'player.holypower <= 4'}},
	--actions.VB+=/blade_of_justice,if=holy_power<=2|(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34))
	{'Blade of Justice', {
		'player.holypower <= 2', 'or',
		{'player.holypower <= 3', {'spell(Zeal).charges <= 1.34', 'or', 'spell(Crusader Strike).charges <= 1.34'}}
	}},
	--actions.VB+=/judgment,if=holy_power>=3|((cooldown.zeal.charges_fractional<=1.67|cooldown.crusader_strike.charges_fractional<=1.67)&cooldown.blade_of_justice.remains>gcd)|(talent.greater_judgment.enabled&target.health.pct>50)
	{'Judgment', {
		'player.holypower >= 3', 'or',
		{{'spell(Zeal).charges <= 1.67', 'or', 'spell(Crusader Strike).charges <= 1.67'}, 'spell(Blade of Justice).cooldown > gcd'},
		'or', {'talent(2,3)', 'target.health > 50'}
	},'target'},
	--actions.VB+=/consecration
	{'Consecration'},
	{{
		--actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
		{'Divine Storm', {'player.area(6).enemies >= 2', 'player.buff(Divine Purpose)'}},
		--actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
		{'Divine Storm', {
			'player.area(6).enemies >= 2', 'player.buff(The Fires of Justice)', 
			{'!talent(7,2)', 'or', 'spell(Crusade).cooldown > gcd * 3'}
		}},
		--actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=4&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
		{'Divine Storm', {
			'player.area(6).enemies >= 2', 'player.holypower >= 4', 
			{'!talent(7,2)', 'or', 'spell(Crusade).cooldown > gcd * 4'}
		}},
		--actions.VB+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
		{'Justicar\'s Vengeance', {'player.buff(Divine Purpose)', '!equipped(Whisper of the Nathrezim)'}},
		--actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
		{'Templar\'s Verdict', 'player.buff(Divine Purpose)', 'target'},
		--actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
		{'Templar\'s Verdict', {'player.buff(The Fires of Justice)', {'!talent(7,2)', 'or', 'spell(Crusade).cooldown > gcd * 3'}}, 'target'},
		--actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=4&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
		{'Templar\'s Verdict', {'player.holypower >= 4', {'!talent(7,2)', 'or', 'spell(Crusade).cooldown > gcd * 4'}}, 'target'},
	},'target.debuff(Judment)'},
	--actions.VB+=/zeal,if=holy_power<=4
	{'Zeal', 'player.holypower <= 4'},
	--actions.VB+=/crusader_strike,if=holy_power<=4
	{'Crusader Strike', 'player.holypower <= 4'},
	{{
		--actions.VB+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
		{'Divine Storm', 'player.area(6).enemies >= 2', 'target'},
		--actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
		{'Templar\'s Verdict'},
	}, {'target.debuff(Judgment)', 'player.holypower >= 3', {'!talent(7,2)', 'or', 'spell(Crusade).cooldown > gcd * 5'}}},
}

local blade_of_wrath = {
	--actions.BoW=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	--actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
	--actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	--actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	--actions.BoW+=/wake_of_ashes,if=holy_power=0|holy_power=1&cooldown.blade_of_wrath.remains>gcd|holy_power=2&(cooldown.zeal.charges_fractional<=0.67|cooldown.crusader_strike.charges_fractional<=0.67)
	--actions.BoW+=/zeal,if=charges=2&holy_power<=4
	--actions.BoW+=/crusader_strike,if=charges=2&holy_power<=4&!talent.the_fires_of_justice.enabled
	--actions.BoW+=/blade_of_wrath,if=holy_power<=2|(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34))
	--actions.BoW+=/crusader_strike,if=charges=2&holy_power<=4&talent.the_fires_of_justice.enabled
	--actions.BoW+=/judgment
	--actions.BoW+=/consecration
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	--actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	--actions.BoW+=/zeal,if=holy_power<=4
	--actions.BoW+=/crusader_strike,if=holy_power<=4
}

local divine_hammer = {
	--actions.DH=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	--actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
	--actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	--actions.DH+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
	--actions.DH+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	--actions.DH+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	--actions.DH+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	--actions.DH+=/wake_of_ashes,if=holy_power<=1
	--actions.DH+=/zeal,if=charges=2&holy_power<=4
	--actions.DH+=/crusader_strike,if=charges=2&holy_power<=4
	--actions.DH+=/divine_hammer,if=holy_power<=3
	--actions.DH+=/judgment
	--actions.DH+=/consecration
	--actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
	--actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
	--actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*6)
	--actions.DH+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*6)
	--actions.DH+=/zeal,if=holy_power<=4
	--actions.DH+=/crusader_strike,if=holy_power<=4
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybinds(alt)'},
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

local inCombat = {
	{Keybinds},
	{Interupts, 'target.interruptAt(45)'},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{{
		--actions+=/call_action_list,name=VB,if=talent.virtues_blade.enabled
		{virtues_blade, 'talent(4,1)'},
		--actions+=/call_action_list,name=BoW,if=talent.blade_of_wrath.enabled
		{blade_of_wrath, 'talent(4,2)'},
		--actions+=/call_action_list,name=DH,if=talent.divine_hammer.enabled
		{divine_hammer, 'talent(4,3)'}
	},{'target.range < 8', 'target.infront'}}
	
}

NeP.Engine.registerRotation(70, '[|cff'..MTS.Interface.addonColor..'MTS|r] Paladin - Retribution', inCombat, outCombat, exeOnLoad)