-- Author      : Tom
-- Create Date : 2/18/2017 1:15:59 AM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

--[[
	Initialize the listeners
	@return null
]]--
function AchievementBook:InitializeEventListener()
	self.listeners = self.listeners or {};
end

--[[
	Dispatches a listeners callback then it removes
    the listener if it was only listening once
	@param {Object} listener
	@param {Object[]} ...
	@return null
]]--
function AchievementBook:DispatchListener(listener, ...)
	listener.callback(listener, ...);
	if listener.count then
		listener.count = listener.count - 1;
		if listener.count <= 0 then
			self:RemoveListener(listener, " was only a one time listener");
		end
	end
end


--[[
	Adds a listener wich will only listen once
	@param {String} event
	@param {Function} callback
	@return {Object}
]]--
function AchievementBook:AddListenerOnce(event, callback)
	return self:AddListener(event, callback, null, 1);
end


--[[
	Adds a callback for an events with possible count
	@param {String} event
	@param {Function} callback
	@param {table} [arg]
	@param {Number} [count]
	@return {Object}
]]--
function AchievementBook:AddListener(event, callback, arg, count)
	self:Listen(event);
	local listener = {
		event = event,
		callback = callback,
        arg = arg,
		count = count
	};
	table.insert(self.listeners, listener);
	return listener;
end


--[[
	Removes a listener
	@param {Object} removeListener
	@param {String} explanation
	@return null
]]--
function AchievementBook:RemoveListener(removeListener, explanation)
	self:Debug("Removing listener: " .. removeListener.event .. " (" .. explanation  .. ")");
	local anyoneElseListening = false;
	local removeIndexes = {};
	for index, listener in ipairs(self.listeners) do
		if listener == removeListener then
			table.insert(removeIndexes,index);
		elseif listener.event == removeListener.event then
			anyoneElseListening = true;
		end
	end
	for _, removeIndex in ipairs(removeIndexes) do
		table.remove(self.listeners, removeIndex);
	end
	if not anyoneElseListening then
		self:StopListening(removeListener.event);
	end
	removeListener = null;
end