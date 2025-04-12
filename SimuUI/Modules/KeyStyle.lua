local SimuUI = LibStub("AceAddon-3.0"):GetAddon("SimuUI")
local KeyStyle = SimuUI:NewModule("KeyStyle", "AceEvent-3.0")
local LSM = LibStub("LibSharedMedia-3.0")

-- ✅ 단축키 축약 함수 (입력 타입 확인 추가)
local function FormatKeyText(text)
    if type(text) ~= "string" then return "" end

    text = text:gsub("5번 마우스 버튼", "M5")
               :gsub("4번 마우스 버튼", "M4")
               :gsub("3번 마우스 버튼", "M3")
               :gsub("2번 마우스 버튼", "M2")
               :gsub("1번 마우스 버튼", "M1")
               :gsub("마우스가운데버튼", "M3")
               :gsub("마우스 가운데 버튼", "M3")
               :gsub("SHIFT%-", "S")
               :gsub("ALT%-", "A")
               :gsub("CTRL%-", "C")
               :gsub("NUMPAD(%d)", "N%1")
               :gsub("NUMPAD", "N")
               :gsub("숫자패드(%d)", "N%1")
               :gsub("숫자패드", "N")
               :gsub("BUTTON", "M")
               :gsub("MOUSEWHEELUP", "MU")
               :gsub("MOUSEWHEELDOWN", "MD")
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
               :gsub("-", "")
               :gsub("%s+", "")
               :upper()

    return text
end

function KeyStyle:IsActive()
    return SimuUI.db.profile.KeyStyle and SimuUI.db.profile.KeyStyle.enabled
end

function KeyStyle:ApplySettings()
    self:UpdateHotkeys()
end

function KeyStyle:ProcessHotkeys()
    local db = SimuUI.db.profile.KeyStyle or {}
    local font = LSM:Fetch("font", db.font) or STANDARD_TEXT_FONT
    local fontSize = tonumber(db.fontSize) or 12
    local color = db.color or { r = 1, g = 1, b = 1, a = 1 }
    local outColor = db.outOfRangeColor or { r = 1, g = 0.2, b = 0.2, a = 1 }

    local function SafeColor(c, default)
        return tonumber(c) and math.min(1, math.max(0, c)) or default
    end

    local r  = SafeColor(color.r, 1)
    local g  = SafeColor(color.g, 1)
    local b  = SafeColor(color.b, 1)
    local a  = SafeColor(color.a, 1)

    local orr = SafeColor(outColor.r, 1)
    local org = SafeColor(outColor.g, 0.2)
    local orb = SafeColor(outColor.b, 0.2)
    local ora = SafeColor(outColor.a, 1)

    local function UpdateHotkey(button)
        if button and button.HotKey and button.HotKey:IsObjectType("FontString") and button.HotKey:IsShown() then
            local key = button.HotKey:GetText()
            if key and key ~= "" then
                button.HotKey:SetText(FormatKeyText(key))
                button.HotKey:SetFont(font, fontSize, "OUTLINE")

                -- 사거리 체크 (Action 버튼만)
                if button.action and HasAction(button.action) and ActionHasRange(button.action) then
                    if IsActionInRange(button.action) == false then
                        button.HotKey:SetTextColor(orr, org, orb, ora)
                        return
                    end
                end

                button.HotKey:SetTextColor(r, g, b, a)
            end
        end
    end

    local barPrefixes = {
        "ActionButton", "MultiBarBottomLeftButton", "MultiBarBottomRightButton",
        "MultiBarRightButton", "MultiBarLeftButton", "PetActionButton",
        "StanceButton"
    }

    for _, prefix in pairs(barPrefixes) do
        for i = 1, 12 do
            UpdateHotkey(_G[prefix .. i])
        end
    end

    local extraButtons = {
        _G["ExtraActionButton1"],
        _G["ZoneAbilityFrame"] and _G["ZoneAbilityFrame"].SpellButton,
    }

    for _, button in pairs(extraButtons) do
        UpdateHotkey(button)
    end
end

function KeyStyle:UpdateHotkeys()
    if not self:IsActive() then return end
    self:ProcessHotkeys()
end

function KeyStyle:OnEnable()
    self:RegisterEvent("UPDATE_BINDINGS", "UpdateHotkeys")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateHotkeys")
    self:RegisterEvent("ACTIONBAR_UPDATE_USABLE", "UpdateHotkeys")
    self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", "UpdateHotkeys")
    self:RegisterEvent("ACTION_RANGE_CHECK_UPDATE", "UpdateHotkeys")

    self:UpdateHotkeys()
end

function KeyStyle:OnDisable()
    self:UnregisterAllEvents()
end
