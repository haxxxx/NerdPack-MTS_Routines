-- Splash stuff
local Splash_Frame = CreateFrame("Frame", "MTS_SPLASH", UIParent)
Splash_Frame:SetPoint("CENTER",0,0)
Splash_Frame:SetSize(100,170)
Splash_Frame:Hide()

local texture = Splash_Frame:CreateTexture()
texture:SetPoint("TOP",0,0)
texture:SetSize(100,100)

local text = Splash_Frame:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont");
text:SetPoint("BOTTOM",0,0)

local callTime = 0

C_Timer.NewTicker(0.01, (function()
	if Splash_Frame:IsShown() then
		if GetTime()-callTime >= 2 then
			local Alpha = Splash_Frame:GetAlpha()
			Splash_Frame:SetAlpha(Alpha-.01)
			if Alpha <= 0 then
				Splash_Frame:Hide()
				Splash_Frame:SetAlpha(1)
			end
		end
	end
end), nil)

local AddonInfo = '|cff'..MTSCR.Interface.addonColor..MTSCR.Name..' V:'..MTSCR.Version

function MTSCR.Splash()
	Splash_Frame:SetAlpha(1)
	Splash_Frame:Show()
	PlaySound('LEVELUP', 'SFX')
	local color = NeP.Core.classColor('player', _type, alpha)
	local currentSpec = GetSpecialization()
	local _, SpecName, _, icon, background = GetSpecializationInfo(currentSpec)
	local class = UnitClass('player')
	texture:SetTexture(icon)
	text:SetText(AddonInfo..'\n|cff'..color..class..' - '..SpecName..' \n|rBy: '..MTSCR.Author)
	callTime = GetTime()
end