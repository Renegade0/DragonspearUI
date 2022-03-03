OptionsButtons =
{
	{text = "CREDITS_BUTTON", menu = "CREDITS", sequence = 0},
	{text = "GAMEPLAY_BUTTON", menu = "OPTIONS_GAMEPLAY", sequence = 0},
	{text = "GRAPHICS_BUTTON", menu = "OPTIONS_GRAPHICS", sequence = 1},
	{text = "LANGUAGE_BUTTON", menu = "OPTIONS_LANGUAGE", sequence = 0},
	{text = "MOVIES_BUTTON", menu = "", sequence = 2},
	{text = "SOUND_BUTTON", menu = "OPTIONS_SOUND", sequence = 1},
}
function onStartOptionClick()
	Infinity_PlaySound('GAM_09')
	if(selectedMenuOpt == 1 and startEngine:GetCampaign() == const.START_CAMPAIGN_SOD) then
		Infinity_PushMenu( 'SODCREDIT' )
		--If in SOD, display the end credits
		--Infinity_PopMenu('START_OPTIONS')
		--chapterScreen:StartTextScreen( "25ecred" )
		--e:SelectEngine(chapterScreen)
		selectedMenuOpt = NIL
		return
	end

	if OptionsButtons[selectedMenuOpt].menu ~= '' then
		Infinity_PushMenu( OptionsButtons[selectedMenuOpt].menu )
	else
		e:SelectEngine(moviesScreen)
	end
	selectedMenuOpt = NIL
end