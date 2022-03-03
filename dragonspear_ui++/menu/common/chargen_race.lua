function raceOrGeneralHelp()
	race = chargen.races[currentChargenRace]
	if race then
		return Infinity_FetchString(race.desc)
	else
		return Infinity_FetchString(17237)
	end
end

currentChargenRace = 0
function getRaceBackground(row)
	if(row == currentChargenRace) then
		return "RGCGBT2"
	else
		return "RGCGBT1"
	end
end