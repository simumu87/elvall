local W, F, E, L = unpack((select(2, ...)))
local S = W.Modules.Skins

local _G = _G

function S:Blizzard_WeeklyRewards()
	if not self:CheckDB("weeklyRewards") then
		return
	end

	self:CreateShadow(_G.WeeklyRewardsFrame)

	if _G.WeeklyRewardExpirationWarningDialog then
		self:CreateShadow(_G.WeeklyRewardExpirationWarningDialog.NineSlice)
	end
end

S:AddCallbackForAddon("Blizzard_WeeklyRewards")
