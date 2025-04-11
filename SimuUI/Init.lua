local SimuUI = select(2, ...).SimuUI

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
    for name, module in pairs(SimuUI.modules) do
        if SimuUI.defaults[name] and SimuUI.defaults[name].enabled then
            if module.Enable then module:Enable() end
        end
    end

    if InterfaceOptions_AddCategory and SimuUI.optionsPanel then
        InterfaceOptions_AddCategory(SimuUI.optionsPanel)
    end
end)
