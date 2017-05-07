-- Author      : Tom
-- Create Date : 2/17/2017 10:20:24 PM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");


--[[
	Initializes the model
	@returns {undefined}
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


--[[
	Save the criteria
    @param {table} criteria
    @returns {undefined}
 ]]--
function AchievementBook:SaveCriteria(criteria)
	self.db.char.criterias[criteria.key] = time();
end


--[[
	Delete the criteria
    @param {table} criteria
    @returns {undefined}
 ]]--
function AchievementBook:DeleteCriteria(criteria)
	self.db.char.criterias[criteria.key] = nil;
end



--[[
	Save the achievement
	@param {table} achievement
	@returns {undefined]
 ]]--
function AchievementBook:SaveAchievement(achievement)
	self.db.char.achievements[achievement.key] = time();
end


--[[
	Delete the achievement
	@param {table} achievement
	@returns {undefined]
 ]]--
function AchievementBook:DeleteAchievement(achievement)
	self.db.char.achievements[achievement.key] = nil;
end