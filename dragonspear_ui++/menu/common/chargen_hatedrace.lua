function hatedRaceOrGeneralHelp()
	race = chargen.hatedRace[currentChargenHatedRace]
	if race then
		return Infinity_FetchString(race.desc)
	else
		return Infinity_FetchString(17256)
	end
end

currentChargenHatedRace = 0
function getHatedRaceBackground(row)
	if(row == currentChargenHatedRace) then
		return "RGCGBT2"
	else
		return "RGCGBT1"
	end
end