MTSCR = {
	Version = 0.2,
	Branch = 'BETA',
	Interface = {
		addonColor = 'A330C9',
		Logo = NeP.Interface.Logo -- Temp until i get a logo
	},
}

-- Core version check
if NeP.Info.Version >= 70.8 then
	NeP.Core.Print('Loaded |T'..MTSCR.Interface.Logo..':10:10|t[|cff'..MTSCR.Interface.addonColor..'MTS|r] Combat-Routines v:'..MTSCR.Version)
else
	NeP.Core.Print('Failed to load MTS Combat Routines.\nYour Core is outdated.')
	return
end

local F = NeP.Interface.fetchKey

function MTSCR.Splash()
	NeP.Interface.CreateToggle(
		'ADots',
		'Interface\\Icons\\Ability_creature_cursed_05.png',
		'Automated Dotting',
		'Click here to dot all the things!')
end