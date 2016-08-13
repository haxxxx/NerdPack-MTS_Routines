local mKey = 'MTS_PriestShadow'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Priest - Shadow Settings',
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

local Voidform = {
	--Void Bolt on cooldown.
	{'!Void Eruption'},
	--Shadow Word: Death when available on targets with <= 20% health.
	{'Shadow Word: Death', 'target.health <= 20'},
	--Mind Blast on cooldown.
	{'Mind Blast'},
	--Mind Flay as a filler.
	{'Mind Flay'}
}

local ST = {
	--Void Eruption at 100 Insanity to activate Voidform.
	{'Void Eruption', 'player.insanity >= 100'},
	--Shadow Word: Pain maintained at all times.
	{'Shadow Word: Pain', 'target.debuff(Shadow Word: Pain).duration < 5'},
	--Vampiric Touch maintained at all times.
	{'Vampiric Touch', 'target.debuff(Vampiric Touch).duration < 5'},
	--Shadow Word: Death when available on targets with <= 20% health.
	{'Shadow Word: Death', 'target.health <= 20'},
	--Mind Blast on cooldown to build Insanity.
	{'Mind Blast'},
	--Mind Flay as a filler to build Insanity.
	{'Mind Flay'}
}

local outCombat = {

}

NeP.Engine.registerRotation(258, '[|cff'..MTS.Interface.addonColor..'MTS|r] Priest - Shadow', 
	{-- In-Combat
		{Voidform, 'player.buff(Voidform)'},
		{ST, '!player.buff(Voidform)'}
	},outCombat, lib)