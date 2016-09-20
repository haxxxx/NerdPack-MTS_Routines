local GUI = {

}

local exeOnLoad = function()
	MTS.Splash()
end

local Survival = {

}

local Cooldowns = {

}

local AoE = {
	--actions.prot_aoe=focused_rage,if=talent.ultimatum.enabled&buff.ultimatum.up&!talent.vengeance.enabled
	--actions.prot_aoe+=/battle_cry,if=(talent.vengeance.enabled&talent.ultimatum.enabled&cooldown.shield_slam.remains<=5-gcd.max-0.5)||!talent.vengeance.enabled
	--actions.prot_aoe+=/demoralizing_shout,if=talent.booming_voice.enabled&buff.battle_cry.up
	--actions.prot_aoe+=/ravager,if=talent.ravager.enabled&buff.battle_cry.up
	--actions.prot_aoe+=/neltharions_fury,if=buff.battle_cry.up
	--actions.prot_aoe+=/shield_slam,if=!(cooldown.shield_block.remains<=gcd.max*2&!buff.shield_block.up&talent.heavy_repercussions.enabled)
	--actions.prot_aoe+=/revenge
	--actions.prot_aoe+=/thunder_clap,if=spell_targets.thunder_clap>=3
	--actions.prot_aoe+=/devastate
}


local ST = {
	--actions.prot=shield_block,if=!buff.neltharions_fury.up&((cooldown.shield_slam.remains<6&!buff.shield_block.up)||(cooldown.shield_slam.remains<6+buff.shield_block.remains&buff.shield_block.up))
	{'Shield Block', '!buff(Neltharions)&{{spell(Shield Slam).cooldown<6&!buff}||{spell(Shield Slam).cooldown<6+buff.duration}}'},
	--actions.prot+=/ignore_pain,if=(rage>=60&!talent.vengeance.enabled)||(buff.vengeance_ignore_pain.up&buff.ultimatum.up)||(buff.vengeance_ignore_pain.up&rage>=30)||(talent.vengeance.enabled&!buff.ultimatum.up&!buff.vengeance_ignore_pain.up&!buff.vengeance_focused_rage.up&rage<30)
	--actions.prot+=/focused_rage,if=(buff.vengeance_focused_rage.up&!buff.vengeance_ignore_pain.up)||(buff.ultimatum.up&buff.vengeance_focused_rage.up&!buff.vengeance_ignore_pain.up)||(talent.vengeance.enabled&buff.ultimatum.up&!buff.vengeance_ignore_pain.up&!buff.vengeance_focused_rage.up)||(talent.vengeance.enabled&!buff.vengeance_ignore_pain.up&!buff.vengeance_focused_rage.up&rage>=30)||(buff.ultimatum.up&buff.vengeance_ignore_pain.up&cooldown.shield_slam.remains=0&rage<10)||(rage>=100)
	{'Focused Rage', '{buff(Focused Rage)&!buff(Ignore Pain)}||{buff(Ultimatum)&buff(Focused Rage)&!buff(Ignore Pain)}||{talent(6,1)&buff(Ultimatum)&!buff(Ignore Pain)&!buff(Focused Rage)}||{talent(6,1)&!buff(Ignore Pain)&!buff(Focused Rage)&rage>=30}||{buff(Ultimatum)&buff(Ignore Pain)&spell(Shield Slam)&rage<10}||{rage>=100}'},
	--actions.prot+=/demoralizing_shout,if=incoming_damage_2500ms>health.max*0.20
	{'Demoralizing Shout', 'incdmg(2.5)>health.max*0.20'},
	--actions.prot+=/shield_wall,if=incoming_damage_2500ms>health.max*0.50
	{'Shield Wall', 'incdmg(2.5)>health.max*0.50'},
	--actions.prot+=/last_stand,if=incoming_damage_2500ms>health.max*0.50&!cooldown.shield_wall.remains=0
	{'Last Stand', 'incdmg(2.5)>health.max*0.50&!spell(Shield Wall).cooldown=0'},
	--actions.prot+=/potion,name=unbending_potion,if=(incoming_damage_2500ms>health.max*0.15&!buff.potion.up)||target.time_to_die<=25
	--actions.prot+=/call_action_list,name=prot_aoe,if=spell_targets.neltharions_fury>=2
	{AoE, 'area(6).enemies>=2'},
	--actions.prot+=/focused_rage,if=talent.ultimatum.enabled&buff.ultimatum.up&!talent.vengeance.enabled
	{'Focused Rage', 'talent(3,2)&buff(Ultimatum)&!talent(6,1)'},
	--actions.prot+=/battle_cry,if=(talent.vengeance.enabled&talent.ultimatum.enabled&cooldown.shield_slam.remains<=5-gcd.max-0.5)||!talent.vengeance.enabled
	{'Battle Cry', '!{talent(6,1)&talent(3,2)&spell(Shield Slam).cooldown<=5-gcd-0.5}||!talent(6,1)'},
	--actions.prot+=/demoralizing_shout,if=talent.booming_voice.enabled&buff.battle_cry.up
	{'Demoralizing Shout', 'talent(6,3)&buff(Battle Cry)'},
	--actions.prot+=/ravager,if=talent.ravager.enabled&buff.battle_cry.up
	{'Ravager', 'buff(Battle Cry)'},
	--actions.prot+=/neltharions_fury,if=incoming_damage_2500ms>health.max*0.20&!buff.shield_block.up
	{'Neltharions Fury', 'incdmg(2.5)>health.max*0.20&!buff(Shield Block)'},
	--actions.prot+=/shield_slam,if=!(cooldown.shield_block.remains<=gcd.max*2&!buff.shield_block.up&talent.heavy_repercussions.enabled)
	{'Shield Slam', '!{spell(Shield Block).cooldown<=gcd*2!&buff&talent(7,2)}'},
	--actions.prot+=/revenge,if=cooldown.shield_slam.remains<=gcd.max*2
	{'Revenge', 'spell(Shield Slam).cooldown<=gcd*2'},
	--actions.prot+=/devastate
	{'Devastate'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{ST, {'target.range < 8', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
	--# Executed before combat begins. Accepts non-harmful actions only.
	--actions.precombat=flask,type=countless_armies
	--actions.precombat+=/food,type=seedbattered_fish_plate
	--actions.precombat+=/augmentation,type=defiled
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--actions.precombat+=/snapshot_stats
	--actions.precombat+=/potion,name=unbending_potion
}

NeP.Engine.registerRotation(73, '[|cff'..MTS.Interface.addonColor..'MTS|r] Warrior - Protection', inCombat, outCombat, exeOnLoad, GUI)