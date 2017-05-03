-- Author      : Tom
-- Create Date : 5/02/2017 1:04:33 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

--[[
	Adds a category to the AchievementBook
	or to an already existing category
	@param {string} category
	@param {table} [parentCategory]
	@returns {number} categoryID
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


--[[
    Returns all loaded categories
    @returns {table} categories
]]--
function AchievementBook:GetCategoryList()
    return self.categories;
end