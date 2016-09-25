MTSCR = {
	Version = 0.2,
	Branch = 'BETA',
	Interface = {
		addonColor = 'A330C9',
		Logo = 'Interface\\AddOns\\NerdPack-MTS_Routines\\media\\logo.blp',
		Splash = 'Interface\\AddOns\\NerdPack-MTS_Routines\\media\\splash.blp'
	},
}

-- Core version check
if NeP.Info.Version >= 70.8 then
	NeP.Core.Print('Loaded |T'..MTSCR.Interface.Logo..':10:10|t[|cff'..MTSCR.Interface.addonColor..'MTS|r] Combat-Routines v:'..MTSCR.Version)
else
	NeP.Core.Print('Failed to load MTS Combat Routines.\nYour Core is outdated.')
	return
end

function MTSCR.ExeOnLoad()
	MTSCR.Splash()
	NeP.Interface.CreateToggle(
		'ADots',
		'Interface\\Icons\\Ability_creature_cursed_05.png',
		'Automated Dotting',
		'Click here to dot all the things!')
end