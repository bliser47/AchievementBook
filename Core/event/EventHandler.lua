-- Author      : Tom
-- Create Date : 2/17/2017 4:06:05 PM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook")


--[[
	Register an event
	@param {String} event
	@return null
--]]
function AchievementBook:RegisterEvent(event)
	self:Debug("Registering Event: " .. event);
	self.frame:RegisterEvent(event);
end


--[[
	Unregister an event
	@param {String} event
	@return null
--]]
function AchievementBook:UnregisterEvent(event)
	self:Debug("Unregistering Event: " .. event);
	self.frame:UnregisterEvent(event);
end


--[[
	Return whether we are already
	listening to an event or not
	@param {String} addEvent
	@return {Boolean}
]]--
function AchievementBook:AlreadyListening(addEvent)
	for index, event in ipairs(self.events) do
		if event == addEvent then
			return true;
		end
	end
	return false;
end


--[[
	Start listening to an event
	if not already listening to it
	@param {String} addEvent
	@return null
]]
function AchievementBook:Listen(addEvent)
	if not self:AlreadyListening(addEvent) then
		table.insert(self.events, addEvent);
		self:RegisterEvent(addEvent);
	end
end


--[[
	Stop listening to an event
	@param {String} removeEvent
	@return null
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
	@param {String} event
	@param {Object[]} ...
	@return null
]]--
function AchievementBook:OnEvent(event, ...)
	for index, listener in ipairs(self.listeners) do
		if listener.event == event then
			self:DispatchListener(listener, ...);
		end
	end
end


--[[
	Initialize the events
	@return null
--]]
function AchievementBook:InitializeEventHandler()
	self.events = self.events or {};
	self.frame:SetScript("OnEvent", function(self, event, ...)
		AchievementBook:OnEvent(event, ...);
	end);
end