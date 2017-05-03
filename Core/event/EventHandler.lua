-- Author      : Tom
-- Create Date : 2/17/2017 4:06:05 PM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook")


--[[
	Register an event
	@param {string} event
	@returns {undefined}
--]]
function AchievementBook:RegisterEvent(event)
	self:Debug("Registering Event: " .. event);
	self.frame:RegisterEvent(event);
end


--[[
	Unregister an event
	@param {string} event
	@returns {undefined}
--]]
function AchievementBook:UnregisterEvent(event)
	self:Debug("Unregistering Event: " .. event);
	self.frame:UnregisterEvent(event);
end


--[[
	Return whether we are already
	listening to an event or not
	@param {string} addEvent
	@returns {boolean}
]]--
function AchievementBook:AlreadyListening(addEvent)
	for _, event in ipairs(self.events) do
		if event == addEvent then
			return true;
		end
	end
	return false;
end


--[[
	Start listening to an event
	if not already listening to it
	@param {string} addEvent
	@returns {undefined}
]]--
function AchievementBook:Listen(addEvent)
	if not self:AlreadyListening(addEvent) then
		table.insert(self.events, addEvent);
		self:RegisterEvent(addEvent);
	end
end


--[[
	Stop listening to an event
	@param {string} removeEvent
	@returns {undefined}
]]--
function AchievementBook:StopListening(removeEvent)
	for index, event in ipairs(self.events) do
		if event == removeEvent then
			table.remove(self.events, index);
			return self:UnregisterEvent(event);
		end
	end
end


--[[
	When an event happens
	@param {string} event
	@param {list} ...
	@returns {undefined}
]]--
function AchievementBook:OnEvent(event, ...)
	for _, listener in ipairs(self.listeners) do
		if listener.event == event then
			self:DispatchListener(listener, ...);
		end
	end
end


--[[
	Initialize the events
	@return null
]]--
function AchievementBook:InitializeEventHandler()
	self.events = self.events or {};
	self.frame:SetScript("OnEvent", function(_, event, ...)
		AchievementBook:OnEvent(event, ...);
	end);
end