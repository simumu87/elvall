-- commands.lua

-- SimuUI 설정창 열기
SLASH_SIMUUI1 = "/simu"
SLASH_SIMUUI2 = "/simuui"
SlashCmdList["SIMUUI"] = function(msg)
    if SimuUI and SimuUI.OptionsPanel then
        if SimuUI.OptionsPanel:IsShown() then
            SimuUI.OptionsPanel:Hide()
        else
            SimuUI.OptionsPanel:Show()
        end
    else
        print("SimuUI: 설정창을 불러올 수 없습니다.")
    end
end

-- 빠른 단축키 설정 모드
SLASH_SIMUUIKB1 = "/kb"
SlashCmdList["SIMUUIKB"] = function()
    -- 이 함수는 너가 기존에 만들었던 단축키 설정 모드 진입 함수로 대체해줘야 해
    if SimuUI and SimuUI.ToggleQuickKeybindMode then
        SimuUI:ToggleQuickKeybindMode()
    else
        print("SimuUI: 빠른 단축키 모드를 사용할 수 없습니다.")
    end
end
