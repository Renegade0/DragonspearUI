function classOrGeneralHelp()
	class = chargen.class[currentChargenClass]
	if class then
		return Infinity_FetchString(class.desc)
	else
		--only bit that may need to change for dual class! :)
		return Infinity_FetchString(17242)
	end
end

currentChargenClass = 0
function getClassBackground(row)
	if(row == currentChargenClass) then
		return "RGCGBT2"
	else
		return "RGCGBT1"
	end
end