#if GAME_VERSION == 'eet' then
--function setCurrent()
--	PWSMod = CurrentVer
--	Infinity_SetINIValue('Game Options','PWSFirstLoad','2.21')
--	Infinity_PopMenu('FirstLoad')
--end
function getTitle()
	return startCampaignData[currentCampaign].title
end

function getBigLogo()
	return startCampaignData[currentCampaign].bigLogo
end

function getCampaignButtonSequence()
	return startCampaignData[currentCampaign].button
end

function getEETTitle(row)
	local campaign = startCampaignData[row]
	return campaign and eetStrings[campaign.name]
end

function getEETDescription(row)
	local campaign = startCampaignData[row]
	return campaign and eetStrings[campaign.description]
end

function onCampaignButton(buttonNum)
	if startCampaignData[buttonNum] ~= nil then
		startEngine:OnCampaignButtonClick(startCampaignData[buttonNum].id,true)
		Infinity_SetINIValue('Program Options','Active Campaign',buttonNum)
	else
		startEngine:OnCampaignButtonClick('BG1',true)
		Infinity_SetINIValue('Program Options','Active Campaign',const.START_CAMPAIGN_BG1)
	end
	currentCampaign = buttonNum
end

function getCampaignImportEnabled()
	return startCampaignData[currentCampaign].importEnabled
end

function getTutorialEnabled()
	--Tutorial and campaign import should never be enabled for the same campaign - the button uses the same space
	return startCampaignData[currentCampaign].tutorialEnabled
end

function getSidebarFrame()
	return startCampaignData[currentCampaign].sidebar
end
#else
function setCurrent()
	PWSMod = CurrentVer
	Infinity_SetINIValue('Game Options','PWSFirstLoad','2.21')
	Infinity_PopMenu('FirstLoad')
end
#end
CurrentVer = "2.21" 		-- This is what you will call this version when you release it
OldVer = "2.2" 			-- This is the highest older version

function duiInitSettings(opts)
	local opts = opts or {}
	local setting = function(name, expected, default, fallback)
		local get = type(expected) == 'string' and Infinity_GetINIString or Infinity_GetINIValue
		local value = get('Game Options', name, fallback or default)
		if value ~= expected then
			value = default
			Infinity_SetINIValue('Game Options', name, value)
		end
		return value
	end

	if opts.doFirstLoad then
		PWSMod = setting('PWSFirstLoad', CurrentVer, OldVer, 1)
		if PWSMod == OldVer then
			Infinity_PushMenu('FirstLoad')
		end
	end

	if not opts.eet then
		LeftSideMenu = Infinity_GetINIValue('Game Options', 'LeftSideMenu', 0)
		ClassicDialog = setting('ClassicDialog', 1, 0)
		MultiPortraitPicker = setting('MultiPortraitPicker', 0, 1)
	end

	LargePortraits = setting('LargePortraits', 1, 0)
	PermThief = setting('PermThief', 1, 0)
	JournalSize = setting('SelectedJournalSize', UIStrings.UI_Small, UIStrings.UI_Large, 1)
	QuicklootMode = setting('QuicklootMode', UIStrings.UI_Advanced, UIStrings.UI_Expert, 1)
	QuicklootStartPref = setting('QuicklootStartPreference', UIStrings.UI_Visible, UIStrings.UI_Hidden, 1)
	groundItemsButtonToggle = QuicklootStartPref == UIStrings.UI_Visible and 1 or 0

	local valid = { Two = true, Three = true, Four = true, Five = true, Six = true }
	QuicklootENum = Infinity_GetINIString('Game Options', 'QuicklootENumber', 1)
	if not valid[QuicklootENum] then
		QuicklootENum = 'Ten'
		Infinity_SetINIValue('Game Options', 'QuicklootENumber', QuicklootENum)
	end
end