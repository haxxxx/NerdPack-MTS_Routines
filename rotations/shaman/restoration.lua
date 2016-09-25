local GUI = {
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'text', text = 'Alt: PAUSE CR'},
	{type = 'text', text = 'Shift: Healing Rain (CURSOR)'},

	{type = 'ruler'},{type = 'spacer'},
	{type = 'header', text = 'General', align = 'center'},
	{type = 'checkbox', text = 'Use Healing Rain auto with advanced unlockers', key = 'G_HR', default = true},
	{type = 'checkbox', text = 'Use Chain Heal', key = 'G_CH', default = true},
	{type = 'checkbox', text = 'Dispell Everything', key = 'G_DSE', default = true},
	{type = 'spinner', text = 'PANIC! Healing Surge (Health %)', key = 'G_HS', default = 25},
		
	{type = 'ruler'},{type = 'spacer'},
	{type = 'header', text = 'Tank', align = 'center'},
	{type = 'spinner', text = 'Healing Surge (Health %)', key = 'T_HS', default = 40},
		
	{type = 'ruler'},{type = 'spacer'},
	{type = 'header', text = 'Player', align = 'center'},
	{type = 'spinner', text = 'Healing Surge (Health %)', key = 'P_HS', default = 40},
		
	{type = 'ruler'},{type = 'spacer'},
	{type = 'header', text = 'Lowest', align = 'center'},
	{type = 'spinner', text = 'Healing Surge (Health %)', key = 'L_HS', default = 40},
	{type = 'spinner', text = 'Healing Wave (Health %)', key = 'L_HW', default = 100},
}

local exeOnLoad = function()
	MTSCR.ExeOnLoad()
	NeP.Interface.CreateToggle(
  		'dps', 
  		'Interface\\Icons\\Spell_shaman_stormearthfire.png‎', 
  		'Some DPS', 
  		'Do some damage while healing in party/raid.')
end

local DPS = {
	-- flame shock
	{'188838'},
	-- lava burst
	{'51505', {'target.debuff(188838)','playeer.buff(77762)'},'target'},
}

local Fast = {
	{'!Healing Surge', 'lowest.health < UI(G_HS)', 'lowest'},
	{'%dispelall','UI(G_DSE)'},
}

local Totems = {
	{'Healing Stream Totem', 'AoEHeal(80, 3)'}
}

local Tank = {
	--Riptide
	{'Riptide', 'tank.buff(Riptide).duration < 5', 'tank'},
	--Healing Surge
	{'Healing Surge', 'tank.health < UI(T_HS)', 'tank'},
	{{ -- AoE
		-- Healing Rain
		{'Healing Rain', {'UI(G_HR)', 'player.advanced'}, 'tank.ground'},
		--Chain Heal used to heal moderate to high damage. Provides Tidal Waves.
		{'Chain Heal','UI(G_CH)', 'tank'}
	}, {'toggle(AoE)', 'tank.area(40).friendly >= 3', 'AoEHeal(80, 3)'} }
}

local Player = {
	--Riptide
	{'Riptide', 'player.buff(Riptide).duration < 5', 'player'},
	--Healing Surge
	{'Healing Surge', 'lowest.health < UI(P_HS)', 'tank'},
	{{ -- AoE
		-- Healing Rain
		{'Healing Rain', {'UI(G_HR)', 'player.advanced'}, 'player.ground'},
		--Chain Heal used to heal moderate to high damage. Provides Tidal Waves.
		{'Chain Heal','UI(G_CH)', 'player'}
	}, {'toggle(AoE)', 'player.area(40).friendly >= 3', 'AoEHeal(80, 3)'} }
}

local Lowest = {
	--Riptide placed on as many targets as possible. Provides Tidal Waves.
	{'Riptide', 'lowest.buff(Riptide).duration < 5', 'lowest'},
	--Healing Surge is an emergency heal to save players facing death. Consumes Tidal Waves.
	{'Healing Surge', 'lowest.health < UI(L_HS)', 'lowest'},
	
	{{ -- AoE
		-- Healing Rain
		{'Healing Rain', {'UI(G_HR)', 'player.advanced'}, 'lowest.ground'},
		--Chain Heal used to heal moderate to high damage. Provides Tidal Waves.
		{'Chain Heal','UI(G_CH)', 'lowest'}
	}, {'toggle(AoE)', 'lowest.area(40).friendly >= 3', 'AoEHeal(80, 3)'} },
	
	--Healing Wave used to heal moderate to high damage. Consumes Tidal Waves.
	{'Healing Wave', 'lowest.health < UI(L_HW)', 'lowest'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
	--Healing Rain used to heal heavy area damage.
	{'Healing Rain', 'keybind(shift)', 'mouseover.ground'}
}

local inCombat = {
	{Keybinds},
	{Fast},
	{Totems},
	{Tank, {'tank.exists', 'tank.health < 100'}},
	{Player, 'player.health < 100'},
	{Lowest, 'lowest.health < 100'},
	{DPS, 'toggle(dps)'}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(264, '[|cff'..MTSCR.Interface.addonColor..'MTS|r] Shaman - Restoration', inCombat, outCombat, exeOnLoad, GUI)