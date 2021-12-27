	versionString = ""
	function canClickSaveLoad()
		return game:IsClient() == false
	end

	function getEscMenuArea()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
	Infinity_SetArea('RGOPT1', nil, nil, screenWidth, screenHeight)
	Infinity_SetArea('RGOPT2', (screenWidth-628)/2, (screenHeight-628)/2, nil, nil)
	Infinity_SetArea('RGVERSTRING', (screenWidth-145)/2, screenHeight-33, nil, nil)
	Infinity_SetArea('RGBUT_GAMEPLAY', (screenWidth/2)+354, (screenHeight/2)-270, nil, nil)
	Infinity_SetArea('RGBUT_GRAPHICS', (screenWidth/2)+394, (screenHeight/2)-70, nil, nil)
	Infinity_SetArea('RGBUT_SOUND', (screenWidth/2)+354, (screenHeight/2)+130, nil, nil)
	Infinity_SetArea('RGBUT_LOAD', (screenWidth/2)-510, (screenHeight/2)-270, nil, nil)
	Infinity_SetArea('RGBUT_QUIT', (screenWidth/2)-550, (screenHeight/2)-70, nil, nil)
	Infinity_SetArea('RGBUT_SAVE', (screenWidth/2)-510, (screenHeight/2)+130, nil, nil)
	if startEngine:GetCampaign() == const.START_CAMPAIGN_BG then
	Infinity_SetArea('RGESCLOGO', (screenWidth-589)/2, (screenHeight-580)/2, nil, nil)
	else
	Infinity_SetArea('RGESCLOGO', (screenWidth-586)/2, (screenHeight-582)/2, nil, nil)
	end
	end