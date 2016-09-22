local GUI = {

}

local exeOnLoad = function()
	MTS.Splash()
end

local Survival = {

}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local Finisher = {
	--# Use Savage Roar if it's expired and you're at 5 combo points or are about to use Brutal Slash
	--actions.finisher=pool_resource,for_next=1
	--actions.finisher+=/savage_roar,if=!buff.savage_roar.up&(combo_points=5|(talent.brutal_slash.enabled&spell_targets.brutal_slash>desired_targets&action.brutal_slash.charges>0))
	--# Thrash has higher priority than finishers at 5 targets
	--actions.finisher+=/pool_resource,for_next=1
	--actions.finisher+=/thrash_cat,cycle_targets=1,if=remains<=duration*0.3&spell_targets.thrash_cat>=5
	--# Replace Rip with Swipe at 8 targets
	--actions.finisher+=/pool_resource,for_next=1
	--actions.finisher+=/swipe_cat,if=spell_targets.swipe_cat>=8
	--# Refresh Rip at 8 seconds or for a stronger Rip
	--actions.finisher+=/rip,cycle_targets=1,if=(!ticking|(remains<8&target.health.pct>25&!talent.sabertooth.enabled)|persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die-remains>tick_time*4&combo_points=5&(energy.time_to_max<1|buff.berserk.up|buff.incarnation.up|buff.elunes_guidance.up|cooldown.tigers_fury.remains<3|set_bonus.tier18_4pc|buff.clearcasting.react|talent.soul_of_the_forest.enabled|!dot.rip.ticking|(dot.rake.remains<1.5&spell_targets.swipe_cat<6))
	--# Refresh Savage Roar early with Jagged Wounds
	--actions.finisher+=/savage_roar,if=(buff.savage_roar.remains<=10.5|(buff.savage_roar.remains<=7.2&!talent.jagged_wounds.enabled))&combo_points=5&(energy.time_to_max<1|buff.berserk.up|buff.incarnation.up|buff.elunes_guidance.up|cooldown.tigers_fury.remains<3|set_bonus.tier18_4pc|buff.clearcasting.react|talent.soul_of_the_forest.enabled|!dot.rip.ticking|(dot.rake.remains<1.5&spell_targets.swipe_cat<6))
	--# Replace FB with Swipe at 6 targets for Bloodtalons or 3 targets otherwise.
	--actions.finisher+=/swipe_cat,if=combo_points=5&(spell_targets.swipe_cat>=6|(spell_targets.swipe_cat>=3&!talent.bloodtalons.enabled))&combo_points=5&(energy.time_to_max<1|buff.berserk.up|buff.incarnation.up|buff.elunes_guidance.up|cooldown.tigers_fury.remains<3|set_bonus.tier18_4pc|(talent.moment_of_clarity.enabled&buff.clearcasting.react))
	--actions.finisher+=/ferocious_bite,max_energy=1,cycle_targets=1,if=combo_points=5&(energy.time_to_max<1|buff.berserk.up|buff.incarnation.up|buff.elunes_guidance.up|cooldown.tigers_fury.remains<3|set_bonus.tier18_4pc|(talent.moment_of_clarity.enabled&buff.clearcasting.react))
}

local Generator = {
	--# Brutal Slash if there's adds up
	--actions.generator=brutal_slash,if=spell_targets.brutal_slash>desired_targets&combo_points<5
	--actions.generator+=/ashamanes_frenzy,if=combo_points<=2&buff.elunes_guidance.down&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(buff.savage_roar.up|!talent.savage_roar.enabled)
	--# Pool energy for Elune's Guidance when it's coming off cooldown.
	--actions.generator+=/pool_resource,if=talent.elunes_guidance.enabled&combo_points=0&energy<action.ferocious_bite.cost+25-energy.regen*cooldown.elunes_guidance.remains
	--actions.generator+=/elunes_guidance,if=talent.elunes_guidance.enabled&combo_points=0&energy>=action.ferocious_bite.cost+25
	--# Spam Thrash over Rake or Moonfire at 9 targets with Brutal Slash talent.
	--actions.generator+=/pool_resource,for_next=1
	--actions.generator+=/thrash_cat,if=talent.brutal_slash.enabled&spell_targets.thrash_cat>=9
	--# Use Swipe over Rake or Moonfire at 6 targets.
	--actions.generator+=/pool_resource,for_next=1
	--actions.generator+=/swipe_cat,if=spell_targets.swipe_cat>=6
	--# Shadowmeld to buff Rake
	--actions.generator+=/shadowmeld,if=combo_points<5&energy>=action.rake.cost&dot.rake.pmultiplier<2.1&buff.tigers_fury.up&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(!talent.incarnation.enabled|cooldown.incarnation.remains>18)&!buff.incarnation.up
	--# Refresh Rake early with Bloodtalons
	--actions.generator+=/pool_resource,for_next=1
	--actions.generator+=/rake,cycle_targets=1,if=combo_points<5&(!ticking|(!talent.bloodtalons.enabled&remains<duration*0.3)|(talent.bloodtalons.enabled&buff.bloodtalons.up&(!talent.soul_of_the_forest.enabled&remains<=7|remains<=5)&persistent_multiplier>dot.rake.pmultiplier*0.80))&target.time_to_die-remains>tick_time
	--actions.generator+=/moonfire_cat,cycle_targets=1,if=combo_points<5&remains<=4.2&target.time_to_die-remains>tick_time*2
	--actions.generator+=/pool_resource,for_next=1
	--actions.generator+=/thrash_cat,cycle_targets=1,if=remains<=duration*0.3&spell_targets.swipe_cat>=2
	--# Brutal Slash if you would cap out charges before the next adds spawn
	--actions.generator+=/brutal_slash,if=combo_points<5&((raid_event.adds.exists&raid_event.adds.in>(1+max_charges-charges_fractional)*15)|(!raid_event.adds.exists&(charges_fractional>2.66&time>10)))
	--actions.generator+=/swipe_cat,if=combo_points<5&spell_targets.swipe_cat>=3
	--actions.generator+=/shred,if=combo_points<5&(spell_targets.swipe_cat<3|talent.brutal_slash.enabled)
	{'Shred', 'combopoints<5&{area(8).enemies<3||talent(7,1)}'}
}

local Opener = {
	--# Hard-cast a Healing Touch for Bloodtalons buff. Use Dash to re-enter Cat Form.
	--actions.sbt_opener=healing_touch,if=talent.bloodtalons.enabled&combo_points=5&!buff.bloodtalons.up&!dot.rip.ticking
	--# Force use of Tiger's Fury before applying Rip.
	--actions.sbt_opener+=/tigers_fury,if=!dot.rip.ticking&combo_points=5
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	--# Executed every time the actor is available.
	--actions=dash,if=!buff.cat_form.up
	--actions+=/cat_form
	--actions+=/wild_charge
	--actions+=/displacer_beast,if=movement.distance>10
	--actions+=/dash,if=movement.distance&buff.displacer_beast.down&buff.wild_charge_movement.down
	--actions+=/rake,if=buff.prowl.up|buff.shadowmeld.up
	--actions+=/auto_attack
	--actions+=/skull_bash
	--actions+=/berserk,if=buff.tigers_fury.up
	--actions+=/incarnation,if=cooldown.tigers_fury.remains<gcd
	--actions+=/use_item,slot=trinket2,if=(buff.tigers_fury.up&(target.time_to_die>trinket.stat.any.cooldown|target.time_to_die<45))|buff.incarnation.remains>20
	--actions+=/potion,name=deadly_grace,if=((buff.berserk.remains>10|buff.incarnation.remains>20)&(target.time_to_die<180|(trinket.proc.all.react&target.health.pct<25)))|target.time_to_die<=40
	--actions+=/tigers_fury,if=(!buff.clearcasting.react&energy.deficit>=60)|energy.deficit>=80|(t18_class_trinket&buff.berserk.up&buff.tigers_fury.down)
	--actions+=/incarnation,if=energy.time_to_max>1&energy>=35
	--# Keep Rip from falling off during execute range.
	--actions+=/ferocious_bite,cycle_targets=1,if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>3&(target.health.pct<25|talent.sabertooth.enabled)
	--# Use Healing Touch at 5 Combo Points, if Predatory Swiftness is about to fall off, at 2 Combo Points before Ashamane's Frenzy, before Elune's Guidance is cast or before the Elune's Guidance buff gives you a 5th Combo Point.
	--actions+=/healing_touch,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&(combo_points>=5|buff.predatory_swiftness.remains<1.5|(talent.bloodtalons.enabled&combo_points=2&buff.bloodtalons.down&cooldown.ashamanes_frenzy.remains<gcd)|(talent.elunes_guidance.enabled&((cooldown.elunes_guidance.remains<gcd&combo_points=0)|(buff.elunes_guidance.up&combo_points>=4))))
	--actions+=/call_action_list,name=sbt_opener,if=talent.sabertooth.enabled&time<20
	{Opener, 'talent(6,1)&combat.time<20'},
	--# Special logic for Ailuro Pouncers legendary.
	--actions+=/healing_touch,if=equipped.ailuro_pouncers&talent.bloodtalons.enabled&buff.predatory_swiftness.stack>1&buff.bloodtalons.down
	--actions+=/call_action_list,name=finisher
	{Finisher},
	--actions+=/call_action_list,name=generator
	{Generator}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(103, '[|cff'..MTS.Interface.addonColor..'MTS|r] Druid - Feral', inCombat, outCombat, exeOnLoad, GUI)