
function priestMemorizeSpellOrGeneralHelp()
	spl = chargen.choose_spell[currentChargenMemorizePriestSpell]
	if spl == nil then
		return Infinity_FetchString(17253)
	end

	local desc = priestSpells[chargen.currentSpellLevelChoice][spl.key].desc
	if currentChargenMemorizePriestSpell and desc ~= -1 then
		return Infinity_FetchString(desc)
	else
		return Infinity_FetchString(17253)
	end
end
