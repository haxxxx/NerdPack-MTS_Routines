-- Splash stuff
local Splash_Frame = CreateFrame("Frame", "MTS_SPLASH", UIParent)
Splash_Frame:SetPoint("CENTER",0,0)
Splash_Frame:SetSize(600,320)
Splash_Frame:Hide()

local texture = Splash_Frame:CreateTexture()
texture:SetPoint("TOP",0,0)
texture:SetSize(600,300)
texture:SetTexture(MTSCR.Interface.Splash)

local text = Splash_Frame:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont");
text:SetPoint("BOTTOM",0,0)

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

function MTSCR.Splash()
	Splash_Frame:SetAlpha(1)
	Splash_Frame:Show()
	PlaySound('LEVELUP', 'SFX')
	local color = NeP.Core.classColor('player', _type, alpha)
	local currentSpec = GetSpecialization()
	local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"
	local class = UnitClass('player')
	text:SetText('|cff'..color..class..' - '..currentSpecName)
end