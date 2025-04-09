local W, F, E, L = unpack((select(2, ...)))
local S = W.Modules.Skins

local abs = abs
local pairs = pairs
local floor = floor

local _G = _G
local LibStub = _G.LibStub

-- Because WoW width is float, we need to round it for comparison
local function isAlmost(a, b)
	return abs(a - b) < 0.1
end

function S:Myslot()
	if not E.private.WT.skins.enable or not E.private.WT.skins.addons.myslot then
		return
	end

	local frame = LibStub("Myslot-5.0").MainFrame
	if not frame then
		return
	end

	frame:StripTextures()
	frame:SetTemplate("Transparent")
	self:CreateShadow(frame)

	for _, child in pairs({ frame:GetChildren() }) do
		local objType = child:GetObjectType()
		if objType == "Button" then
			self:ESProxy("HandleButton", child)
			if isAlmost(child:GetWidth(), 25) and child:GetNumPoints() == 1 then
				local point, relativeTo, relativePoint, xOfs, yOfs = child:GetPoint(1)
				-- Import DropDownBox, Export DropDownBox
				if relativePoint == "RIGHT" then
					xOfs = xOfs + 3
					child:ClearAllPoints()
					child:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
				end
			end
		elseif objType == "EditBox" then
			self:ESProxy("HandleEditBox", child)
		elseif objType == "Frame" then
			if isAlmost(child:GetWidth(), 600) and isAlmost(child:GetHeight(), 455) then
				child:SetBackdrop(nil)
				child:CreateBackdrop("Transparent")
				child.backdrop:SetInside(child, 2, 2)
				for _, subChild in pairs({ child:GetChildren() }) do
					if subChild:GetObjectType() == "ScrollFrame" then
						self:ESProxy("HandleScrollBar", subChild.ScrollBar)
						break
					end
				end
			elseif child.initialize and child.Icon then
				self:ESProxy("HandleDropDownBox", child, 220, nil, true)
				child:ClearAllPoints()
				child:SetPoint("TOPLEFT", frame, 7, -45)
			end
		end
	end
end

S:AddCallbackForAddon("Myslot")
