function alignmentOrGeneralHelp()
	alignment = chargen.alignment[currentChargenAlignment]
	if alignment then
		return Infinity_FetchString(alignment.desc)
	else
		return Infinity_FetchString(9602)
	end
end

currentChargenAlignment = 0
function getAlignmentBackground(row)
	if(row == currentChargenAlignment) then
		return "RGCGBT2"
	else
		return "RGCGBT1"
	end
end