-- Author      : Tom
-- Create Date : 2/17/2017 2:34:06 PM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

--[[ 
	The slash handler
	@param {string} message
	@param {table} editbox
	@returns {undefined}
--]]
function AchievementBook:SlashHandler(message, editbox)
	if message == "show" then
		self:Show();
	elseif message == "hide" then
		self:Hide();
	elseif message == "reset" then
		self:ResetAchievements();
	end
end

--[[ 
	Initializes the slash commands
    @param {String[]} slashVariants
    @return null
--]]
function AchievementBook:InitializeCommands(slashVariants)
	for i,v in ipairs(slashVariants) do
		_G["SLASH_ACHIEVEMENTBOOK" .. i] = "/" .. v;
    end
	SlashCmdList["ACHIEVEMENTBOOK"] = function(message, editbox) 
		AchievementBook:SlashHandler(message, editbox) 
	end
end

