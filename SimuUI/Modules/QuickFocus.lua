-- QuickFocus.lua
-- 마우스 오버 + 키 조합으로 주시 대상 설정

local module = {}
SimuUI.modules["QuickFocus"] = module

local f -- 후킹 프레임

local function ShouldTrigger()
    local modifier = SimuUIDB.profile.QuickFocus.modifier or "ALT"
    if modifier == "ALT" then
        return IsAltKeyDown()
    elseif modifier == "CTRL" then
        return IsControlKeyDown()
    elseif modifier == "SHIFT" then
        return IsShiftKeyDown()
    end
end

local function OnMouseDown(self, button)
    if ShouldTrigger() and UnitExists("mouseover") then
        FocusUnit("mouseover")
    end
end

function module:Enable()
    if f then return end

    f = CreateFrame("Frame", "SimuUIQuickFocusFrame", UIParent)
    f:EnableMouse(true)
    f:SetFrameStrata("TOOLTIP") -- 항상 위에 있도록
    f:SetAllPoints(UIParent)
    f:SetScript("OnMouseDown", OnMouseDown)
end

function module:Disable()
    if f then
        f:SetScript("OnMouseDown", nil)
        f:Hide()
        f = nil
    end
end
