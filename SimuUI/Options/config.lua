local SimuUI = LibStub("AceAddon-3.0"):GetAddon("SimuUI")

SimuUI.options.type = "group"
SimuUI.options.args = {
    KeyStyle = {
        type = "toggle",
        name = "Enable KeyStyle",
        desc = "Toggle shortcut key text styling",
        get = function() return SimuUI.db.profile.KeyStyle end,
        set = function(_, val) SimuUI.db.profile.KeyStyle = val; ReloadUI() end,
    },
    QuickFocus = {
        type = "toggle",
        name = "Enable QuickFocus",
        desc = "Toggle mouseover quick focus functionality",
        get = function() return SimuUI.db.profile.QuickFocus end,
        set = function(_, val) SimuUI.db.profile.QuickFocus = val; ReloadUI() end,
    },
}
