list_GUICG_20_2_idx = 0
function NextOrDone()
	if createCharScreen:GetImportState() == 1 then
		return t("NEXT_BUTTON")
	else
		return t("DONE_BUTTON")
	end
end