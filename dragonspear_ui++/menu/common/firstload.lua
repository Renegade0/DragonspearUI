#if GAME_VERSION ~= 'eet' then
	highlightedCampaign = nil

	--obviously theres some redundancy in this data but I dislike the idea of assuming what our frame/sequence will be.
	startCampaignData = {
		{bigLogo = 0, icon = 0, tooltip = "TOOLTIP_CAMPAIGN_BG", background = 2, button = 2, sidebar = 2, importEnabled = false, tutorialEnabled = true},
		{bigLogo = 2, icon = 1, tooltip = "TOOLTIP_CAMPAIGN_TBP", background = 2, button = 2, sidebar = 2, importEnabled = false, tutorialEnabled = false},
		{bigLogo = 1, icon = 2, tooltip = "TOOLTIP_CAMPAIGN_SOD", background = 2, button = 2, sidebar = 2, importEnabled = true, tutorialEnabled = false}
	}
	startButtons =
	{
		{const.START_CAMPAIGN_SOD, const.START_CAMPAIGN_BP}, --bg
		{const.START_CAMPAIGN_BG, const.START_CAMPAIGN_SOD}, --bp
		{const.START_CAMPAIGN_BG,const.START_CAMPAIGN_BP}, --sod
	}
#end

	function getCampaignHighlight(selected)
		return selected == highlightedCampaign
	end

#if GAME_VERSION ~= 'eet' then
	function getBigLogo()
	#if GAME_VERSION == 'sod' then
		local campaign = startEngine:GetCampaign()
		return startCampaignData[campaign].bigLogo
	#else
		local campaign = nil
		--return startCampaignData[campaign].bigLogo
		if startEngine:GetCampaign() == const.START_CAMPAIGN_BG and isTob == 0 then
			campaign = 0
		elseif startEngine:GetCampaign() == const.START_CAMPAIGN_BG and isTob == 1 then
			campaign = 1
		elseif startEngine:GetCampaign() == const.START_CAMPAIGN_BP then
			campaign = 2
		end
		return campaign
	#end
	end
#end

	function getCampaignIcon(buttonNum)
		local campaign = startEngine:GetCampaign()
		return startCampaignData[startButtons[campaign][buttonNum]].icon
	end

	function getCampaignTooltip(buttonNum)
		local campaign = startEngine:GetCampaign()
		return t(startCampaignData[startButtons[campaign][buttonNum]].tooltip)
	end

	function getCampaignButtonSequence()
		local campaign = startEngine:GetCampaign()
		return startCampaignData[campaign].button
	end

	function onCampaignButton(buttonNum)
		local campaign = startEngine:GetCampaign()
		local clickedCampaign = startButtons[campaign][buttonNum]
		if(clickedCampaign == const.START_CAMPAIGN_SOD) then
			startEngine:OnCampaignButtonClick('SOD',true)
		elseif(clickedCampaign == const.START_CAMPAIGN_BP) then
			startEngine:OnTBPButtonClick(true)
		elseif(clickedCampaign == const.START_CAMPAIGN_BG) then
			startEngine:OnSoAButtonClick(true)
		end
	end
	function getCampaignImportEnabled()
		local campaign = startEngine:GetCampaign()
		return startCampaignData[campaign].importEnabled
	end
	function getTutorialEnabled()
		--Tutorial and campaign import should never be enabled for the same campaign - the button uses the same space
		local campaign = startEngine:GetCampaign()
		return startCampaignData[campaign].tutorialEnabled
	end
	function getSidebarFrame()
		local campaign = startEngine:GetCampaign()
		return startCampaignData[campaign].sidebar
	end
	function getMenuPanelArea()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
#if GAME_VERSION == 'eet' then
	Infinity_SetArea('campSelectRect', nil, screenHeight-305, nil, nil)
	Infinity_SetArea('campSelectList', nil, screenHeight-300, nil, nil)
	Infinity_SetArea('campaignBookDescription', nil, screenHeight-300, nil, nil)
#end
	Infinity_SetArea('MenuPanel1', screenWidth-444, nil, nil, nil)
	Infinity_SetArea('MenuPanel1SP', screenWidth-444, nil, nil, nil)
	Infinity_SetArea('MenuPanel1OP', screenWidth-444, nil, nil, nil)
--	Infinity_SetArea('MenuPanel2', 72, screenHeight-188, nil, nil)
--	Infinity_SetArea('MenuLogo', screenWidth-410, nil, nil, nil)
--	Infinity_SetArea('MenuLogoSP', screenWidth-410, nil, nil, nil)
#if GAME_VERSION == 'sod' then
	Infinity_SetArea('MenuTitle1', screenWidth-486, nil, nil, nil)
	Infinity_SetArea('MenuTitle1SP', screenWidth-486, nil, nil, nil)
	Infinity_SetArea('MenuTitle1OP', screenWidth-486, nil, nil, nil)
