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
    for _, criteria in ipairs(achievement.criterias) do
        criteria.parent = achievement;
        if not self.db.char.achievements[achievement.key] then
            self:LoadCriteria(criteria);
        else
           criteria.complete = true;
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
function AchievementBook:CheckAchievementComplete(achievement)
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

    achievement.complete = true;

    self:SaveAchievement(achievement);
    self:OnEvent("ACHIEVEMENT_BOOK_ACHIEVEMENT_COMPLETE",achievement);
    self:Debug("Completing achievement: " .. achievement.name);
end


--[[
    Reset the passed achievements
    @param {table} achievement
    @param {boolean} onLoad
]]--
function AchievementBook:ResetAchievement(achievement, onLoad)
    if achievement.next then
        self:ResetAchievement(GetNextAchievement(achievement.id,nil,onLoad));
    end
    achievement.complete = false;
    self:DeleteAchievement(achievement);
    self:OnEvent("ACHIEVEMENT_BOOK_ACHIEVEMENT_RESET",achievement);
    self:Debug("Reseting achievement: " .. achievement.name);
    for _, criteria in ipairs(achievement.criterias) do
        self:ResetCriteria(criteria);
    end
    self:LoadAchievement(achievement);
end