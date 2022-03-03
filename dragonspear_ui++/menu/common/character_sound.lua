list_GUIREC_20_5_idx = 0
doneEnabled = 0

function compareCustomSound(s1, s2)
	-- DEFAULT, then normal alphabetically, then AoN alphabetically (result must be strictly less than)
	if s1.sound == "DEFAULT" or s2.sound == "DEFAULT" then
		return s2.sound ~= "DEFAULT"
	end

	local s1_is_aon = s1.sound:sub(1, 4) == "BDTP"
	local s2_is_aon = s2.sound:sub(1, 4) == "BDTP"

	if s1_is_aon ~= s2_is_aon then
		return s2_is_aon
	end

	return s1.sound < s2.sound
end

function prepareSounds(soundTable)
	-- preserve original indices to return as selection
	local i;
	for i = 1, #soundTable, 1 do
		local s = soundTable[i];
		if (type(s) == "string") then
			soundTable[i] = {
				index = i,
				sound = s
			}
		end
	end

	table.sort(soundTable, compareCustomSound)
end

function getSoundStringRef(rowNumber, tab)
	if ( filenames_stringrefs[tab[rowNumber].sound] ~= nil ) then
		return Infinity_FetchString(filenames_stringrefs[tab[rowNumber].sound][1])
	else
		return tab[rowNumber].sound
	end
end