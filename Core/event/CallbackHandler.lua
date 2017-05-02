-- Author      : Tom
-- Create Date : 2/22/2017 10:52:51 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

--[[
	Tells the callback what addon was loaded
	@param {Function} callback
	@return null
]]--
function AchievementBook:OnAddonLoaded(callback)
	self:AddListener("ADDON_LOADED", function(listener, ...)
		callback(select(1,...), listener);
	end);
end


--[[
	Dispatches the callback if the 
	Blizzard AchievementUI is loaded
	@param {Function} callback
	@return null
]]--
function AchievementBook:OnBlizzardAchievementUiLoaded(callback)
	self:OnAddonLoaded(function(addonName, listener)
		if addonName == "Blizzard_AchievementUI" then
			self:RemoveListener(listener, "AchievementUI loaded, job is done!");
			callback();
		end
	end);
end