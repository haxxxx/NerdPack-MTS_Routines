local mKey = 'MTS_PriestDisc'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Priest - Discipline Settings',
	color = (function() return NeP.Core.classColor('player') end),
	width = 250,
	height = 500,
	config = {
   
	}
}

local E = MTS.dynEval
local F = function(key) return NeP.Interface.fetchKey(mKey, key, 100) end

local lib = function()
	MTS.Splash()
	NeP.Interface.buildGUI(config)
	MTS.ClassSetting(mKey)
end

local Atonement = {
	--Shadow Word: Pain for a low to moderate HoT to your Atonement targets.
	{'Shadow Word: Pain', 'target.debuff(Shadow Word: Pain).duration < 5', 'target'},
	--Penance on cooldown for low to moderate healing to your Atonement targets.
	{'Penance', nil, 'target'},
	--Smite for low to moderate healing to your Atonement targets.
	{'Smite', nil, 'target'}
}

local Lowest = {
	--Power Word: Shield Use to absorb low to moderate damage and to apply Atonement.
	{'Power Word: Shield', '!lowest.buff(Power Word: Shield)'},
	-- Penance if talent "Penitent"
	{'Penance', {'lowest.health < 70', 'talent(1,1)'}, 'target'},
	--Plea for an efficient direct heal and to apply Atonement.
	{'Plea', 'lowest.health < 30'}
}

local outCombat = {

}

NeP.Engine.registerRotation(256, '[|cff'..MTS.Interface.addonColor..'MTS|r] Priest - Discipline', 
	{-- In-Combat
		{Lowest, 'lowest.health < 100'},
		{Atonement}
	},outCombat, lib)