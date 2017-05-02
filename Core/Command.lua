-- Author      : Tom
-- Create Date : 2/17/2017 2:34:06 PM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

--[[ 
	The slash handler
	@param {String} message
	@param {Object} editbox
--]]
function AchievementBook:SlashHandler(message, editbox)
	if message == "show" then
		AchievementBook:Show();
	elseif message == "hide" then
		AchievementBook:Hide();
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

