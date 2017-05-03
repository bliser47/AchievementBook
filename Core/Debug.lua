-- Author      : Tom
-- Create Date : 2/17/2017 10:15:29 PM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");


--[[
	Debug print function
	@param {?} obj
	@returns {undefined}
]]--
function AchievementBook:Debug(obj)
	if self.debug then
		if type(obj) == "table" then
			for i,v in pairs(obj) do
				print(i);
				self:Debug(v);
			end
		else
			print(obj);
		end
	end
end
