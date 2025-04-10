-- SimuUI/Options/commands.lua

SLASH_SIMUUI1 = "/simu"
SLASH_SIMUUIKB1 = "/kb"

SlashCmdList["SIMUUI"] = function(msg)
    msg = msg and msg:lower() or ""

    if msg == "config" or msg == "" then
        InterfaceOptionsFrame_OpenToCategory("SimuUI")
        InterfaceOptionsFrame_OpenToCategory("SimuUI") -- 두 번 호출해야 UI에서 제대로 작동
    else
        print("|cffffcc00SimuUI 사용법:|r")
        print(" - /simu : 설정창 열기")
        print(" - /kb : 빠른 키 바인딩 프레임 토글")
    end
end

SlashCmdList["SIMUUIKB"] = function()
    if QuickKeybindFrame and QuickKeybindFrame:IsShown() then
        QuickKeybindFrame:Hide()
        print("|cffffcc00SimuUI:|r Quick Keybind Frame 숨김")
    elseif QuickKeybindFrame then
        QuickKeybindFrame:Show()
        print("|cffffcc00SimuUI:|r Quick Keybind Frame 표시")
    else
        print("|cffff0000SimuUI:|r QuickKeybindFrame이 사용 불가합니다.")
    end
end
