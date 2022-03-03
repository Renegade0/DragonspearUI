graphicsToggles = {
{'FULL_SCREEN_LABEL', `REF_FULL_SCREEN_LABEL`, 9 , 0, 0, 0},
{'HARDWARE_CURSOR_LABEL', `REF_HARDWARE_CURSOR_LABEL`, 13, 0, 0, 0},
{'SCALE_UI_LABEL', `REF_SCALE_UI_LABEL`, 14, 0, 0, 0},
{'ZOOM_LOCK_LABEL', `REF_ZOOM_LOCK_LABEL`, 36, 0, 0, 0},
{'SPRITE_OUTLINE_LABEL', `REF_SPRITE_OUTLINE_LABEL`, 15, 0, 0, 0},
{'GREYSCALE_ON_PAUSE_LABEL', `REF_GREYSCALE_ON_PAUSE_LABEL`, 66, 0, 0, 0},
{'HIGHLIGHT_SPRITE_LABEL', `REF_HIGHLIGHT_SPRITE_LABEL`, 67, 0, 0, 0},
{'DITHER_ALWAYS_LABEL',18021, 52, 0, 0, 0},
{'SHOW_HP_LABEL',`REF_SHOW_HP_LABEL`, 53, 0, 0, 0},
{'SHOW_HEALTHBAR_LABEL',`REF_SHOW_HEALTHBAR_LABEL`, 65, 0, 0, 0},
{'SHOW_BLACK_SPACE_LABEL','SHOW_BLACK_SPACE_DESCRIPTION', 69, 0, 0, 0},
{'NEAREST_NEIGHBOUR_LABEL','NEAREST_NEIGHBOUR_DESCRIPTION', 70, 0, 0, 0},
{'AREA_MAP_ZOOM_TRANSITION_LABEL','AREA_MAP_ZOOM_TRANSITION_DESCRIPTION', 71, 0, 0, 0}
}

addedDirectx = false
function appendDirectXOption()
	if addedDirectx == false then
		dxOption = {'DIRECTX_LABEL', `REF_DIRECTX_LABEL`, 68, 0, 0, 0}
		table.insert(graphicsToggles, dxOption)
		addedDirectx = true
	end
end

selectedGraphicOpt = 0

fontSizeSLDR = 0
fontSizeCancel = 0
function formatGraphicsInfoString()
	return options['Graphics']['version'] .. "\nrunning on " .. options['Graphics']['renderer'] .. "\ndriver provided by " .. options['Graphics']['vendor']
end