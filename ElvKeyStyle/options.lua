local ElvKeyStyle = LibStub("AceAddon-3.0"):GetAddon("ElvKeyStyle")
local LSM = LibStub("LibSharedMedia-3.0")

ElvKeyStyle.options = {
    type = "group",
    name = "ElvKeyStyle",
    args = {
        general = {
            type = "group",
            name = "일반 설정",
            order = 1,
            args = {
                font = {
                    type = "select",
                    dialogControl = "LSM30_Font",
                    name = "폰트",
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
    }
}
