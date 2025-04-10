local SimuUI = select(2, ...).SimuUI
local module = {}

function module:UpdateHotkeys()
    for i = 1, 12 do
        local button = _G["ActionButton"..i]
        if button and button.HotKey then
            local text = button.HotKey:GetText()
            if text then
                text = text:gsub("s%-", "S")
                           :gsub("a%-", "A")
                           :gsub("c%-", "C")
                           :gsub("SHIFT%-", "S")
                           :gsub("CTRL%-", "C")
                           :gsub("ALT%-", "A")
                           :gsub("-", "")
                button.HotKey:SetText(text)
            end
        end
    end
end

function module:Enable()
    self:UpdateHotkeys()
end

function module:Disable()
    -- 향후 비활성화 로직 추가 가능
end

SimuUI.modules.KeyStyle = module
