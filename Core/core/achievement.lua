-- Author      : Tom
-- Create Date : 5/02/2017 1:04:33 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");


--[[
	Add an achievement to be loaded
	@param {table} achievement
	@return {number} achievementID
]]--
function AchievementBook:AddAchievement(achievement)
    self.achievementID = self.achievementID or -1;
    self.achievementID = self.achievementID - 1;
    self.achievements = self.achievements or {};
    self.achievements[self.achievementID] = achievement;
    self:Debug("Added achievement: " .. achievement.name);
    return self.achievementID;
end


--[[
	Initialize an achievement
	@param {table} achievement
	@returns {undefined}
]]--
function AchievementBook:LoadAchievement(achievement)
    self:Debug("Loading achievement: " .. achievement.name);
    if not self.db.char.achievements[achievement.key] then
        for _, criteria in ipairs(achievement.criterias) do
            criteria.parent = achievement;
            self:LoadCriteria(criteria);
        end
    end
end


--[[
	Returns all loaded achievements
	@returns {table} achievements
 ]]--
function AchievementBook:GetAchievements()
    return self.achievements;
end


--[[
	Check if the achievement is complete
	@param {table} achievement
	@returns {undefined}
]]--
function AchievementBook:CheckAchievement(achievement)
    local completeCriterias = 0;
    local totalCriterias = 0;
    for _, criteria in ipairs(achievement.criterias) do
        if criteria.complete then
            completeCriterias = completeCriterias + 1;
        end
        totalCriterias = totalCriterias + 1;
    end
    local requiredCriterias = achievement.required or totalCriterias;
    if completeCriterias >= requiredCriterias then
        self:CompleteAchievement(achievement);
    end
end


--[[
	Complete the achievement
	@param {table} achievement
	@param {boolean} onLoad
	@returns {undefined}
]]--
function AchievementBook:CompleteAchievement(achievement,onLoad)
    if achievement.previous then
        self:CompleteAchievement(GetPreviousAchievement(achievement.id,nil,onLoad));
    end
    self:SaveAchievement(achievement);
    self:OnEvent("ACHIEVEMENT_BOOK_ACHIEVEMENT_COMPLETE",achievement);
end