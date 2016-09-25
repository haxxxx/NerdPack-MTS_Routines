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

-- Splash stuff
local Splash_Frame = CreateFrame("Frame", "MTS_SPLASH", UIParent)
Splash_Frame:SetPoint("CENTER",0,0)
Splash_Frame:SetSize(600,300)
Splash_Frame:Hide()
local texture = Splash_Frame:CreateTexture()
texture:SetAllPoints(Splash_Frame)
texture:SetTexture(MTSCR.Interface.Splash)
C_Timer.NewTicker(0.01, (function()
	if Splash_Frame:IsShown() then
		local Alpha = Splash_Frame:GetAlpha()
		Splash_Frame:SetAlpha(Alpha-.01)
		if Alpha <= 0 then
			Splash_Frame:Hide()
			Splash_Frame:SetAlpha(1)
		end
	end
end), nil)

function MTSCR.ExeOnLoad()
	NeP.Interface.CreateToggle(
		'ADots',
		'Interface\\Icons\\Ability_creature_cursed_05.png',
		'Automated Dotting',
		'Click here to dot all the things!')
	Splash_Frame:SetAlpha(1)
	Splash_Frame:Show()
	PlaySound('LEVELUP', 'SFX')
end