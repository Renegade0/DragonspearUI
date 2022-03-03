function priestPageInfo()
	if characters[id].hasShamanBook then
		return t("SPELLS_CAN_CAST_LABEL") .. ": " .. characters[id].priestDetails[currentSpellLevel].slotsRemaining .. "/" .. characters[id].priestDetails[currentSpellLevel].maxMemorized
	else
		return t("MEMORIZED_LABEL") .. ": " .. #bottomSpells .. "/" .. characters[id].priestDetails[currentSpellLevel].maxMemorized
	end
end

function priestBookDescription()
	if priestBookEnabled == true then
		if characters[id].priestSpells[currentSpellLevel][currentBookSpell] then
			return Infinity_FetchString(characters[id].priestSpells[currentSpellLevel][currentBookSpell].description)
		else
			return t('SPELL_MEMORIZATION_HELP')
		end
	end
	return ""
end

function filterMemorizedPriestSpells(level)
	local out = {}
	currentSpellLevel = math.min(currentSpellLevel, 7)
	level = level or currentSpellLevel

	for k,v in pairs(characters[id].priestSpells[level]) do
		for i=v.memorizedCount, 1, -1 do
			local spell = deepcopy(v)
			if(i <= v.castableCount) then
				spell.castable = 1
			else
				spell.castable = 0
			end
			table.insert(out, spell)
		end
	end
	return out
end


showPriestMemorizationFlash = false

function refreshPriestBook()
	if currentSpellLevel == nil then
		currentSpellLevel = 1
	end

	local priestSpells = characters[id].priestSpells

	if characters[id].hasClericBook then
		local spells = {}
		for i = 0, 7 do
			spells[i] = filterMemorizedSpells(priestSpells, i)
		end

		if showPriestMemorizationFlash == true then
			createPriestMemorizationSparkle(0,0,36,36,"memorizedListPriest", findFirstDifferenceInSpellList(bottomSpells, spells[0]))
			showPriestMemorizationFlash = false
		end

		bottomSpells = spells[0]
		bottomSpellsPlaceHolder = makeBlankTable(characters[id].priestDetails[currentSpellLevel].maxMemorized)
		for i = 1, 7 do
			_G['bottomSpells' .. i] = spells[i]
			_G['bottomSpellsPlaceHolder' .. i] = makeBlankTable(characters[id].priestDetails[i].maxMemorized)
		end
	else
		bottomSpells = {}
		bottomSpellsPlaceHolder = {}
		for i = 1, 7 do
			_G['bottomSpells' .. i] = {}
			_G['bottomSpellsPlaceHolder' .. i] = {}
		end
	end

	-- hide description on book refresh
	currentSpell = nil
	PriestBook:update(priestSpells[currentSpellLevel])
end

function setPriestBookLevel(num)
	lastCurrentBookSpell = 0
	currentBookSpell = 0
	currentSpellLevel = num
	PriestBook.page = 1
	refreshPriestBook()
end

function addPriestBookLevel(value)
	local level = currentSpellLevel + value

	if level >= 1 and level <= 7 then
		setPriestBookLevel(level)
	end
end

function incrementPriestBookLevel()
	addPriestBookLevel(1)
end

function decrementPriestBookLevel()
	addPriestBookLevel(-1)
end

function createPriestMemorizationSparkle(x,y,w,h, fromList, listIndex)
	Infinity_InstanceAnimation("TEMPLATE_priestMemorizationSparkle","FLASHBR",x,y,w,h,fromList,listIndex)
	memorizationFlashes[currentAnimationID][1] = true
	memorizationFlashes[currentAnimationID][3] = false
	currentAnimationID = currentAnimationID + 1
	if currentAnimationID > #(memorizationFlashes) then
		currentAnimationID = 1
	end
end

function unmemorizingPriestSpell(resref)
	local sparkle = -1
	local level = ''

	for index, spell in ipairs(bottomSpells) do
		if spell.resref == resref then
			sparkle = index
			level = spell.level + 1
			if spell.castable == 0 then
				break
			end
		end
	end

	createPriestMemorizationSparkle(0, 0, 36, 36, 'memorizedListPriest' .. level, sparkle)
end

function unmemorizePriestSpell(spell, book)
	if spell then
		showPriestMemorizationFlash = false
		priestScreen:UnmemorizeSpell( spell.level, spell.memorizedIndex )
		Infinity_PlaySound('GAM_44')

		-- scroll to the page that contains the spell
		book:setPage(math.ceil((spell.index + 1) / 24))
	end
end

function getPrSpellButtHighlight(num)
	if currentSpellLevel == num then
		return 2
	else return 0
	end
end


PriestBook = SpellBook:create()

function PriestBook:unmemorizeSpell(level, spells, slot)
	local spell = spells[slot]
	if not spell then
		return
	end
	setPriestBookLevel(level)

	if findMemorizedUncastable(spell.resref) == -1 and Infinity_GetOption(41, 9) ~= 0 then
		popup2Button(11824, 'REMOVE_BUTTON', function() unmemorizePriestSpell(spell, self) end, 'CANCEL_BUTTON')
	else
		unmemorizePriestSpell(spell, self)
	end
end

function PriestBook:memorizeSpell(spell, listName, index)
	if not spell or #bottomSpells >= #bottomSpellsPlaceHolder then
		return
	end

	createPriestMemorizationSparkle(1, 0, 38, 38, listName, index)
	Infinity_PlaySound('GAM_24')
	priestScreen:MemorizeSpell( spell.level, spell.index )

	return spell
end