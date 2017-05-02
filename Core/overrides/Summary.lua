-- Author      : Tom
-- Create Date : 2/18/2017 1:06:59 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

--[[
	The new summary update function
]]--
function AchievementBook:UpdateSummary(...)
	 self:HideButtons();
	 self:HideCategories()
end


--[[
	The original summary update function
]]--
function AchievementBook:UpdateSummaryOld(...)
	self:ShowButtons();
	self._oldAchievementFrameSummary_UpdateAchievements(...);
end


--[[
	Override the summary update
]]--
function AchievementBook:OverrideSummaryUpdate()
	self._oldAchievementFrameSummary_UpdateAchievements = AchievementFrameSummary_UpdateAchievements;
	AchievementFrameSummary_UpdateAchievements = function(...)
		if achievementFunctions == AchievementBook:GetFunctions() then
			AchievementBook:UpdateSummary(...);
		else
			AchievementBook:UpdateSummaryOld(...);
		end
	end
end