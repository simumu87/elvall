if(select(2, UnitClass('player')) ~= 'DRUID') then return end

local _, ns = ...
local oUF = ns.oUF

local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitHasVehicleUI = UnitHasVehicleUI
local GetShapeshiftFormID = GetShapeshiftFormID
local GetPrimaryTalentTree = GetPrimaryTalentTree
local GetEclipseDirection = GetEclipseDirection

local POWERTYPE_BALANCE = Enum.PowerType.Balance
local MOONKIN_FORM = MOONKIN_FORM

local function Update(self, event, unit, powerType)
	if(self.unit ~= unit or (event == 'UNIT_POWER' and powerType ~= 'ECLIPSE')) then return end

	local element = self.EclipseBar
	if(element.PreUpdate) then element:PreUpdate(unit) end

	local CUR = UnitPower('player', POWERTYPE_BALANCE)
	local MAX = UnitPowerMax('player', POWERTYPE_BALANCE)

	if(element.LunarBar) then
		element.LunarBar:SetMinMaxValues(-MAX, MAX)
		element.LunarBar:SetValue(CUR)
	end

	if(element.SolarBar) then
		element.SolarBar:SetMinMaxValues(-MAX, MAX)
		element.SolarBar:SetValue(CUR * -1)
	end

	if(element.PostUpdate) then
		return element:PostUpdate(unit, CUR, MAX, event)
	end
end

local function Path(self, ...)
	return (self.EclipseBar.Override or Update) (self, ...)
end

local function EclipseDirection(self, event, status)
	local element = self.EclipseBar

	element.direction = status

	if(element.PostDirectionChange) then
		return element:PostDirectionChange(status)
	end
end

local function EclipseDirectionPath(self, ...)
	return (self.EclipseBar.OverrideEclipseDirection or EclipseDirection) (self, ...)
end

local function ElementEnable(self)
	self:RegisterEvent('UNIT_POWER_FREQUENT', Path)

	self.EclipseBar:Show()
	EclipseDirectionPath(self, 'ElementEnable', GetEclipseDirection())

	if self.EclipseBar.PostUpdateVisibility then
		self.EclipseBar:PostUpdateVisibility(true, not self.EclipseBar.isEnabled)
	end

	self.EclipseBar.isEnabled = true

	Path(self, 'ElementEnable', 'player', POWERTYPE_BALANCE)
end

local function ElementDisable(self)
	self:UnregisterEvent('UNIT_POWER_FREQUENT', Path)

	self.EclipseBar:Hide()

	if self.EclipseBar.PostUpdateVisibility then
		self.EclipseBar:PostUpdateVisibility(false, self.EclipseBar.isEnabled)
	end

	self.EclipseBar.isEnabled = nil

	Path(self, 'ElementDisable', 'player', POWERTYPE_BALANCE)
end

local function Visibility(self)
	local shouldEnable

	if not UnitHasVehicleUI('player') then
		local form = GetShapeshiftFormID()
		local ptt = GetPrimaryTalentTree()

		if ptt and ptt == 1 and (form == MOONKIN_FORM or not form) then
			shouldEnable = true
		end
	end

	if(shouldEnable) then
		ElementEnable(self)
	else
		ElementDisable(self)
	end
end

local function VisibilityPath(self, ...)
	return (self.EclipseBar.OverrideVisibility or Visibility) (self, ...)
end

local function ForceUpdate(element)
	EclipseDirectionPath(element.__owner, 'ForceUpdate', GetEclipseDirection())
	return VisibilityPath(element.__owner, 'ForceUpdate', element.__owner.unit, 'ECLIPSE')
end

local function Enable(self, unit)
	local element = self.EclipseBar
	if(element and unit == 'player') then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent('ECLIPSE_DIRECTION_CHANGE', EclipseDirectionPath, true)

		oUF:RegisterEvent(self, 'PLAYER_TALENT_UPDATE', VisibilityPath, true)
		oUF:RegisterEvent(self, 'UPDATE_SHAPESHIFT_FORM', VisibilityPath, true)

		if(element.LunarBar and element.LunarBar:IsObjectType('StatusBar') and not element.LunarBar:GetStatusBarTexture()) then
			element.LunarBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end
		if(element.SolarBar and element.SolarBar:IsObjectType('StatusBar') and not element.SolarBar:GetStatusBarTexture()) then
			element.SolarBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end

		return true
	end
end

local function Disable(self)
	local element = self.EclipseBar
	if(element) then
		ElementDisable(self)

		self:UnregisterEvent('ECLIPSE_DIRECTION_CHANGE', EclipseDirectionPath)

		oUF:UnregisterEvent(self, 'PLAYER_TALENT_UPDATE', VisibilityPath)
		oUF:UnregisterEvent(self, 'UPDATE_SHAPESHIFT_FORM', VisibilityPath)
	end
end

oUF:AddElement('EclipseBar', VisibilityPath, Enable, Disable)
