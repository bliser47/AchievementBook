-- Author      : Tom
-- Create Date : 2/18/2017 1:04:33 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

function AchievementBook:InitializeCore()
	self.functions = {
	    categoryAccessor = function()
			return AchievementBook:GetCategoryList();
		end,
	    clearFunc = AchievementFrameAchievements_ClearSelection,
	    updateFunc = AchievementFrameAchievements_Update,
	    selectedCategory = "summary",
    };
end

function AchievementBook:GetFunctions()
	return self.functions;
end


function AchievementBook:AddAchievement(achievement)
	self.achievementID = self.achievementID or -1;
	self.achievementID = self.achievementID - 1;
	self.achievements = self.achievements or {};
	self.achievements[self.achievementID] = achievement;
	self:Debug("Added achievement: " .. achievement.name);
	return self.achievementID;
end

--[[
	Adds a category to the AchievementBook
	or to an already existing category
	@param {String} category
	@param {Table} [parentCategory]
]]--
function AchievementBook:AddCategory(categoryName,parentCategory)
	self.categoryID = self.categoryID or -1;
	self.categoryID = self.categoryID - 1;
	self.categories = self.categories or {};
 	self.categories[self.categoryID] = {
		id = categoryID,
		name = categoryName,
		parent = parentCategory or -1,
		achis = {}
	};
	self:Debug("Added category: " .. categoryName);
	return self.categoryID;
end


function AchievementBook:GetCategoryList()
	return self.categories;
end



--[[
	Initialize the achievements
]]--
function AchievementBook:InitializeAchievements()
	self:Debug("Initializing achievements");
	if self.achievements then
		for index, achievement in pairs(self.achievements) do	
			self:LoadAchievement(achievement);
		end
	end
end


--[[
	Initialize an achievement
	@param {Table} achievement
]]--
function AchievementBook:LoadAchievement(achievement)
	self:Debug("Loading achievement: " .. achievement.name);
	if not self.db.char.achievements[achievement.key] then
		for index, criteria in ipairs(achievement.criterias) do
			criteria.parent = achievement;
			self:LoadCriteria(criteria);
		end
	end
end


--[[
	Initialize a criteria
	@param {Table} criteria
]]--
function AchievementBook:LoadCriteria(criteria)
	self:Debug("Loading criteria " .. criteria.key);
	if not self.db.char.criterias[criteria.key] then
		for index, event in ipairs(criteria.events) do
			self:LoadEvent(event,criteria);
		end
	end
end

--[[
	Start listening to an event for a criteria
	@param {String} event
	@param {Table} criteria
]]--
function AchievementBook:LoadEvent(event, criteria)
	self:Debug("Loading event: " .. event);
	criteria.listeners = criteria.listeners or {};
	table.insert(criteria.listeners,self:AddListener(event, function(listener, ...)
		if criteria.objective(...) then
			self:CompleteCriteria(criteria);
		end
	end));
end


--[[
	Complete a criteria
	@param {Table} criteria
]]--
function AchievementBook:CompleteCriteria(criteria)
	self:Debug("Completing criteria: " .. criteria.key);
	self.db.char.criterias[criteria.key] = time();
	if criteria.listeners then
		for index, listener in ipairs(criteria.listeners) do
			self:RemoveListener(listener, "criteria complete: " .. criteria.key );
		end
	end
	self:OnEvent("ACHIEVEMENT_BOOK_CRITERIA_COMPLETE",criteria);
	self:CheckAchievementComplete(criteria.parent);
end


--[[
	Check if the achievement is complete
	@param {Table} achievement
]]--
function AchievementBook:CheckAchievement(achievement)
	local completeCriterias = 0;
	local totalCriterias = 0;
	for index, criteria in ipairs(achievement.criterias) do
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
	@param {Table} achievement
	@param {Boolean} onLoad
]]--
function AchievementBook:CompleteAchievement(achievement,onLoad)
	if achievement.previous then
		self:CompleteAchievement(GetPreviousAchievement(achievement.id,nil,onLoad));
	end
	self.db.achievements[achievement.key] = time();
	self:OnEvent("ACHIEVEMENT_BOOK_ACHIEVEMENT_COMPLETE",achievement);
end