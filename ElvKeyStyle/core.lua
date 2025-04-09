-- core.lua

-- LibSharedMedia-3.0 불러오기
local LSM = LibStub("LibSharedMedia-3.0")
local AceDB = LibStub("AceDB-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

-- ElvKeyStyle 초기화
ElvKeyStyle = LibStub("AceAddon-3.0"):NewAddon("ElvKeyStyle", "AceConsole-3.0")

-- 기본값 설정
ElvKeyStyle.defaults = {
    profile = {
        font = LSM:GetDefault("font"),
        size = 12,
        color = { r = 1, g = 1, b = 1 },
        shortcut = true, -- 기본적으로 축약 기능 활성화
    }
}

-- 애드온 초기화
function ElvKeyStyle:OnInitialize()
    -- 데이터베이스 설정
    self.db = AceDB:New("ElvKeyStyleDB", ElvKeyStyle.defaults, true)

    -- 옵션 테이블 등록
    AceConfig:RegisterOptionsTable("ElvKeyStyle", ElvKeyStyle.options)
    AceConfigDialog:AddToBlizOptions("ElvKeyStyle", "ElvKeyStyle")

    -- 커맨드 등록 ('/elvk'로 설정창 열기)
    self:RegisterChatCommand("elvk", "OpenSettings")
end

-- 설정창 열기
function ElvKeyStyle:OpenSettings()
    AceConfigDialog:Open("ElvKeyStyle")
end

-- 키 텍스트 업데이트
function ElvKeyStyle:UpdateKeyText()
    for i = 1, 12 do
        for _, barName in pairs({
            "ActionButton", "MultiBarBottomLeftButton", "MultiBarBottomRightButton",
            "MultiBarRightButton", "MultiBarLeftButton", "MultiBar5Button",
            "MultiBar6Button", "MultiBar7Button"
        }) do
            local button = _G[barName..i]
            if button and button.HotKey then
                local hk = button.HotKey
                local text = hk:GetText() or ""

                -- 축약 텍스트 적용 (shortcut 설정에 따라)
                if ElvKeyStyle.db.profile.shortcut then
                    text = self:FormatKeyText(text)
                end

                -- 폰트만 변경 (텍스트 변경과는 별개로 폰트는 따로 처리)
                hk:SetFont(LSM:Fetch("font", ElvKeyStyle.db.profile.font), ElvKeyStyle.db.profile.size, "OUTLINE")

                -- 텍스트 색상만 변경 (색상은 별도로 설정)
                hk:SetTextColor(ElvKeyStyle.db.profile.color.r, ElvKeyStyle.db.profile.color.g, ElvKeyStyle.db.profile.color.b)

                -- 텍스트는 항상 새로 설정 (폰트, 크기, 색상만 바꾸고 텍스트는 축약여부에 따라 변경)
                hk:SetText(text)
            end
        end
    end
end

-- 키 텍스트 포맷팅 (축약)
function ElvKeyStyle:FormatKeyText(text)
    if not text then return "" end

    -- 키 바인딩 축약 및 "-" 제거
    text = text:gsub("SHIFT%-", "S")
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

    -- 마우스 버튼 처리 (M3, M4, M5 등)
    text = text:gsub("MOUSEBUTTON(%d)", function(button)
        return "M" .. button
    end)

    -- 넘버패드 키 축약 (NUMPAD1 → N1, NUMPAD2 → N2 등)
    text = text:gsub("NUMPAD(%d)", "N%1")

    -- "-" 하이픈 제거
    text = text:gsub("-", "")
    
    -- 불필요한 공백 제거 및 대문자로 변환
    text = text:gsub("%s+", ""):upper()
    
    return text
end
