dlcStatusDescriptionText = ""
dlcStatusButtonText = ""
dlcStatusState = 0

DLC_STATE_WAITING = 0
DLC_STATE_IN_PROGRESS = 1
DLC_STATE_SUCCESS = 2
DLC_STATE_FAILED = 3
DLC_STATE_CANCELLED = 4
DLC_STATE_RESTORING_PURCHASES = 5
DLC_STATE_RESTORING_PURCHASES_COMPLETE = 6
DLC_STATE_DOWNLOADING = 7

function checkDLCState()
	dlcStatusState = dlcScreen:GetDLCState()
	if dlcStatusState == DLC_STATE_WAITING then
		dlcStatusDescriptionText = t("STRREF_GUI_DLC_WAITING")
		dlcStatusButtonText = t("BACK_BUTTON")
	elseif dlcStatusState == DLC_STATE_IN_PROGRESS then
		dlcStatusDescriptionText = t("STRREF_GUI_DLC_IN_PROGRESS")
		dlcStatusButtonText = t("BACK_BUTTON")
	elseif dlcStatusState == DLC_STATE_SUCCESS then
		dlcStatusDescriptionText = t("STRREF_GUI_DLC_SUCCESS")
		dlcStatusButtonText = t("CONTINUE_BUTTON")
	elseif dlcStatusState == DLC_STATE_FAILED then
		dlcStatusDescriptionText = t("STRREF_GUI_DLC_FAILED")
		dlcStatusButtonText = t("CONTINUE_BUTTON")
	elseif dlcStatusState == DLC_STATE_CANCELLED then
		dlcStatusDescriptionText = t("STRREF_GUI_DLC_CANCELLED")
		dlcStatusButtonText = t("CONTINUE_BUTTON")
	elseif dlcStatusState == DLC_STATE_RESTORING_PURCHASES then
		dlcStatusDescriptionText = t("STRREF_GUI_DLC_RESTORING_PURCHASES")
		dlcStatusButtonText = t("BACK_BUTTON")
	elseif dlcStatusState == DLC_STATE_RESTORING_PURCHASES_COMPLETE then
		dlcStatusDescriptionText = t("STRREF_GUI_DLC_RESTORING_PURCHASES_COMPLETE")
		dlcStatusButtonText = t("CONTINUE_BUTTON")
	elseif dlcStatusState == DLC_STATE_DOWNLOADING then
		dlcScreen:GetDownloadString()
		dlcStatusButtonText = ""
	else
		dlcStatusDescriptionText = "WAFFLES_Dont Know How We Got Here_WAFFLES"
		dlcStatusButtonText = "WAFFLES_WAFFLES_WAFFLES"
	end
end

function getDLCStatusText()
	checkDLCState()
	return dlcStatusDescriptionText
end