#elseif GAME_VERSION == 'bg2' then
	Infinity_SetArea('MenuTitle1', screenWidth-510, nil, nil, nil)
	Infinity_SetArea('MenuTitle1SP', screenWidth-510, nil, nil, nil)
	Infinity_SetArea('MenuTitle1OP', screenWidth-510, nil, nil, nil)
#else
	Infinity_SetArea('MenuTitle1', screenWidth-635, nil, nil, nil)
	Infinity_SetArea('MenuTitle1SP', 20, nil, nil, nil)
	Infinity_SetArea('MenuTitle1OP', 20, nil, nil, nil)
#end
#if GAME_VERSION == 'eet' then
	Infinity_SetArea('MenuTitle2', screenWidth-605, nil, nil, nil)
	Infinity_SetArea('MenuTitle2SP', screenWidth-605, nil, nil, nil)
	Infinity_SetArea('MenuTitle2OP', screenWidth-605, nil, nil, nil)
#else
	Infinity_SetArea('MenuTitle2', screenWidth-510, nil, nil, nil)
	Infinity_SetArea('MenuTitle2SP', screenWidth-510, nil, nil, nil)
	Infinity_SetArea('MenuTitle2OP', screenWidth-510, nil, nil, nil)
#end
	Infinity_SetArea('MenuTitle3', screenWidth-532, nil, nil, nil)
	Infinity_SetArea('MenuTitle3SP', screenWidth-532, nil, nil, nil)
	Infinity_SetArea('MenuTitle3OP', screenWidth-532, nil, nil, nil)
#if GAME_VERSION == 'eet' then
	Infinity_SetArea('MenuButton1', screenWidth-530, 250, 400, 70)
	Infinity_SetArea('MenuButton1SP', screenWidth-384, 3, nil, nil)
	Infinity_SetArea('MenuButton2', screenWidth-530, 330, 400, 70)
	Infinity_SetArea('MenuButton2SP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton3', screenWidth-530, 410, 400, 70)
	Infinity_SetArea('MenuButton3SP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton4', screenWidth-530, 490, 400, 70)
#else
	Infinity_SetArea('MenuButton1', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton1SP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton2', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton2SP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton3', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton3SP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton4', screenWidth-384, nil, nil, nil)
#end
	Infinity_SetArea('MenuButton4x', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton4SP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton4xSP', screenWidth-384, nil, nil, nil)
#if GAME_VERSION == 'eet' then
	Infinity_SetArea('MenuButton5', screenWidth-530, 570, 400, 70)
	Infinity_SetArea('MenuButton5SP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton6', screenWidth-530, 650, 400, 70)
	Infinity_SetArea('MenuButton6SP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton7', screenWidth-530, 750, 400, 70)
#else
	Infinity_SetArea('MenuButton5', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton5SP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton6', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton6SP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton7', screenWidth-384, nil, nil, nil)
#end
	Infinity_SetArea('MenuButton7SP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuButton5OP', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuOptionsArea', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuCampLabel1', 60, screenHeight-210, nil, nil)
	Infinity_SetArea('MenuCampLabel2', 58, screenHeight-212, nil, nil)
	Infinity_SetArea('MenuCampA1', 41, screenHeight-163, nil, nil)
	Infinity_SetArea('MenuCampA2', 175, screenHeight-163, nil, nil)
	Infinity_SetArea('MenuCampA3', 309, screenHeight-163, nil, nil)
	Infinity_SetArea('MenuCampB1', 56, screenHeight-148, nil, nil)
	Infinity_SetArea('MenuCampB2', 190, screenHeight-148, nil, nil)
	Infinity_SetArea('MenuCampB3', 324, screenHeight-148, nil, nil)
	Infinity_SetArea('MenuCChooser1', 58, screenHeight-146, nil, nil)
	Infinity_SetArea('MenuCChooser2', 192, screenHeight-146, nil, nil)
	Infinity_SetArea('MenuCChooser3', 326, screenHeight-146, nil, nil)
#if GAME_VERSION ~= 'eet' then
	Infinity_SetArea('flames', 324, nil, nil, nil)
#end
--	Infinity_SetArea('flames2', screenWidth-420, nil, nil, nil)
--	Infinity_SetArea('flames3', screenWidth-420, nil, nil, nil)
	Infinity_SetArea('MenuVsLabel', screenWidth-132, screenHeight-41, nil, nil)
--	Infinity_SetArea('MenuVsLab1', 167, screenHeight-63, nil, nil)
	Infinity_SetArea('MenuOpLabel', screenWidth-384 , nil, nil, nil)
--	end
	end
--MenuCampA1 81 887  215 887  349 887
--MenuCampB1 96 902  230 902  364 902
--MenuCampLabel1 100 840  98 838

#if GAME_VERSION ~= 'eet' then
	usingSODStartMenu = 1
#end