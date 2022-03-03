
feedbackToggles = {
{'COLORED_MARKERS_LABEL',			'COLORED_MARKERS_HELP', 			38, 0, 0},
{'CLASSIC_MARKERS_LABEL',			'CLASSIC_MARKERS_HELP', 			45, 0, 0},
{'ENABLE_CONFIRMATION_LABEL',		'ENABLE_CONFIRMATION_HELP', 		41, 0, 0},
{'DISABLE_COSMETIC_ATTACKS_LABEL',	'DISABLE_COSMETIC_ATTACKS_HELP', 	43, 0, 0},
{'JOURNAL_POPUPS_LABEL',			'JOURNAL_POPUPS_HELP', 				44, 0, 0},
{'EQUIPMENT_COMPARISON_LABEL',      'EQUIPMENT_COMPARISON_DESCRIPTION', 46, 0, 0}
}

messagesToggles = {
{'TO_HIT_ROLLS_LABEL',		'TO_HIT_ROLLS_HELP', 	10, 0, 0},
{'ACTIONS_LABEL', 			'ACTIONS_HELP', 		12, 0, 0},
{'STATE_CHANGES_LABEL',		'STATE_CHANGES_HELP', 	13, 0, 0},
{'COMBAT_INFO_LABEL',		'COMBAT_INFO_HELP', 	11, 0, 0},
{'SELECTION_TEXT_LABEL',	'SELECTION_TEXT_HELP',	14, 0, 0},
{'MISC_LABEL',				'MISC_HELP', 			15, 0, 0}
}

selFeedOpt = 0
selMessageOpt = 0
helpString = 0

markerFeedSLDR = 0
locatorFeedSLDR = 0

function getFrequency(d,includeHighter)
	strref = ""
	if ( d ==0 ) then
		strref = "MINIMUM"
	elseif (d == 1) then
		strref = "LOW"
	elseif (d == 2) then
		strref = "MEDIUM"
	elseif (d == 3) then
		strref = "HIGH"
	elseif (d == 4 and includeHighter == true) then
		strref = "HIGHER"
	elseif (d == 4 and includeHighter == false) then
		strref = "MAXIMUM"
	elseif (d == 5) then
		strref = "MAXIMUM"
	end
	return t(strref)
end
