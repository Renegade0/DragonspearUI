chargen = {

	races = {},
	kits = {},

}
function chargenAcceptOrExport()
	if createCharScreen:GetEngineState() == 4 then
		return t("EXPORT_BUTTON")
	else
		return t("ACCEPT_BUTTON")

	end
end

