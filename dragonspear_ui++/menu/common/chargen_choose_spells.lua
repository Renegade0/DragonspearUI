function specialistFrame(num)
	if choose_spell[num] and spellBook[chargen.currentSpellLevelChoice][choose_spell[num].key].specialist then
		return 3
	end
	return 0
end
function spellLearnOrUnlearnText()
	if currentChargenChooseMageSpell == nil or not chargen.choose_spell[currentChargenChooseMageSpell].enabled then
		return t("BUTTON_LEARN")
	else
		return t("BUTTON_UNLEARN")
	end
end
function spellLearnOrUnlearnClickable()
	spl = chargen.choose_spell[currentChargenChooseMageSpell]
	if chargen.extraSpells == 0 and spl ~= nil and spl.enabled == false or spl == nil or spl.known then
		return false
	else
		return true
	end
end


function chooseSpellOrGeneralHelp()
	local helpText = chargen.helpText
	spl = chargen.choose_spell[currentChargenChooseMageSpell]
	if spl == nil then
		return helpText
	end

	local desc = spellBook[chargen.currentSpellLevelChoice][spl.key].desc
	if currentChargenChooseMageSpell and desc ~= -1 then
		return Infinity_FetchString(desc)
	else
		return helpText
	end
end
function rgUnlearnDefault()
	-- randomCharacter might be 0 when leveling up, if we went through the chargen
	-- and haven't restarted the game yet, so the global variable is still there
	if randomCharacter == 0 and not chargen.levelingUp then
		for i, spell in pairs(chargen.choose_spell) do
			-- make sure that we don't accidently click on a known spell, we can't unlearn it,
			-- but can lose spell slots if we do click on it
			if spell.enabled and not spell.known then
				createCharScreen:OnLearnMageSpellButtonClick(i)
			end
		end
	end
end

function nextOrDone()
	if(createCharScreen:HasMoreMageLevels()) then
		return t('NEXT_BUTTON')
	else
		return t('DONE_BUTTON')
	end
end
function shouldShowSpecialistMessage()
	local ret = false

	if chargen.extraSpells == 0 and not createCharScreen:IsDoneButtonClickable() then
		ret = true
	end

	return ret
end

function scrollSpellSlots(direction)
	local spells = chargen.choose_spell
	local offset = choose_spell.offset or 0
	local n = #spells

	direction = direction or -scrollDirection or 0

	if direction < 0 and offset >= 30 then
		offset = offset - 30
	elseif direction > 0 and offset + 30 <= n then
		offset = offset + 30
	end

	for i = 1, 30 do
		choose_spell[i] = spells[i + offset]
	end
	choose_spell.offset = offset
	choose_spell.page_info = math.ceil((offset + 1) / 30) .. " / " .. math.ceil(n / 30)
end

function onSpellSlotEnter(i)
	if choose_spell[i] then
		desc = spellBook[chargen.currentSpellLevelChoice][choose_spell[i].key].desc
		rgspelldesc = 1
	end
end

function onSpellSlotClick(i)
	if choose_spell[i] and not choose_spell[i].known then
		createCharScreen:OnLearnMageSpellButtonClick(i + choose_spell.offset)
	end
end