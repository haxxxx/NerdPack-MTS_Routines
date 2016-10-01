local GUI = {

}

local exeOnLoad = function()
	MTSCR.ExeOnLoad()
end

local Survival = {

}


local ST = {
	--actions=auto_attack
	--actions+=/skull_bash
	--actions+=/blood_fury
	{'Blood Fury'},
	--actions+=/berserking
	{'Berserking'},
	--actions+=/arcane_torrent
	{'Arcane Torrent'},
	--actions+=/use_item,slot=trinket2
	{'#trinket2'},
	--actions+=/barkskin
	{'barkskin'},
	--actions+=/bristling_fur,if=buff.ironfur.remains<2&rage<40
	{'Bristling Fur', 'buff(Ironfur).duration<2&rage<40'},
	--actions+=/ironfur,if=buff.ironfur.down|rage.deficit<25
	{'Ironfur', '!buff'}
	--actions+=/frenzied_regeneration,if=!ticking&incoming_damage_6s%health.max>0.25+(2-charges_fractional)*0.15
	--actions+=/pulverize,cycle_targets=1,if=buff.pulverize.down
	--actions+=/mangle
	{'Mangle'}
	--actions+=/pulverize,cycle_targets=1,if=buff.pulverize.remains<gcd
	--actions+=/lunar_beam
	{'Lunar Beam'}
	--actions+=/incarnation
	{'Incarnation'}
	--actions+=/thrash_bear,if=active_enemies>=2
	{'Trash', 'area(6).enemies>=2'},
	--actions+=/pulverize,cycle_targets=1,if=buff.pulverize.remains<3.6
	--actions+=/thrash_bear,if=talent.pulverize.enabled&buff.pulverize.remains<3.6
	--actions+=/moonfire,cycle_targets=1,if=!ticking
	--actions+=/moonfire,cycle_targets=1,if=remains<3.6
	--actions+=/moonfire,cycle_targets=1,if=remains<7.2
	--actions+=/moonfire
	{'Moonfire'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{ST, {'target.range < 8', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(104, '[|cff'..MTSCR.Interface.addonColor..'MTS|r] Druid - Guardian', inCombat, outCombat, exeOnLoad, GUI)