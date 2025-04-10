-- SimuUI/Options/options.lua
local options = CreateFrame("Frame", "SimuUIOptionsPanel", UIParent, "BasicFrameTemplateWithInset")
options:SetSize(300, 200)
options:SetPoint("CENTER")
options.title = options:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
options.title:SetPoint("TOP", 0, -10)
options.title:SetText("SimuUI 설정")

-- 기본적으로는 숨김
options:Hide()
SimuUI.OptionsPanel = options

local db = SimuUIDB.profile

-- ✅ KeyStyle 모듈 체크박스
local keyStyleCheckbox = CreateFrame("CheckButton", nil, options, "InterfaceOptionsCheckButtonTemplate")
keyStyleCheckbox:SetPoint("TOPLEFT", 20, -40)
keyStyleCheckbox.Text:SetText("단축키 축약 활성화")
keyStyleCheckbox:SetChecked(db.KeyStyle.enabled)

keyStyleCheckbox:SetScript("OnClick", function(self)
    db.KeyStyle.enabled = self:GetChecked()

    if SimuUI.modules.KeyStyle then
        if db.KeyStyle.enabled then
            SimuUI.modules.KeyStyle:Enable()
        else
            SimuUI.modules.KeyStyle:Disable()
        end
    end
end)

-- ✅ QuickFocus 모듈 체크박스
local quickFocusCheckbox = CreateFrame("CheckButton", nil, options, "InterfaceOptionsCheckButtonTemplate")
quickFocusCheckbox:SetPoint("TOPLEFT", keyStyleCheckbox, "BOTTOMLEFT", 0, -10)
quickFocusCheckbox.Text:SetText("빠른 주시 활성화")
quickFocusCheckbox:SetChecked(db.QuickFocus.enabled)

quickFocusCheckbox:SetScript("OnClick", function(self)
    db.QuickFocus.enabled = self:GetChecked()

    if SimuUI.modules.QuickFocus then
        if db.QuickFocus.enabled then
            SimuUI.modules.QuickFocus:Enable()
        else
            SimuUI.modules.QuickFocus:Disable()
        end
    end
end)
