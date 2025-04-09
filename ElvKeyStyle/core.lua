local ElvKeyStyle = LibStub("AceAddon-3.0"):NewAddon("ElvKeyStyle", "AceConsole-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDB = LibStub("AceDB-3.0")
local LSM = LibStub("LibSharedMedia-3.0")

ElvKeyStyle.options = {
    type = "group",
    name = "ElvKeyStyle",
    args = {
        header = {
            type = "header",
            name = "ElvKeyStyle 설정",
            order = 0,
        },
        font = {
            type = "select",
            name = "폰트",
            dialogControl = "LSM30_Font",
            values = LSM:HashTable("font"),
            get = function() return ElvKeyStyle.db.profile.font end,
            set = function(_, val)
                ElvKeyStyle.db.profile.font = val
                ElvKeyStyle:UpdateKeyText()
            end,
            order = 1,
        },
        size = {
            type = "range",
            name = "크기",
            min = 6, max = 24, step = 1,
            get = function() return ElvKeyStyle.db.profile.size end,
            set = function(_, val)
                ElvKeyStyle.db.profile.size = val
                ElvKeyStyle:UpdateKeyText()
            end,
            order = 2,
        },
        color = {
            type = "color",
            name = "색상",
            get = function()
                local c = ElvKeyStyle.db.profile.color
                return c.r, c.g, c.b
            end,
            set = function(_, r, g, b)
                local c = ElvKeyStyle.db.profile.color
                c.r, c.g, c.b = r, g, b
                ElvKeyStyle:UpdateKeyText()
            end,
            order = 3,
        },
    }
}

ElvKeyStyle.defaults = {
    profile = {
        font = LSM:GetDefault("font"),
        size = 12,
        color = { r = 1, g = 1, b = 1 },
    }
}

function ElvKeyStyle:OnInitialize()
    self.db = AceDB:New("ElvKeyStyleDB", ElvKeyStyle.defaults, true)

    -- 옵션 테이블 등록
    AceConfig:RegisterOptionsTable("ElvKeyStyle", ElvKeyStyle.options)
    AceConfigDialog:AddToBlizOptions("ElvKeyStyle", "ElvKeyStyle")

    self:RegisterChatCommand("elvk", "OpenSettings")
end

function ElvKeyStyle:OpenSettings()
    AceConfigDialog:Open("ElvKeyStyle")
end

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
                text = self:FormatKeyText(text)
                hk:SetFont(LSM:Fetch("font", self.db.profile.font), self.db.profile.size, "OUTLINE")
                hk:SetTextColor(self.db.profile.color.r, self.db.profile.color.g, self.db.profile.color.b)
                hk:SetText(text)
            end
        end
    end
end

function ElvKeyStyle:FormatKeyText(text)
    -- 문자 포맷 변환 예시 (Shift-S → S)
    if not text then return "" end

    local replaceTable = {
        ["SHIFT%-"] = "S",
        ["ALT%-"] = "A",
        ["CTRL%-"] = "C",
        ["BUTTON"] = "M",
        ["MOUSEWHEELUP"] = "MU",
        ["MOUSEWHEELDOWN"] = "MD",
        ["NUMPAD"] = "N",
        ["PAGEUP"] = "PU",
        ["PAGEDOWN"] = "PD",
        ["SPACE"] = "Sp",
        ["INSERT"] = "Ins",
        ["HOME"] = "Hm",
        ["DELETE"] = "Del",
        ["BACKSPACE"] = "BSp",
        ["UP"] = "Up",
        ["DOWN"] = "Dn",
        ["LEFT"] = "Lt",
        ["RIGHT"] = "Rt",
    }

    for pattern, replacement in pairs(replaceTable) do
        text = text:gsub(pattern, replacement)
    end

    -- 대문자로 통일
    return text:upper()
end