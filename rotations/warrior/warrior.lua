local Keybinds = {
	{'Charge', {
		'keybind(shift)',
		'target.range >= 8',
		'target.range <= 25'
	}, 'target'}
}

local InCombat = {
	{Keybinds},
	{'Victory Rush'},
	{'Execute', 'target.health <= 20'},
	{'Slam'}
}

local OutCombat = {
	{Keybinds}
}

NeP.Engine.registerRotation(1, '[|cff'..MTS.Interface.addonColor..'MTS|r] Warrior - Basic', InCombat, OutCombat, exeOnLoad)