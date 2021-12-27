function restoreOverlayFromQuit()
	--restore the old overlay if applicable
	if oldOverlayMenuName and oldOverlayMenuName ~= 'QuitMenu' then
		Infinity_SetOverlay(oldOverlayMenuName)
	else
		Infinity_SetOverlay(nil)
	end
end