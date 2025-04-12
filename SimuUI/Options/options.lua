local SimuUI = LibStub("AceAddon-3.0"):GetAddon("SimuUI")
local LSM = LibStub("LibSharedMedia-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

SimuUI.options = {
    type = "group",
    name = "SimuUI",
    args = {
        KeyStyle = {
            type = "group",
            name = "KeyStyle (단축키 축약)",
            order = 1,
            args = {
                enabled = {
                    type = "toggle",
                    name = "사용",
                    desc = "단축키 축약 기능을 사용합니다.",
                    get = function() return SimuUI.db.profile.KeyStyle.enabled end,
                    set = function(_, value)
                        SimuUI.db.profile.KeyStyle.enabled = value
                        local mod = SimuUI:GetModule("KeyStyle")
                        if value then mod:Enable() else mod:Disable() end
                    end,
                },
                font = {
                    type = "select",
                    dialogControl = 'LSM30_Font',
                    name = "글꼴",
                    desc = "단축키 글꼴을 선택하세요.",
                    values = LSM:HashTable("font"),
                    get = function() return SimuUI.db.profile.KeyStyle.font end,
                    set = function(_, value)
                        SimuUI.db.profile.KeyStyle.font = value
                        SimuUI:GetModule("KeyStyle"):UpdateHotkeys()
                    end,
                },
                fontSize = {
                    type = "range",
                    name = "글씨 크기",
                    desc = "단축키 글자의 크기를 설정합니다.",
                    min = 6, max = 24, step = 1,
                    get = function() return SimuUI.db.profile.KeyStyle.fontSize end,
                    set = function(_, value)
                        SimuUI.db.profile.KeyStyle.fontSize = value
                        SimuUI:GetModule("KeyStyle"):UpdateHotkeys()
                    end,
                },
                fontColor = {
                    type = "color",
                    name = "글씨 색상",
                    desc = "단축키 글자의 색상을 설정합니다.",
                    hasAlpha = true,
                    get = function()
                        local c = SimuUI.db.profile.KeyStyle.fontColor
                        return c.r, c.g, c.b, c.a
                    end,
                    set = function(_, r, g, b, a)
                        local c = SimuUI.db.profile.KeyStyle.fontColor
                        c.r, c.g, c.b, c.a = r, g, b, a
                        SimuUI:GetModule("KeyStyle"):UpdateHotkeys()
                    end,
                },
                outOfRangeColor = {
                    type = "color",
                    name = "사거리 밖 색상",
                    desc = "사거리 밖의 대상을 타겟했을 때 단축키 색상을 설정합니다.",
                    hasAlpha = true,
                    get = function()
                        local c = SimuUI.db.profile.KeyStyle.outOfRangeColor
                        return c.r, c.g, c.b, c.a
                    end,
                    set = function(_, r, g, b, a)
                        local c = SimuUI.db.profile.KeyStyle.outOfRangeColor
                        c.r, c.g, c.b, c.a = r, g, b, a
                        SimuUI:GetModule("KeyStyle"):UpdateHotkeys()
                    end,
                },
            },
        },
    },
}
