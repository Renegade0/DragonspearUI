#if WITH_LEFT_SIDE_PORTRAITS then
duiLeftSidePortrait = Infinity_GetINIValue('Game Options', 'Left Side Portrait', 0)
#end

function onPortraitsSidebarOpen()
	if(worldScreen == e:GetActiveEngine() and game:GetPartyAI()) then aiButtonToggle = 1 end
	if(worldScreen == e:GetActiveEngine()) then Infinity_PushMenu('WORLD_LEVEL_UP_BUTTONS') end
	if QuicklootStartPref == UIStrings.UI_Visible and groundItemsButtonToggle == 1 then
		worldScreen:StartGroundItems()
		groundItemsButtonToggle = 1
	elseif QuicklootStartPref == UIStrings.UI_Visible and groundItemsButtonToggle == 0 then
		worldScreen:StopGroundItems()
		groundItemsButtonToggle = 0
	elseif QuicklootStartPref == UIStrings.UI_Hidden and groundItemsButtonToggle == 1 then
		worldScreen:StartGroundItems()
		groundItemsButtonToggle = 1
	elseif QuicklootStartPref == UIStrings.UI_Hidden and groundItemsButtonToggle == 0 then
		worldScreen:StopGroundItems()
		groundItemsButtonToggle = 0
	end
end