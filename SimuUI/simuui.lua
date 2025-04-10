-- SimuUI.lua
-- 애드온 초기화 진입점

local addonName, addonTable = ...

-- SimuUI 네임스페이스 생성
SimuUI = {}
SimuUI.modules = {}

-- 다른 파일에서 사용할 수 있도록 글로벌 테이블 연결
_G.SimuUI = SimuUI
