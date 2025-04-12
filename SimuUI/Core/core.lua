local SimuUI = LibStub("AceAddon-3.0"):NewAddon("SimuUI", "AceConsole-3.0", "AceEvent-3.0")
_G.SimuUI = SimuUI

local LSM = LibStub("LibSharedMedia-3.0")
local optionsInitialized = false

-- ✅ 설정 기본값
local defaults = {
    profile = {
        KeyStyle = {
            enabled = true,
            font = "Friz Quadrata TT", -- SharedMedia에 등록된 이름
            fontSize = 12,
            color = { r = 1, g = 1, b = 1 },
            outOfRangeColor = { r = 1, g = 0, b = 0, a = 1 },  -- 기본값: 빨간색
        },
    }
}

function SimuUI:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("SimuUIDB", defaults, true)

    -- ✅ 모듈 상태에 따라 Enable / Disable 적용
    local module = self:GetModule("KeyStyle")
    if self.db.profile.KeyStyle and self.db.profile.KeyStyle.enabled then
        module:Enable()
    else
        module:Disable()
    end

    -- ✅ 옵션 등록
    self:SetupOptions()
    
    -- ✅ 전투 이벤트 처리
    self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnCombatStart")  -- 전투 시작
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatEnd")     -- 전투 종료
end

function SimuUI:OnCombatStart()
    self.db.profile.KeyStyle.inCombat = true  -- 전투 중임을 기록
    self:GetModule("KeyStyle"):UpdateHotkeys()  -- 색상 업데이트
end

function SimuUI:OnCombatEnd()
    self.db.profile.KeyStyle.inCombat = false  -- 전투 종료 상태 기록
    self:GetModule("KeyStyle"):UpdateHotkeys()  -- 색상 업데이트
end

function SimuUI:SetupOptions()
    if optionsInitialized then return end
    optionsInitialized = true

    local AceConfig = LibStub("AceConfig-3.0")
    local AceConfigDialog = LibStub("AceConfigDialog-3.0")

    -- ✅ 옵션 테이블 (KeyStyle 전용)
    self.options = {
        type = "group",
        name = "SimuUI",
        args = {
            KeyStyle = {
                type = "group",
                name = "KeyStyle",
                inline = true,
                order = 1,
                args = {
                    enabled = {
                        type = "toggle",
                        name = "Enable KeyStyle",
                        desc = "Enable or disable KeyStyle module.",
                        order = 1,
                        get = function() return self.db.profile.KeyStyle.enabled end,
                        set = function(_, val)
                            self.db.profile.KeyStyle.enabled = val
                            local mod = self:GetModule("KeyStyle")
                            if val then mod:Enable() else mod:Disable() end
                        end,
                    },
                    font = {
                        type = "select",
                        name = "Font",
                        dialogControl = "LSM30_Font",
                        values = LSM:HashTable("font"),
                        order = 2,
                        get = function() return self.db.profile.KeyStyle.font end,
                        set = function(_, val)
                            self.db.profile.KeyStyle.font = val
                            self:GetModule("KeyStyle"):ApplySettings()
                        end,
                    },
                    fontSize = {
                        type = "range",
                        name = "Font Size",
                        min = 8,
                        max = 24,
                        step = 1,
                        order = 3,
                        get = function() return self.db.profile.KeyStyle.fontSize end,
                        set = function(_, val)
                            self.db.profile.KeyStyle.fontSize = val
                            self:GetModule("KeyStyle"):ApplySettings()
                        end,
                    },
                    color = {
                        type = "color",
                        name = "Font Color",
                        hasAlpha = false,
                        order = 4,
                        get = function()
                            local c = self.db.profile.KeyStyle.color
                            return c.r, c.g, c.b
                        end,
                        set = function(_, r, g, b)
                            local c = self.db.profile.KeyStyle.color
                            c.r, c.g, c.b = r, g, b
                            self:GetModule("KeyStyle"):ApplySettings()
                        end,
                    },
                    outOfRangeColor = {  -- 추가된 부분
                        type = "color",
                        name = "Out of Range Target Color",  -- 새로운 이름
                        desc = "Sets the color of the hotkeys when targeting out of range units.",  -- 설명
                        hasAlpha = true,
                        order = 5,
                        get = function()
                            local c = self.db.profile.KeyStyle.outOfRangeColor
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            local c = self.db.profile.KeyStyle.outOfRangeColor
                            c.r, c.g, c.b, c.a = r, g, b, a
                            self:GetModule("KeyStyle"):ApplySettings()  -- 변경사항 적용
                        end,
                    },
                },
            },
        },
    }

    AceConfig:RegisterOptionsTable("SimuUI", self.options)
    AceConfigDialog:AddToBlizOptions("SimuUI", "SimuUI")
end
