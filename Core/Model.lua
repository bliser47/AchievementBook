-- Author      : Tom
-- Create Date : 2/17/2017 10:20:24 PM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

function AchievementBook:GetAchievements()
	return self.achievements;
end

--[[
	Initializes the model
	@return null
]]--
function AchievementBook:InitializeModel()
	self.db = LibStub("AceDB-3.0"):New("AchievementBookDB", {
		char = {
			setting = true,
		}
	}, true);
	self.db.char.achievements = self.db.char.achievements or {};
	self.db.char.criterias = self.db.char.criterias or {};
	self:Debug("Initialized model");
end