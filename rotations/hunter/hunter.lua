local inCombat = {
	{'Mend Pet', 'pet.health < 100'},
	{'Kill Command', 'target.petrange < 25'},
	{'Cobra Shot'}
}

local outCombat = {
	
}

NeP.Engine.registerRotation(3, '[|cff'..MTSCR.Interface.addonColor..'MTS|r] Hunter - Basic', inCombat, outCombat)