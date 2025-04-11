local SimuUI = LibStub("AceAddon-3.0"):GetAddon("SimuUI")
local KeyStyle = SimuUI:NewModule("KeyStyle", "AceEvent-3.0")
local LSM = LibStub("LibSharedMedia-3.0")

-- ✅ 단축키 축약 함수
local function FormatKeyText(text)
    if not text then return "" end

    text = text:gsub("5번 마우스 버튼", "M5")
               :gsub("4번 마우스 버튼", "M4")
               :gsub("마우스가운데버튼", "M3")
               :gsub("2번 마우스 버튼", "M2")
               :gsub("1번 마우스 버튼", "M1")
               :gsub("SHIFT%-", "S")
               :gsub("ALT%-", "A")
               :gsub("CTRL%-", "C")
               :gsub("BUTTON", "M")
               :gsub("MOUSEWHEELUP", "MU")
               :gsub("MOUSEWHEELDOWN", "MD")
               :gsub("NUMPAD", "N")
               :gsub("PAGEUP", "PU")
               :gsub("PAGEDOWN", "PD")
               :gsub("SPACE", "Sp")
               :gsub("INSERT", "Ins")
               :gsub("HOME", "Hm")
               :gsub("DELETE", "Del")
               :gsub("BACKSPACE", "BSp")
               :gsub("UP", "Up")
               :gsub("DOWN", "Dn")
               :gsub("LEFT", "Lt")
               :gsub("RIGHT", "Rt")
               :gsub("MOUSEBUTTON(%d)", function(b) return "M" .. b end)
               :gsub("NUMPAD(%d)", "N%1")
               :gsub("-", "")
               :gsub("%s+", "")
               :upper()

    return text
end

-- ✅ 현재 사용 설정 확인
function KeyStyle:IsActive()
    return SimuUI.db.profile.KeyStyle and SimuUI.db.profile.KeyStyle.enabled
end

-- ✅ 설정 반영 함수 (옵션 변경 시 호출됨)
function KeyStyle:ApplySettings()
    self:UpdateHotkeys()
end

-- ✅ 단축키 텍스트 업데이트
function KeyStyle:UpdateHotkeys()
    if not self:IsActive() then return end

    local db = SimuUI.db.profile.KeyStyle
    local font = LSM:Fetch("font", db.font)
    local fontSize = db.fontSize or 12
    local color = db.color or { r = 1, g = 1, b = 1, a = 1 }

    local barPrefixes = {
        "ActionButton", "MultiBarBottomLeftButton", "MultiBarBottomRightButton",
        "MultiBarRightButton", "MultiBarLeftButton", "PetActionButton",
        "StanceButton", "PossessButton", "ExtraActionButton", "ZoneAbilityFrameButton",
    }

    for _, prefix in pairs(barPrefixes) do
        for i = 1, 12 do
            local button = _G[prefix .. i]
            if button and button.HotKey then
                local key = button.HotKey:GetText()
                if key and key ~= "" then
                    button.HotKey:SetText(FormatKeyText(key))
                    button.HotKey:SetFont(font, fontSize, "OUTLINE")
                    button.HotKey:SetTextColor(color.r, color.g, color.b, color.a or 1)
                end
            end
        end
    end
end

-- ✅ 모듈 활성화 시
function KeyStyle:OnEnable()
    self:RegisterEvent("UPDATE_BINDINGS", "UpdateHotkeys")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateHotkeys")

    if ActionBarButtonEventsFrame then
        local original = ActionBarButtonEventsFrame:GetScript("OnEvent")
        ActionBarButtonEventsFrame:SetScript("OnEvent", function(frame, event, ...)
            if original then original(frame, event, ...) end
            self:UpdateHotkeys()
        end)
    end

    self:UpdateHotkeys()
end

function KeyStyle:OnDisable()
    self:UnregisterAllEvents()
end
