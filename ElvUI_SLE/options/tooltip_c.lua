local SLE, T, E, L, V, P, G = unpack(ElvUI_SLE)
local RP = SLE.RaidProgress

local function configTable()
	if not SLE.initialized then return end
	local ACH = E.Libs.ACH

	E.Options.args.sle.args.modules.args.tooltip = {
		order = 1,
		type = 'group',
		name = L["Tooltip"],
		disabled = function() return not E.private.tooltip.enable end,
		get = function(info) return E.db.sle.tooltip[info[#info]] end,
		args = {
			header = ACH:Header(L["Tooltip"], 1),
			spacer1 = ACH:Spacer(4),
			showFaction = {
				order = 5,
				type = 'toggle',
				name = L["Faction Icon"],
				desc = L["Show faction icon to the left of player's name on tooltip."],
				disabled = function() return not E.private.tooltip.enable end,
				set = function(info, value) E.db.sle.tooltip[info[#info]] = value end,
			},
			alwaysCompareItems = {
				order = 6,
				type = 'toggle',
				name = L["Always Compare Items"],
				disabled = function() return not E.private.tooltip.enable end,
				set = function(info, value) E.db.sle.tooltip[info[#info]] = value; SLE:SetCompareItems() end,
			},
			RaidProg = {
				order = 12,
				type = 'group',
				name = L["Raid Progression"],
				guiInline = true,
				disabled = function() return not E.private.tooltip.enable end,
				get = function(info) return E.db.sle.tooltip.RaidProg[info[#info]] end,
				set = function(info, value) E.db.sle.tooltip.RaidProg[info[#info]] = value end,
				args = {
					enable = {
						order = 1,
						type = 'toggle',
						name = L["Enable"],
						desc = L["Show raid experience of character in tooltip (requires holding shift)."],
					},
					NameStyle = {
						order = 2,
						type = 'select',
						name = L["Name Style"],
						set = function(info, value) E.db.sle.tooltip.RaidProg[info[#info]] = value; wipe(RP.Cache) end,
						values = {
							LONG = L["Full"],
							SHORT = L["Short"],
						},
					},
					DifStyle = {
						order = 3,
						type = 'select',
						name = L["Difficulty Style"],
						set = function(info, value) E.db.sle.tooltip.RaidProg[info[#info]] = value; wipe(RP.Cache) end,
						values = {
							LONG = L["Full"],
							SHORT = L["Short"],
						},
					},
					Raids = {
						order = 4,
						type = 'group',
						name = RAIDS,
						guiInline = true,
						get = function(info) return E.db.sle.tooltip.RaidProg.raids[info[#info]] end,
						set = function(info, value) E.db.sle.tooltip.RaidProg.raids[info[#info]] = value end,
						args = {
							nightmare = { order = -50, type = 'toggle', name = SLE:GetMapInfo(777 , 'name') },
							trial = { order = -49, type = 'toggle', name = SLE:GetMapInfo(806, 'name') },
							nighthold = { order = -48, type = 'toggle', name = SLE:GetMapInfo(764, 'name') },
							sargeras = { order = -47, type = 'toggle', name = SLE:GetMapInfo(850 , 'name') },
							antorus = { order = -46, type = 'toggle', name = SLE:GetMapInfo(909, 'name') },
							uldir = { order = -45, type = 'toggle', name = SLE:GetMapInfo(1148, 'name') },
							daz = { order = -44, type = 'toggle', name = SLE:GetMapInfo(1358, 'name') },
							sc = { order = -43, type = 'toggle', name = SLE:GetMapInfo(1345, 'name') },
							ep = { order = -42, type = 'toggle', name = SLE:GetMapInfo(1512, 'name') },
							nzoth = { order = -41, type = 'toggle', name = SLE:GetMapInfo(1580, 'name') },
							nathria = { order = -40, type = 'toggle', name = SLE:GetMapInfo(1735, 'name') },
							sod = { order = -39, type = 'toggle', name = SLE:GetMapInfo(1998, 'name') },
							voti = { order = -38, type = 'toggle', name = SLE:GetMapInfo(2119, 'name') },
							atsc = { order = -37, type = 'toggle', name = SLE:GetMapInfo(2166, 'name') },
							atdh = { order = -36, type = 'toggle', name = SLE:GetMapInfo(2232, 'name') },
						},
					},
				},
			},
		},
	}
end

tinsert(SLE.Configs, configTable)
