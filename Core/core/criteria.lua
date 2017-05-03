-- Author      : Tom
-- Create Date : 5/02/2017 1:04:33 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

--[[
	Initialize a criteria
	@param {table} criteria
	@returns {undefined}
]]--
function AchievementBook:LoadCriteria(criteria)
    self:Debug("Loading criteria " .. criteria.key);
    if not self.db.char.criterias[criteria.key] then
        for _, event in ipairs(criteria.events) do
            self:LoadEvent(event,criteria);
        end
    end
end


--[[
	Complete a criteria
	@param {table} criteria
	@returns {undefined}
]]--
function AchievementBook:CompleteCriteria(criteria)
    self:Debug("Completing criteria: " .. criteria.key);
    self:SaveCriteria(criteria);
    if criteria.listeners then
        for _, listener in ipairs(criteria.listeners) do
            self:RemoveListener(listener, "criteria complete: " .. criteria.key );
        end
    end
    self:OnEvent("ACHIEVEMENT_BOOK_CRITERIA_COMPLETE",criteria);
    self:CheckAchievementComplete(criteria.parent);
end