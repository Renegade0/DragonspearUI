function proficiencyOrGeneralHelp()
	local prof = chargen.proficiency[currentChargenProficiency]
	local skill = chargen.thief_skill[currentChargenThiefSkill]
	if prof and prof.desc ~= -1 then
		return Infinity_FetchString(prof.desc)
	elseif skill and skill.desc ~= -1 then
		return Infinity_FetchString(skill.description)
	else
		if(chargen.levelingUp) then
			if(levelUpInfoToggle == 1) then
				return chargen.charInfo
			else
				return chargen.levelInfo
			end
		else
			return Infinity_FetchString(`REF_CHARGEN_PROFICIENCY_HELP`)
		end
	end
end

function getProficienciesTitle()
	if(chargen.levelingUp) then
		return t("LEVEL_UP_TITLE")
	else
		return t("CHARGEN_TITLE")
	end
end

function isChargenProficienciesBackButtonClickable()
	return ((not chargen.levelingUp) and createCharScreen:GetCurrentStep() ~= const.STEP_DUALCLASS_PROFICIENCIES)
end