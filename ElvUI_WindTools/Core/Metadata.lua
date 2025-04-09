local W, F, E, L, V, P, G = unpack((select(2, ...)))

local pairs = pairs
local tinsert = tinsert
local tostring = tostring

local GetCurrentRegionName = GetCurrentRegionName
local GetLFGDungeonInfo = GetLFGDungeonInfo
local GetLocale = GetLocale
local GetMaxLevelForPlayerExpansion = GetMaxLevelForPlayerExpansion
local GetRealmID = GetRealmID
local GetRealmName = GetRealmName
local GetSpecializationInfoForClassID = GetSpecializationInfoForClassID

local C_ChallengeMode_GetMapUIInfo = C_ChallengeMode.GetMapUIInfo
local C_CVar_GetCVarBool = C_CVar.GetCVarBool

-- WindTools
W.Title = L["WindTools"]
W.PlainTitle = gsub(W.Title, "|c........([^|]+)|r", "%1")

-- Environment
W.Locale = GetLocale()
W.ChineseLocale = strsub(W.Locale, 0, 2) == "zh"
W.SupportElvUIVersion = 13.82
W.UseKeyDown = C_CVar_GetCVarBool("ActionButtonUseKeyDown")

-- Game
W.MaxLevelForPlayerExpansion = GetMaxLevelForPlayerExpansion()
W.ClassColor = _G.RAID_CLASS_COLORS[E.myclass]

-- Mythic+
W.MythicPlusMapData = {
	-- https://wago.tools/db2/MapChallengeMode
	-- https://wago.tools/db2/GroupFinderActivityGrp
	[247] = { abbr = L["[ABBR] The MOTHERLODE!!"], activityID = 140, timers = { 1188, 1584, 1980 } },
	[370] = { abbr = L["[ABBR] Operation: Mechagon - Workshop"], activityID = 257, timers = { 1152, 1536, 1920 } },
	[382] = { abbr = L["[ABBR] Theater of Pain"], activityID = 266, timers = { 1224, 1632, 2040 } },
	[499] = { abbr = L["[ABBR] Priory of the Sacred Flame"], activityID = 324, timers = { 1116, 1488, 1860 } },
	[500] = { abbr = L["[ABBR] The Rookery"], activityID = 325, timers = { 1116, 1488, 1860 } },
	[504] = { abbr = L["[ABBR] Darkflame Cleft"], activityID = 322, timers = { 1188, 1584, 1980 } },
	[506] = { abbr = L["[ABBR] Cinderbrew Meadery"], activityID = 327, timers = { 1188, 1584, 1980 } },
	[525] = { abbr = L["[ABBR] Operation: Floodgate"], activityID = 371, timers = { 1188, 1584, 1980 } },
}

-- Other 11.x dungeons
-- [501] = { abbr = L["[ABBR] The Stonevault"], activityID = 328, timers = { 1188, 1584, 1980 } },
-- [502] = { abbr = L["[ABBR] City of Threads"], activityID = 329, timers = { 1260, 1680, 2100 } },
-- [503] = { abbr = L["[ABBR] Ara-Kara, City of Echoes"], activityID = 323, timers = { 1080, 1440, 1800 } },
-- [505] = { abbr = L["[ABBR] The Dawnbreaker"], activityID = 326, timers = { 1116, 1488, 1860 } },

W.MythicPlusSeasonAchievementData = {
	[20525] = { sortIndex = 1, abbr = L["[ABBR] The War Within Keystone Master: Season One"] },
	[20526] = { sortIndex = 2, abbr = L["[ABBR] The War Within Keystone Hero: Season One"] },
	[41533] = { sortIndex = 3, abbr = L["[ABBR] The War Within Keystone Master: Season Two"] },
	[40952] = { sortIndex = 4, abbr = L["[ABBR] The War Within Keystone Hero: Season Two"] },
}

-- https://www.wowhead.com/achievements/character-statistics/dungeons-and-raids/the-war-within/
-- var a=""; document.querySelectorAll("tbody.clickable > tr a.listview-cleartext").forEach((h) => a+=h.href.match(/achievement=([0-9]*)/)[1]+',');console.log(a);
W.RaidData = {
	[2645] = {
		abbr = L["[ABBR] Nerub-ar Palace"],
		tex = 5779391,
		achievements = {
			{ 40267, 40271, 40275, 40279, 40283, 40287, 40291, 40295 },
			{ 40268, 40272, 40276, 40280, 40284, 40288, 40292, 40296 },
			{ 40269, 40273, 40277, 40281, 40285, 40289, 40293, 40297 },
			{ 40270, 40274, 40278, 40282, 40286, 40290, 40294, 40298 },
		},
	},
	[2779] = {
		abbr = L["[ABBR] Liberation of Undermine"],
		tex = 6392630,
		achievements = {
			{ 41299, 41303, 41307, 41311, 41315, 41319, 41323, 41327 },
			{ 41300, 41304, 41308, 41312, 41316, 41320, 41324, 41328 },
			{ 41301, 41305, 41309, 41313, 41317, 41321, 41325, 41329 },
			{ 41302, 41306, 41310, 41314, 41318, 41322, 41326, 41330 },
		},
	},
}

W.SpecializationInfo = {}

W.RealRegion = (function()
	local region = GetCurrentRegionName()
	if region == "KR" and W.ChineseLocale then
		region = "TW" -- Fix taiwan server region issue
	end

	return region
end)()

W.CurrentRealmID = GetRealmID()
W.CurrentRealmName = GetRealmName()

function W:InitializeMetadata()
	for id in pairs(W.MythicPlusMapData) do
		local name, _, timeLimit, tex = C_ChallengeMode_GetMapUIInfo(id)
		W.MythicPlusMapData[id].name = name
		W.MythicPlusMapData[id].tex = tex
		W.MythicPlusMapData[id].idString = tostring(id)
		W.MythicPlusMapData[id].timeLimit = timeLimit
		if W.MythicPlusMapData[id].timers then
			W.MythicPlusMapData[id].timers[#W.MythicPlusMapData[id].timers] = timeLimit
		end
	end

	for id in pairs(W.MythicPlusSeasonAchievementData) do
		W.Utilities.Async.WithAchievementID(id, function(data)
			W.MythicPlusSeasonAchievementData[id].name = data[2]
			W.MythicPlusSeasonAchievementData[id].tex = data[10]
			W.MythicPlusSeasonAchievementData[id].idString = tostring(id)
		end)
	end

	for id in pairs(W.RaidData) do
		local result = { GetLFGDungeonInfo(id) }
		W.RaidData[id].name = result[1]
		W.RaidData[id].idString = tostring(id)
	end

	for classID = 1, 13 do
		local class = {}
		for specIndex = 1, 4 do
			local data = { GetSpecializationInfoForClassID(classID, specIndex) }
			if #data > 0 then
				tinsert(class, { specID = data[1], name = data[2], icon = data[4], role = data[5] })
			end
		end

		tinsert(W.SpecializationInfo, class)
	end

	-- debug: check all achievements
	-- for i, data in ipairs(W.RaidData[2779].achievements) do
	-- 	for j, id in ipairs(data) do
	-- 		W.Utilities.Async.WithAchievementID(id, function(data)
	-- 			E:Delay(1.3 * (i - 1) + j * 0.1, print, data[1], data[2])
	-- 		end)
	-- 	end
	-- end
end
