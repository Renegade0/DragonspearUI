function kitOrGeneralHelp()
	kit = chargen.kit[currentChargenKit]
	if kit then
		return Infinity_FetchString(kit.desc)
	else
		return Infinity_FetchString(17242)
	end
end

currentChargenKit = 0
function getKitBackground(row)
	if(row == currentChargenKit) then
		return "RGCGBT2"
	else
		return "RGCGBT1"
	end
end