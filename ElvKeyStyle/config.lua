local ElvKeyStyle = LibStub("AceAddon-3.0"):GetAddon("ElvKeyStyle")
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
        shortcut = {
            type = "toggle",
            name = "키 바인딩 축약 사용",
            desc = "키 바인딩 텍스트의 축약을 활성화/비활성화합니다.",
            get = function() return ElvKeyStyle.db.profile.shortcut end,
            set = function(_, val)
                ElvKeyStyle.db.profile.shortcut = val
                ElvKeyStyle:UpdateKeyText()
            end,
            order = 4,
        },
    }
}

ElvKeyStyle.defaults = {
    profile = {
        font = LSM:GetDefault("font"),
        size = 12,
        color = { r = 1, g = 1, b = 1 },
        shortcut = true,  -- 기본값을 true로 설정 (축약 사용)
    }
}
