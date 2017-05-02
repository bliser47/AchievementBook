-- Author      : Tom
-- Create Date : 2/18/2017 1:02:45 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

AchievementBook:AddCategory("Test");
AchievementBook:AddAchievement({
	name = "Default achievement",
	points = 10,
	key = "default",
	criterias = {
		{
			name = "Test name",
			key = "defaultC1",
			description = "Test description",
			events = {"CHAT_MSG_TEXT_EMOTE"},
			objective = function(...)
				local text = select(1,...);
				local source = select(2,...);
				return text:find("dance") and source == UnitName("player")
			end
		}
	}
});

AchievementBook:AddAchievement({
	name = "Default achievement",
	points = 10,
	key = "default2",
	criterias = {
		{
			name = "Test name",
			key = "defaultC2",
			description = "Test description",
			events = {"CHAT_MSG_TEXT_EMOTE"},
			objective = function(...)
				local text = select(1,...);
				local source = select(2,...);
				return text:find("laugh") and source == UnitName("player")
			end
		}
	}
});
