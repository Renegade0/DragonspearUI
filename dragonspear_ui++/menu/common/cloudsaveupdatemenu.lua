cloudLoadState=0
function CheckCloudSaveStatus()
	Infinity_UpdateCloudSaveState()
	if(cloudLoadState == 0) then
		Infinity_PopMenu()
	end
	return GetCloudLoadingText()
end
function GetCloudLoadingText()
	if(cloudLoadState == 1 or cloudLoadState == 0) then
		return t('DOWNLOADING_SAVE_NORMAL')
	end
	if(cloudLoadState == 2) then
		return t('SEARCHING_SAVE_NORMAL')
	end
	return t('CLOUD_STATE_UNDEFINED_NORMAL')
end