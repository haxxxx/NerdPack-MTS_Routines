local Keybinds = {
	{'Charge', {
		'keybinds(shift)',
		'target.range >= 8',
		'target.range <= 25'
	}, 'target'}
}

NeP.Engine.registerRotation(1, '[|cff'..MTS.Interface.addonColor..'MTS|r] Warrior - Basic', 
{-- In-Combat CR
	{Keybinds},
	{'Victory Rush'},
	{'Execute', 'target.health <= 20'},
	{'Slam'}
},{-- Ouside of combat
	{Keybinds}
}, exeOnLoad)