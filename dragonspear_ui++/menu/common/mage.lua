
function magePageInfo()
	if bookMode == 0 then -- Regular
		if characters[id].hasSorcererBook then
			return t("SPELLS_CAN_CAST_LABEL") .. ": " .. characters[id].mageDetails[currentSpellLevel].slotsRemaining .. "/" .. characters[id].mageDetails[currentSpellLevel].maxMemorized
		else
			return t("MEMORIZED_LABEL") .. ": " .. #bottomSpells .. "/" .. characters[id].mageDetails[currentSpellLevel].maxMemorized
		end
	elseif bookMode == 1 then -- Sequencer/Contingency
		return t("SPELLS_LABEL") .. ": " .. #bottomSpells .. "/" .. #bottomSpellsPlaceHolder

	end
	return ""
end

contingencyDescription = 0

function mageBookDescription()
	if mageBookEnabled == true then
		if bookMode == 0 then
			if characters[id].mageSpells[currentSpellLevel][currentBookSpell] then
				return Infinity_FetchString(characters[id].mageSpells[currentSpellLevel][currentBookSpell].description)
			else
				return t('SPELL_MEMORIZATION_HELP')
			end
		elseif bookMode == 1 then
			if contingencyDescription == 0 and currentBookSpell ~= 0 then
				return Infinity_FetchString(bookSpells[currentBookSpell].description)
			else
				lastCurrentBookSpell = 0
				if contingencyDescription == 0 then
					contingencyDescription = mageBookStrings[contingencyResRef].tip
				end
				return Infinity_FetchString(contingencyDescription)
			end
		end
	end
	return ""
end
function mageBookTitle()
	if bookMode == 1 and mageBookStrings[contingencyResRef] then
		return t(mageBookStrings[contingencyResRef].title)
	else
		return t('MAGE_BOOK_LABEL')
	end
end
function mageBookAction()
	if bookMode == 1 and mageBookStrings[contingencyResRef] then
		return t(mageBookStrings[contingencyResRef].action)
	else
		return t(characters[id].name)
	end
end


function makeBlankTable(num)
	local out = {}
	for i = 1,num do
		table.insert(out, {})
	end
	return out
end

function contingencyComplete()
	if showContingency then
		return #bottomSpells == #bottomSpellsPlaceHolder and (currentContingencyCondition or 0) > 0 and (currentContingencyTarget or 0) > 0
	else
		return #bottomSpells == #bottomSpellsPlaceHolder
	end
end

function contingencyDoneButtonText()
	if contingencyComplete() then
		return t("DONE_BUTTON")
	else
		return t("CANCEL_BUTTON")
	end
end

