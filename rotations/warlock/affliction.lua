local GUI = {

}

local exeOnLoad = function()
	MTSCR.ExeOnLoad()
end

local Survival = {

}

local ST = {
	--actions=reap_souls,if=actions=reap_souls,if=!buff.deadwind_harvester.remains&(buff.soul_harvest.remains|buff.tormented_souls.react>=8|target.time_to_die<=buff.tormented_souls.react*5|trinket.proc.any.react)
	--actions+=/soul_effigy,if=!pet.soul_effigy.active
	--actions+=/agony,if=remains<=tick_time+gcd
	--actions+=/agony,target=soul_effigy,if=remains<=tick_time+gcd
	--actions+=/service_pet,if=dot.corruption.remains&dot.agony.remains
	--actions+=/summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<3
	--actions+=/summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>=3
	--actions+=/berserking
	--actions+=/blood_fury
	--actions+=/arcane_torrent
	--actions+=/soul_harv,est
	{'Soul Harvest'},
	--actions+=/potion,name=deadly_grace,if=buff.soul_harvest.remains|trinket.proc.any.react|target.time_to_die<=45
	--actions+=/corruption,if=remains<=tick_time+gcd
	--actions+=/siphon_life,if=remains<=tick_time+gcd
	--actions+=/corruption,target=soul_effigy,if=remains<=tick_time+gcd
	--actions+=/siphon_life,target=soul_effigy,if=remains<=tick_time+gcd
	--actions+=/mana_tap,if=buff.mana_tap.remains<=buff.mana_tap.duration*0.3&(mana.pct<20|buff.mana_tap.remains<=gcd)&target.time_to_die>buff.mana_tap.duration*0.3
	--actions+=/phantom_singularity
	{'Phantom Singularity'},
	--actions+=/unstable_affliction,if=talent.contagion.enabled|(soul_shard>=4|trinket.proc.intellect.react|trinket.stacking_proc.mastery.react|trinket.proc.mastery.react|trinket.proc.crit.react|trinket.proc.versatility.react|buff.soul_harvest.remains|buff.deadwind_harvester.remains|buff.compounding_horror.react=5|target.time_to_die<=20)
	--actions+=/agony,if=remains<=duration*0.3&target.time_to_die>=remains
	{'Agony', 'target.debuff.duration<spell.duration*0.3&target.ttd>target.debuff.duration'},
	--actions+=/agony,target=soul_effigy,if=remains<=duration*0.3&target.time_to_die>=remains
	--actions+=/corruption,if=remains<=duration*0.3&target.time_to_die>=remains
	{'Corruption', 'target.debuff.duration<spell.duration*0.3&target.ttd>target.debuff.duration'},
	--actions+=/haunt
	{'Haunt'},
	--actions+=/siphon_life,if=remains<=duration*0.3&target.time_to_die>=remains
	--actions+=/corruption,target=soul_effigy,if=remains<=duration*0.3&target.time_to_die>=remains
	--actions+=/siphon_life,target=soul_effigy,if=remains<=duration*0.3&target.time_to_die>=remains
	--actions+=/life_tap,if=mana.pct<=10
	{'Life Tap', 'mana<10'},
	--actions+=/drain_soul,chain=1,interrupt=1
	{'Drain Soul'},
	--actions+=/drain_life,chain=1,interrupt=1
	{'Drain Life'},
	--actions+=/life_tap
	{'Life Tap'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{ST, {'target.range < 40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(265, '[|cff'..MTSCR.Interface.addonColor..'MTS|r] Warlock - Affliction', inCombat, outCombat, exeOnLoad, GUI)