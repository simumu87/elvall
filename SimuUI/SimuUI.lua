-- SimuUI.lua (애드온 초기화 진입점)

local addonName, addonTable = ...

-- SimuUI 네임스페이스
SimuUI = {}
SimuUI.modules = {}
_G.SimuUI = SimuUI

-- 기본 설정값
SimuUI.defaults = {
    profile = {
        KeyStyle = {
            enabled = true,
            fontSize = 12,
            fontColor = { r = 1, g = 1, b = 1 },
        },
        QuickFocus = {
            enabled = true,
        }
    }
}

-- 저장 변수 초기화 함수
local function CopyDefaults(src, dst)
    for k, v in pairs(src) do
        if type(v) == "table" then
            dst[k] = dst[k] or {}
            CopyDefaults(v, dst[k])
        elseif dst[k] == nil then
            dst[k] = v
        end
    end
end

local function InitializeDB()
    if not SimuUIDB then SimuUIDB = {} end
    if not SimuUIDB.profile then SimuUIDB.profile = {} end
    CopyDefaults(SimuUI.defaults.profile, SimuUIDB.profile)
end

-- ADDON_LOADED 이벤트로 초기화 실행
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addon)
    if addon == addonName then
        InitializeDB()
    end
end)