function filterMemorizedSpells(spells, level)
	local out = {}
	currentSpellLevel = math.min(currentSpellLevel, #spells)

	if level == 0 or level == nil then
		level = currentSpellLevel
	end

	for k,v in pairs(spells[level]) do
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

function tableInsert(out, v)
	if mageScreen:SpellSwappedInContingency(v.resref) then
		for key,value in pairs(contingencySwapTable) do
			value.castableCount = v.castableCount
			table.insert(out, value)
		end
	else
		table.insert(out, v)
	end
end

function filterContingencyMageSpells()
	local out = {}
	if characters[id].mageSpells ~= nil and characters[id].mageSpells[currentSpellLevel] ~= nil then
		for k,v in pairs(characters[id].mageSpells[currentSpellLevel]) do
			if v.castableCount > 0 and mageScreen:SpellAllowedForContingency(v.level, v.resref) then
				tableInsert(out, v)
			end
		end
	end
	if characters[id].priestSpells ~= nil and characters[id].priestSpells[currentSpellLevel] ~= nil then
		for k,v in pairs(characters[id].priestSpells[currentSpellLevel]) do
			if v.castableCount > 0 and mageScreen:SpellAllowedForContingency(v.level, v.resref) then
				tableInsert(out, v)
			end
		end
	end
	return out
end

function findFirstDifferenceInSpellList(oldList, newList)
	local ret = -1
	local spellIndex = 1

	if oldList ~= nil and newList ~= nil then
		while oldList[spellIndex] ~= nil do
			if newList[spellIndex] == nil then
				print("New list empty at point "..spellIndex)
				ret = spellIndex
				break
			end
			if oldList[spellIndex].icon ~= newList[spellIndex].icon then
				print("Lists differ at point "..spellIndex.." "..oldList[spellIndex].icon.." vs "..newList[spellIndex].icon)
				ret = spellIndex
				break
			end
			spellIndex = spellIndex + 1
		end
		if oldList[spellIndex] == nil and newList[spellIndex] ~= nil then
			print("New list has a new spell at point "..spellIndex)
			ret = spellIndex
		end
	end

	return ret
end

showMageMemorizationFlash = false

function refreshMageBook()
	if currentSpellLevel == nil then
		currentSpellLevel = 1
	end
	if bookMode == 0 then
		local mageSpells = characters[id].mageSpells
		bookSpells = mageSpells[currentSpellLevel]
		if characters[id].hasMageBook then
			local spells = {}
			for i = 0, 9 do
				spells[i] = filterMemorizedSpells(mageSpells, i)
			end

			if showMageMemorizationFlash == true then
				createMageMemorizationSparkle(0,0,36,36,"memorizedListMage", findFirstDifferenceInSpellList(bottomSpells, spells.current))
				showMageMemorizationFlash = false
			end

			bottomSpells = spells[0]
			bottomSpellsPlaceHolder = makeBlankTable(characters[id].mageDetails[currentSpellLevel].maxMemorized)
			for i = 1, 9 do
				_G['bottomSpells' .. i] = spells[i]
				_G['bottomSpellsPlaceHolder' .. i] = makeBlankTable(characters[id].mageDetails[i].maxMemorized)
			end
		else
			bottomSpells = {}
			bottomSpellsPlaceHolder = {}
			for i = 1, 9 do
				_G['bottomSpells' .. i] = {}
				_G['bottomSpellsPlaceHolder' .. i] = {}
			end
		end
	elseif bookMode == 1 then
		bookSpells = filterContingencyMageSpells()
		bottomSpells = sequencerSpells
		bottomSpellsPlaceHolder = makeBlankTable(contingencyMaxSpells)
		contingencyDescription = mageBookStrings[contingencyResRef].tip
	end

	-- hide description on book refresh
	currentSpell = nil
	MageBook:update(bookSpells)
end

function setMageBookLevel(num)
	lastCurrentBookSpell = 0
	currentBookSpell = 0
	currentSpellLevel = num
	MageBook.page = 1
	refreshMageBook()
end

function addMageBookLevel(value)
	local level = currentSpellLevel + value

	if level >= 1 and level <= 9 then
		setMageBookLevel(level)
	end
end

function incrementMageBookLevel()
	addMageBookLevel(1)
end

function decrementMageBookLevel()
	addMageBookLevel(-1)
end

currentAnimationID = 1
updateCounterMemorizationSparkles = 1

function updateMemorizationSparkles()
	local sparkleNumber = 1
	updateCounterMemorizationSparkles = updateCounterMemorizationSparkles + 1
	if updateCounterMemorizationSparkles > 2 then
		updateCounterMemorizationSparkles = 1
		for sparkleNumber = 1, #(memorizationFlashes), 1 do
			if memorizationFlashes[sparkleNumber][1] == true then
				memorizationFlashes[sparkleNumber][2] = memorizationFlashes[sparkleNumber][2] + 1
				if memorizationFlashes[sparkleNumber][2] > 7 then
					memorizationFlashes[sparkleNumber][1] = false
					memorizationFlashes[sparkleNumber][2] = 0
					memorizationFlashes[sparkleNumber][3] = true
				end
			end
		end
	end
end

function destroyMemorizationSparkle(instanceId)
	local ret = memorizationFlashes[instanceId][3]
	memorizationFlashes[instanceId][3] = false
	return ret
end

function showMemorizationSparkle(instanceId)
	updateMemorizationSparkles()
	return memorizationFlashes[instanceId][1]
end

function createMageMemorizationSparkle(x,y,w,h, fromList, listIndex)
	Infinity_InstanceAnimation("TEMPLATE_mageMemorizationSparkle","FLASHBR",x,y,w,h,fromList,listIndex)
	memorizationFlashes[currentAnimationID][1] = true
	memorizationFlashes[currentAnimationID][3] = false
	currentAnimationID = currentAnimationID + 1
	if currentAnimationID > #(memorizationFlashes) then
		currentAnimationID = 1
	end
end

function findMemorizedUncastable(resref)
	local index = 1
	local sparkle = -1
	for index = 1, #(bottomSpells), 1 do
		if bottomSpells[index].resref == resref then
			if bottomSpells[index].castable == 0 then
				sparkle = index
				break
			end
		end
	end

	return sparkle
end

function unmemorizingMageSpell(resref)
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

	createMageMemorizationSparkle(0, 0, 36, 36, 'memorizedListMage' .. level, sparkle)
end

function unmemorizeMageSpell(spell, book)
	if spell then
		showMageMemorizationFlash = false
		mageScreen:UnmemorizeSpell( spell.level, spell.memorizedIndex )
		Infinity_PlaySound('GAM_44')
		-- scroll to the page that contains the spell
		book:setPage(math.ceil((spell.index + 1) / 24))
	end
end

function getSpellButtHighlight(num)
	if currentSpellLevel == num then
		return 2
	else return 0
	end
end

memorizationFlashes =
{
	{false, 0, false},
	{false, 0, false},
	{false, 0, false},
	{false, 0, false},
	{false, 0, false},
	{false, 0, false},
	{false, 0, false},
	{false, 0, false},
	{false, 0, false},
	{false, 0, false}
}

MageBook = SpellBook:create()

function MageBook:unmemorizeSpell(level, spells, slot)
	local spell = spells[slot]
	if not spell then
		return
	end
	setMageBookLevel(level)

	if findMemorizedUncastable(spell.resref) == -1 and Infinity_GetOption(41, 9) ~= 0 then
		popup2Button(11824, 'REMOVE_BUTTON', function() unmemorizeMageSpell(spell, self) end, 'CANCEL_BUTTON')
	else
		unmemorizeMageSpell(spell, self)
	end
end

function MageBook:eraseCurrentSpell()
	if currentSpell and bookMode == 0 and characters[id].hasSorcererBook == false then
		popup2Button('`REF_CONFIRM_ERASE_SPELL`', 'REMOVE_BUTTON', function()
			mageScreen:EraseKnownSpell(currentSpell.resref)
			currentSpell = nil
		end)
	end
end

function MageBook:memorizeSpell(spell, listName, index)
	if not spell or #bottomSpells >= #bottomSpellsPlaceHolder then
		return
	end

	if bookMode == 0 then
		createMageMemorizationSparkle(0, 0, 38, 38, listName, index)
		Infinity_PlaySound('GAM_24')
		mageScreen:MemorizeSpell(spell.level, spell.index)
	elseif bookMode == 1 then
		mageScreen:SequenceSpell(spell.resref, spell.masterResref)
	end

	return spell
end
