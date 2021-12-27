scriptList_idx = 0
showingSmartOptions = false
function formatScriptName(text)
	local i =  string.find(text, ":", #text)
	if(i) then
		text = string.sub(text,1, i - 1)
	end
	if(#text > 35) then
		text = string.sub(text,1, 35)
		text = text .. "..."
	end
	return text
end

scriptOptions =
{
	{'SCRIPT_ATTACK_ENEMIES_LABEL',			'SCRIPT_ATTACK_ENEMIES_DESCRIPTION',		 1, 0, 0},
	{'SCRIPT_USE_MELEE_WEAPONS_LABEL',		'SCRIPT_USE_MELEE_WEAPONS_DESCRIPTION',		 2, 0, 0},
	{'SCRIPT_USE_RANGED_WEAPONS_LABEL',		'SCRIPT_USE_RANGED_WEAPONS_DESCRIPTION',	 3, 0, 0},
	{'SCRIPT_USE_ITEMS_LABEL',				'SCRIPT_USE_ITEMS_DESCRIPTION',				 4, 0, 0},
	{'SCRIPT_USE_SPECIAL_ABILITIES_LABEL',	'SCRIPT_USE_SPECIAL_ABILITIES_DESCRIPTION',	 5, 0, 0},
	{'SCRIPT_USE_OFFENSIVE_SPELLS_LABEL',	'SCRIPT_USE_OFFENSIVE_SPELLS_DESCRIPTION',	 6, 0, 0},
	{'SCRIPT_USE_DEFENSIVE_SPELLS_LABEL',	'SCRIPT_USE_DEFENSIVE_SPELLS_DESCRIPTION',	 7, 0, 0},
	{'SCRIPT_FIND_TRAPS_LABEL',				'SCRIPT_FIND_TRAPS_DESCRIPTION',			 8, 0, 0},
	{'SCRIPT_HIDE_IN_SHADOWS_LABEL',		'SCRIPT_HIDE_IN_SHADOWS_DESCRIPTION',		 9, 0, 0},
	{'SCRIPT_SING_BATTLESONG_LABEL',		'SCRIPT_SING_BATTLESONG_DESCRIPTION',		10, 0, 0},
	{'SCRIPT_TURN_UNDEAD_LABEL',			'SCRIPT_TURN_UNDEAD_DESCRIPTION',			11, 0, 0}
}

function handleScriptOptionChange(option)
	local wasOn = scriptOptions[option][4] == 2

	if option == 2 then --Melee
		if wasOn == true then
			scriptOptions[option][4] = 0
			scriptOptions[option][5] = false
		else
			scriptOptions[option][4] = 2
			scriptOptions[option][5] = true
			scriptOptions[option+1][4] = 0
			scriptOptions[option+1][5] = false
		end
	elseif option == 3 then --Ranged
		if wasOn == true then
			scriptOptions[option][4] = 0
			scriptOptions[option][5] = false
		else
			scriptOptions[option][4] = 2
			scriptOptions[option][5] = true
			scriptOptions[option-1][4] = 0
			scriptOptions[option-1][5] = false
		end
	elseif option == 8 then --Find Traps
		if wasOn == true then
			scriptOptions[option][4] = 0
			scriptOptions[option][5] = false
		else
			scriptOptions[option][4] = 2
			scriptOptions[option][5] = true
			scriptOptions[option+1][4] = 0
			scriptOptions[option+1][5] = false
			scriptOptions[option+2][4] = 0
			scriptOptions[option+2][5] = false
			scriptOptions[option+3][4] = 0
			scriptOptions[option+3][5] = false
		end
	elseif option == 9 then --Hide
		if wasOn == true then
			scriptOptions[option][4] = 0
			scriptOptions[option][5] = false
		else
			scriptOptions[option][4] = 2
			scriptOptions[option][5] = true
			scriptOptions[option-1][4] = 0
			scriptOptions[option-1][5] = false
			scriptOptions[option+1][4] = 0
			scriptOptions[option+1][5] = false
			scriptOptions[option+2][4] = 0
			scriptOptions[option+2][5] = false
		end
	elseif option == 10 then --Sing
		if wasOn == true then
			scriptOptions[option][4] = 0
			scriptOptions[option][5] = false
		else
			scriptOptions[option][4] = 2
			scriptOptions[option][5] = true
			scriptOptions[option-2][4] = 0
			scriptOptions[option-2][5] = false
			scriptOptions[option-1][4] = 0
			scriptOptions[option-1][5] = false
			scriptOptions[option+1][4] = 0
			scriptOptions[option+1][5] = false
		end
	elseif option == 11 then --Turn
		if wasOn == true then
			scriptOptions[option][4] = 0
			scriptOptions[option][5] = false
		else
			scriptOptions[option][4] = 2
			scriptOptions[option][5] = true
			scriptOptions[option-3][4] = 0
			scriptOptions[option-3][5] = false
			scriptOptions[option-2][4] = 0
			scriptOptions[option-2][5] = false
			scriptOptions[option-1][4] = 0
			scriptOptions[option-1][5] = false
		end
	else
		scriptOptions[option][4] = toggleFrame(scriptOptions[option][4])
		if scriptOptions[option][4] == 0 then
			scriptOptions[option][5] = false
		else
			scriptOptions[option][5] = true
		end
	end
end