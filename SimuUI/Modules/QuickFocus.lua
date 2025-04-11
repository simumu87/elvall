local SimuUI = select(2, ...).SimuUI
local module = {}

function module:Enable()
    -- Enable logic
end

function module:Disable()
    -- Disable logic
end

SimuUI.modules.QuickFocus = module
