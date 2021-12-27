function refreshMageContingency()
	preparedSpells = {}
	for k, v in pairs(characters[id].contingencySpells) do
		table.insert(preparedSpells, v)
	end
	for k, v in pairs(characters[id].sequencerSpells) do
		table.insert(preparedSpells, v)
	end

end