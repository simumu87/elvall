local SimuUI = {}
_G.SimuUI = SimuUI

SimuUI.modules = {}
SimuUI.defaults = {
    KeyStyle = {
        enabled = true,
        fontSize = 12,
        fontColor = { r = 1, g = 1, b = 1 },
    },
    QuickFocus = {
        enabled = true,
        modifier = "SHIFT",
    },
}

SimuUI.AddonName, SimuUI.AddonTable = ...
SimuUI.AddonTable.SimuUI = SimuUI
