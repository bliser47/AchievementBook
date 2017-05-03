-- Author      : Tom
-- Create Date : 2/18/2017 1:06:59 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");



function AchievementBook:HideButtons()
	self:HideObjects(AchievementFrameSummaryAchievements.buttons);
end

function AchievementBook:ShowButtons()
	self:ShowObjects(AchievementFrameSummaryAchievements.buttons);
end


function AchievementBook:HideCategories()
	self:HideObjects(AchievementFrameCategoriesContainer.buttons);
end

function AchievementBook:ShowCategories()
	self:ShowObjects(AchievementFrameCategoriesContainer.buttons);
end


function AchievementBook:ShowObjects(objects)
	if objects then
		for _, object in ipairs(objects) do
			object:Show();
		end
	end
end

function AchievementBook:HideObjects(objects)
	if objects then
		for _, object in ipairs(objects) do
			object:Hide();
		end
	end
end


--[[
	Initialize the override
	@return null
]]--
function AchievementBook:InitializeOverride()
	self:OnBlizzardAchievementUiLoaded(function(self)
		self:AddCustomTab();
		self:OverrideOnTabClick();
		self:OverrideSummaryUpdate();
	end);
end
