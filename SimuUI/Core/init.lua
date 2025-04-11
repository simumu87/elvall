local SimuUI = LibStub("AceAddon-3.0"):NewAddon("SimuUI", "AceConsole-3.0")

function SimuUI:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("SimuUIDB", {
        profile = {
            KeyStyle = true,
            QuickFocus = true,
        },
    })

    self.options = self.options or {}
    LibStub("AceConfig-3.0"):RegisterOptionsTable("SimuUI", self.options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SimuUI", "SimuUI")

    self:SetupModules()
end

function SimuUI:SetupModules()
    if self.db.profile.KeyStyle then self:EnableModule("KeyStyle") end
    if self.db.profile.QuickFocus then self:EnableModule("QuickFocus") end
end
