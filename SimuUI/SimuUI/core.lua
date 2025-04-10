-- SimuUI/core.lua

local ADDON_NAME, Engine = ...
local SimuUI = {}
Engine.SimuUI = SimuUI

-- 애드온 기본값
SimuUI.defaults = {
    KeyStyle = {
        enabled = true,
    },
    QuickFocus = {
        enabled = true,
        modifier = "SHIFT",
    },
}

-- 저장 변수 초기화 및 병합
local function MergeDefaults(target, defaults)
    for k, v in pairs(defaults) do
        if type(v) == "table" then
            if type(target[k]) ~= "table" then
                target[k] = {}
            end
            MergeDefaults(target[k], v)
        elseif target[k] == nil then
            target[k] = v
        end
    end
end

-- 모듈 테이블
SimuUI.modules = {}

-- 애드온 초기화
local function Initialize()
    if not SimuUIDB then
        SimuUIDB = {}
    end

    MergeDefaults(SimuUIDB, SimuUI.defaults)

    -- 각 모듈 로딩 및 활성화
    for name, module in pairs(SimuUI.modules) do
        if SimuUIDB[name] and SimuUIDB[name].enabled and module.Enable then
            module:Enable()
        end
    end

    -- 옵션 프레임 불러오기
    if SimuUI_LoadOptions then
        SimuUI_LoadOptions()
    end
end

-- 이벤트 등록
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, event, addon)
    if addon == ADDON_NAME then
        Initialize()
    end
end)

-- 모듈 비활성화 함수
function SimuUI:DisableModule(name)
    local module = self.modules[name]
    if module and module.Disable then
        module:Disable()
    end
end

-- 모듈 활성화 함수
function SimuUI:EnableModule(name)
    local module = self.modules[name]
    if module and module.Enable then
        module:Enable()
    end
end
