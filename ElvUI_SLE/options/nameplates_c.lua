local SLE, T, E, L, V, P, G = unpack(ElvUI_SLE)
local NP = E.NamePlates

local function configTable()
	if not SLE.initialized then return end
	local ACH = E.Libs.ACH

	E.Options.args.sle.args.modules.args.nameplate = {
		type = "group",
		name = L["NamePlates"],
		order = 1,
		disabled = function() return not E.private.nameplates.enable end,
		args = {
			header = ACH:Header(L["NamePlates"], 1),
			targetcount = {
				type = "group",
				order = 2,
				name = L["Target Count"],
				guiInline = true,
				get = function(info) return E.db.sle.nameplates.targetcount[ info[#info] ] end,
				set = function(info, value) E.db.sle.nameplates.targetcount[ info[#info] ] = value; NP:ConfigureAll() end,
				args = {
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Display the number of party / raid members targeting the nameplate unit."],
					},
					font = {
						type = "select", dialogControl = 'LSM30_Font',
						order = 4,
						name = L["Font"],
						values = AceGUIWidgetLSMlists.font,
					},
					size = {
						order = 5,
						name = FONT_SIZE,
						type = "range",
						min = 4, max = 25, step = 1,
					},
					fontOutline = ACH:FontFlags(L["Font Outline"], L["Set the font outline."], 6),
					xoffset = {
						order = 7,
						name = L["X-Offset"],
						type = "range",
						min = -200, max = 200, step = 1,
					},
					yoffset = {
						order = 8,
						name = L["Y-Offset"],
						type = "range",
						min = -50, max = 50, step = 1,
					},
				},
			},
			threat = {
				type = "group",
				order = 3,
				name = L["Threat Text"],
				guiInline = true,
				get = function(info) return E.db.sle.nameplates.threat[ info[#info] ] end,
				set = function(info, value) E.db.sle.nameplates.threat[ info[#info] ] = value; NP:ConfigureAll() end,
				args = {
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Display threat level as text on targeted, boss or mouseover nameplate."],
					},
					font = {
						type = "select", dialogControl = 'LSM30_Font',
						order = 4,
						name = L["Font"],
						values = AceGUIWidgetLSMlists.font,
					},
					size = {
						order = 5,
						name = FONT_SIZE,
						type = "range",
						min = 4, max = 25, step = 1,
					},
					fontOutline = ACH:FontFlags(L["Font Outline"], L["Set the font outline."], 6),
					xoffset = {
						order = 7,
						name = L["X-Offset"],
						type = "range",
						min = -200, max = 200, step = 1,
					},
					yoffset = {
						order = 8,
						name = L["Y-Offset"],
						type = "range",
						min = -50, max = 50, step = 1,
					},
				},
			},
		},
	}
end

tinsert(SLE.Configs, configTable)
