-- Author      : Tom
-- Create Date : 5/02/2017 1:04:33 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");



--[[
	Start listening to an event for a criteria
	@param {string} event
	@param {table} criteria
	@returns {undefined}
]]--
function AchievementBook:LoadEvent(event, criteria)
    self:Debug("Loading event: " .. event);
    criteria.listeners = criteria.listeners or {};
    table.insert(criteria.listeners, self:AddListener(event, function(listener, ...)
        local criteria = listener.arg.criteria;
        local self = listener.arg.self;
        if criteria.objective(...) then
            self:CompleteCriteria(criteria);
        end
    end, {
        criteria = criteria,
        self = self
    }));
end