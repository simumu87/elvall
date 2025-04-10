-- SimuUI/Modules/KeyStyle.lua
-- 액션바 단축키 축약 표시 모듈

local module = {}
SimuUI.modules["KeyStyle"] = module

-- 단축키 축약 함수
local function AbbreviateKey(text)
    if not text then return "" end

    text = text:gsub("s%-", "S")
    text = text:gsub("a%-", "A")
    text = text:gsub("c%-", "C")

    text = text:gsub("Mouse Button ", "M")
    text = text:gsub("Num Pad ", "N")
    text = text:gsub("PageUp", "PU")
    text = text:gsub("PageDown", "PD")
    text = text:gsub("Spacebar", "SpB")
    text = text:gsub("Insert", "Ins")
    text = text:gsub("Home", "Hm")
    text = text:gsub("Delete", "Del")
    text = text:gsub("Middle Mouse", "M3")
    text = text:gsub("Mouse Wheel Up", "MU")
    text = text:gsub("Mouse Wheel Down", "MD")
    text = text:gsub("Num Lock", "NL")

    -- 하이픈 제거
    text = text:gsub("%-", "")

    return text
end

-- 버튼에 축약 적용
function module:UpdateHotkeys()
    local buttons = {}

    -- 기본 액션바
    for i = 1, 12 do
        tinsert(buttons, _G["ActionButton"..i])
    end

    -- 추가 액션바
    for i = 1, 12 do
        tinsert(buttons, _G["MultiBarBottomLeftButton"..i])
        tinsert(buttons, _G["MultiBarBottomRightButton"..i])
        tinsert(buttons, _G["MultiBarRightButton"..i])
        tinsert(buttons, _G["MultiBarLeftButton"..i])
    end

    for _, button in ipairs(buttons) do
        if button and button.HotKey then
            local key = button.HotKey:GetText()
            local shortKey = AbbreviateKey(key)
            button.HotKey:SetText(shortKey)

            local db = SimuUIDB.profile.KeyStyle
            if db and db.font and db.fontSize and db.fontColor then
                button.HotKey:SetFont(db.font, db.fontSize, "OUTLINE")
                button.HotKey:SetTextColor(db.fontColor.r, db.fontColor.g, db.fontColor.b)
            end
        end
    end
end

-- 핫키 업데이트 후킹
local function HookHotkeyUpdates()
    hooksecurefunc("ActionButton_UpdateHotkeys", function(button)
        if not SimuUIDB or not SimuUIDB.profile or not SimuUIDB.profile.KeyStyle.enabled then return end

        if button and button.HotKey and button.HotKey:GetText() then
            local key = button.HotKey:GetText()
            local shortKey = AbbreviateKey(key)
            button.HotKey:SetText(shortKey)

            local db = SimuUIDB.profile.KeyStyle
            if db and db.font and db.fontSize and db.fontColor then
                button.HotKey:SetFont(db.font, db.fontSize, "OUTLINE")
                button.HotKey:SetTextColor(db.fontColor.r, db.fontColor.g, db.fontColor.b)
            end
        end
    end)
end

-- 모듈 활성화
function module:Enable()
    self:UpdateHotkeys()
    HookHotkeyUpdates()
end

-- 모듈 비활성화
function module:Disable()
    -- HotKey 리셋 기능은 생략 (UI 재로드 시 반영됨)
end
