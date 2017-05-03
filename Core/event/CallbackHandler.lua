-- Author      : Tom
-- Create Date : 2/22/2017 10:52:51 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

--[[
	Tells the callback what addon was loaded
	@param {function} callback
	@param {table} args
	@return {undefined}
]]--
function AchievementBook:OnAddonLoaded(callback,args)
	self:AddListener("ADDON_LOADED", function(listener, ...)
		local callback = listener.arg.callback;
		local addonName = select(1,...);
		local args = listener.arg.args;
		callback(addonName, listener, args);
	end,{
		callback = callback,
		args = args
	});
end


--[[
	Dispatches the callback if the 
	Blizzard AchievementUI is loaded
	@param {function} callback
	@returns {undefined}
]]--
function AchievementBook:OnBlizzardAchievementUiLoaded(callback)
	local args = {
		self = self,
		callback = callback
	};
	self:OnAddonLoaded(function(addonName, listener, args)
		if addonName == "Blizzard_AchievementUI" then
			local self = args.self;
			local callback = args.callback;
			self:RemoveListener(listener, "AchievementUI loaded, job is done!");
			callback(self);
		end
	end, args);
end