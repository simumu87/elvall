local SimuUI = select(2, ...).SimuUI
local module = {}

function module:Enable()
    local modifier = SimuUIDB and SimuUIDB.QuickFocus and SimuUIDB.QuickFocus.modifier or "SHIFT"

    hooksecurefunc("ActionButton_OnClick", function(self, button)
        if IsModifiedClick(modifier) and button == "LeftButton" and self.unit then
            FocusUnit(self.unit)
        end
    end)
end

function module:Disable()
    -- 향후 비활성화 로직 추가 가능
end

SimuUI.modules.QuickFocus = module
