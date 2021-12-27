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