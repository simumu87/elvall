local _, SimuUI = ...

-- 옵션 프레임
local options = CreateFrame("Frame", "SimuUIOptionsPanel", UIParent, "BasicFrameTemplateWithInset")
options.name = "SimuUI"
options:SetSize(400, 300)
options:SetPoint("CENTER")
options:Hide()

SimuUI.OptionsPanel = options

-- 제목
options.title = options:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
options.title:SetPoint("TOPLEFT", 15, -15)
options.title:SetText("SimuUI 설정")

-- KeyStyle 사용 체크박스
local keyStyleCheck = CreateFrame("CheckButton", nil, options, "UICheckButtonTemplate")
keyStyleCheck:SetPoint("TOPLEFT", 20, -50)
keyStyleCheck.text:SetText("단축키 축약 활성화")
keyStyleCheck:SetChecked(SimuUIDB.profile.KeyStyle.enabled)
keyStyleCheck:SetScript("OnClick", function(self)
    SimuUIDB.profile.KeyStyle.enabled = self:GetChecked()
end)

-- 폰트 크기 슬라이더
local fontSizeSlider = CreateFrame("Slider", "SimuUIFontSizeSlider", options, "OptionsSliderTemplate")
fontSizeSlider:SetOrientation("HORIZONTAL")
fontSizeSlider:SetSize(200, 20)
fontSizeSlider:SetPoint("TOPLEFT", keyStyleCheck, "BOTTOMLEFT", 0, -40)
fontSizeSlider:SetMinMaxValues(8, 24)
fontSizeSlider:SetValueStep(1)
fontSizeSlider:SetObeyStepOnDrag(true)
fontSizeSlider:SetValue(SimuUIDB.profile.KeyStyle.fontSize)
SimuUIFontSizeSliderText:SetText("폰트 크기")
SimuUIFontSizeSliderLow:SetText("8")
SimuUIFontSizeSliderHigh:SetText("24")
fontSizeSlider:SetScript("OnValueChanged", function(self, value)
    SimuUIDB.profile.KeyStyle.fontSize = math.floor(value)
end)

-- 색상 선택 버튼
local colorSwatch = CreateFrame("Button", nil, options)
colorSwatch:SetSize(24, 24)
colorSwatch:SetPoint("LEFT", fontSizeSlider, "RIGHT", 20, 0)

local function UpdateSwatchColor()
    local c = SimuUIDB.profile.KeyStyle.fontColor
    colorSwatch.tex:SetColorTexture(c.r, c.g, c.b)
end

colorSwatch.tex = colorSwatch:CreateTexture(nil, "BACKGROUND")
colorSwatch.tex:SetAllPoints()
UpdateSwatchColor()

colorSwatch:SetScript("OnClick", function()
    local c = SimuUIDB.profile.KeyStyle.fontColor
    ColorPickerFrame.hasOpacity = false
    ColorPickerFrame.previousValues = { c.r, c.g, c.b }

    ColorPickerFrame.func = function()
        local r, g, b = ColorPickerFrame:GetColorRGB()
        SimuUIDB.profile.KeyStyle.fontColor = { r = r, g = g, b = b }
        UpdateSwatchColor()
    end

    ColorPickerFrame.cancelFunc = function(prev)
        SimuUIDB.profile.KeyStyle.fontColor = {
            r = prev[1], g = prev[2], b = prev[3]
        }
        UpdateSwatchColor()
    end

    ColorPickerFrame:SetColorRGB(c.r, c.g, c.b)
    ColorPickerFrame:Hide() -- 재호출을 위한 초기화
    ColorPickerFrame:Show()
end)

-- 빠른주시 사용 체크박스
local quickFocusCheck = CreateFrame("CheckButton", nil, options, "UICheckButtonTemplate")
quickFocusCheck:SetPoint("TOPLEFT", fontSizeSlider, "BOTTOMLEFT", 0, -40)
quickFocusCheck.text:SetText("빠른 주시 기능 활성화")
quickFocusCheck:SetChecked(SimuUIDB.profile.QuickFocus.enabled)
quickFocusCheck:SetScript("OnClick", function(self)
    SimuUIDB.profile.QuickFocus.enabled = self:GetChecked()
end)

-- 저장 & 닫기 버튼
local saveBtn = CreateFrame("Button", nil, options, "UIPanelButtonTemplate")
saveBtn:SetSize(100, 24)
saveBtn:SetPoint("BOTTOMRIGHT", -20, 20)
saveBtn:SetText("저장 후 닫기")
saveBtn:SetScript("OnClick", function()
    options:Hide()
    ReloadUI()
end)
