AchievementBook = LibStub("AceAddon-3.0"):NewAddon("AchievementBook", "AceConsole-3.0", "AceEvent-3.0" );

function AchievementBook:OnEnable()
	self.frame = AchievementBook_MainFrame;
	self:InitializeModel();
	self:InitializeCommands({"ab","achievementbook"});
	self:InitializeEventHandler();
	self:InitializeEventListener();
	self:InitializeCore();
	self:InitializeOverride();
	self:InitializeAchievements();
end

function AchievementBook:OnDisable()

end