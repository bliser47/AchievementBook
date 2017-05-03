-- Author      : Tom
-- Create Date : 2/18/2017 1:04:33 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");


--[[
	Initializes the core
	@returns {undefined}
]]--
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

--[[
    Returns the functions to be used
    for the BlizzardAchievementUI
    @returns {table} functions
]]--
function AchievementBook:GetFunctions()
	return self.functions;
end


--[[
	Initialize the achievements
	@returns {undefined}
]]--
function AchievementBook:InitializeAchievements()
	self:Debug("Initializing achievements");
	if self.achievements then
		for _, achievement in pairs(self.achievements) do
			self:LoadAchievement(achievement);
		end
	end
end


