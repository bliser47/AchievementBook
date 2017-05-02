-- Author      : Tom
-- Create Date : 3/9/2017 1:05:31 PM
AchievementBook = LibStub("AceAddon-3.0"):GetAddon("AchievementBook");

--[[
	Add the custom tab for the addon
	@returns {Number} tabId
]]
function AchievementBook:AddCustomTab()
	local tabId = 0
    repeat
        tabId = tabId + 1
    until (not _G["AchievementFrameTab" .. tabId] )

    AchievementBookTab = CreateFrame("Button", "AchievementFrameTab" .. tabId, AchievementFrame, "AchievementFrameTabButtonTemplate")
    AchievementBookTab:SetText("AchievementBook")
    AchievementBookTab:SetPoint("LEFT", "AchievementFrameTab".. tabId-1, "RIGHT", -5, 0)
    AchievementBookTab:SetID(tabId)
    AchievementBookTab:SetScript("OnClick", function()
		AchievementFrameBaseTab_OnClick(tabId);
	end);
    PanelTemplates_SetNumTabs(AchievementFrame, tabId)
    AchievementBookTab:SetAlpha(1)

	return tabId;
end


--[[
	Open the AchievementBook tab
	@param {Number} id
	@returns null
]]--
function AchievementBook:OpenTab(id)
	PanelTemplates_Tab_OnClick(_G["AchievementFrameTab"..id], AchievementFrame);
	local isSummary = false
	AchievementFrameHeaderTitle:SetText("AchievementBook");
	achievementFunctions = AchievementBook:GetFunctions();
	AchievementFrameCategories_GetCategoryList(ACHIEVEMENTUI_CATEGORIES);
	AchievementFrameHeaderPoints:SetText(0);
	AchievementFrameWaterMark:SetTexture("")
	if ( achievementFunctions.selectedCategory == "summary" ) then
	    isSummary = true;
		AchievementFrame_ShowSubFrame(AchievementFrameSummary);
		AchievementFrameSummary_Update(false)
	else
	    AchievementFrame_ShowSubFrame(AchievementFrameAchievements);
	end
	AchievementFrameCategories_Update();
	if ( not isSummary ) then
		achievementFunctions.updateFunc();
	end
end

--[[
	Switch from the AchievementBook tab to a Blizzard one
	@param {Number} id
	@returns null
]]--
function AchievementBook:OpenOldTab(id)
	AchievementFrameHeaderTitle:SetText(ACHIEVEMENT_TITLE);
	AchievementFrameHeaderPoints:SetText(GetTotalAchievementPoints());
	AchievementBook._oldAchievementFrameBaseTab_OnClick(id);
	AchievementFrameSummary_Update(false);
end


--[[
	Override the BaseTab_OnClick function on the Blizzard UI
	@param {Number} achievementBookTabId
	@returns null;
]]--
function AchievementBook:OverrideOnTabClick(achievementBookTabId)
	AchievementBook._oldAchievementFrameBaseTab_OnClick = AchievementFrameBaseTab_OnClick;
	AchievementFrameBaseTab_OnClick = function(id)
		if id == achievementBookTabId then
			AchievementBook:OpenTab(id);
		else
	        AchievementBook:OpenOldTab(id);
		end 
	end
end
