
function mageMemorizeSpellOrGeneralHelp()
	spl = chargen.choose_spell[currentChargenMemorizeMageSpell]
	if spl == nil then
		return Infinity_FetchString(17253)
	end

	local desc = mageSpells[chargen.currentSpellLevelChoice][spl.key].desc
	if currentChargenMemorizeMageSpell and desc ~= -1 then
		return Infinity_FetchString(desc)
	else
		return Infinity_FetchString(17253)
	end
end
