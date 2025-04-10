-- config.lua
-- SimuUI 기본 설정값 정의

local addonName, addonTable = ...

SimuUI.defaults = {
    profile = {
        KeyStyle = {
            enabled = true,
            font = STANDARD_TEXT_FONT,
            fontSize = 12,
            fontColor = { r = 1, g = 1, b = 1 },
        },
        QuickFocus = {
            enabled = true,
            modifier = "ALT",
        },
    }
}
