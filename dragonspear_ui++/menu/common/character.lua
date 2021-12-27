--reload language
if(uiTranslationFile) then
	Infinity_DoFile("L_" .. uiTranslationFile)
	dui_set_language(uiTranslationFile)
else
	Infinity_DoFile("L_en_us")

	-- load DUI strings using the language set in Baldur.lua
	dui_set_language()
end

listMetaInfo = {}
combatLog = {}

currentPanelID = 0

function displayTHAC()
	thactxt = ''
	thactxt =  characters[currentID].THAC0.current

	if (characters[currentID].THAC0.offhand ) then
		thactxt = thactxt .. '\n' .. characters[currentID].THAC0.offhand
	end

	return thactxt
end

function displayLabelTHAC()
	thactxt = ''
	thactxt =  characters[currentID].THAC0.current

	if (characters[currentID].THAC0.offhand ) then
		thactxt = thactxt .. '\n' .. t('OFFHAND_LABEL')  .. ': ' .. characters[currentID].THAC0.offhand
	end

	return thactxt
end

function displayLabelDamage()
	local str = characters[currentID].damage.min .. ' - ' .. characters[currentID].damage.max
	if(characters[currentID].damage.minOffhand and characters[currentID].damage.maxOffhand) then
		str = str .. '\n' .. t('OFFHAND_LABEL') .. ': ' .. characters[currentID].damage.minOffhand .. ' - ' .. characters[currentID].damage.maxOffhand
	end
	return str
end

function displayCompiledAC()
	local compiledAC = characters[currentID].AC.current

	if characters[currentID].AC.crushing ~= 0 or characters[currentID].AC.missile ~= 0 or characters[currentID].AC.piercing ~= 0 or characters[currentID].AC.slashing ~= 0 then
		compiledAC = compiledAC .. " (" .. t("MODIFIERS_LABEL") .. ": "

		local numMods = 0
		if characters[currentID].AC.crushing > 0 then
			numMods = numMods + 1
			setStringTokenLua("<ACTOKEN>","+"..characters[currentID].AC.crushing)
			compiledAC = compiledAC .. " " .. t("ACMOD_VS_CRUSHING")
			removeStringTokenLua("<ACTOKEN>")
		elseif characters[currentID].AC.crushing < 0 then
			numMods = numMods + 1
			setStringTokenLua("<ACTOKEN>",characters[currentID].AC.crushing)
			compiledAC = compiledAC .. " " .. t("ACMOD_VS_CRUSHING")
			removeStringTokenLua("<ACTOKEN>")
		end

		if characters[currentID].AC.missile > 0 then
			if numMods > 0 then
				compiledAC = compiledAC .. ", "
			end
			numMods = numMods + 1
			setStringTokenLua("<ACTOKEN>","+"..characters[currentID].AC.missile)
			compiledAC = compiledAC .. " " .. t("ACMOD_VS_MISSILE")
			removeStringTokenLua("<ACTOKEN>")
		elseif characters[currentID].AC.missile < 0 then
			if numMods > 0 then
				compiledAC = compiledAC .. ", "
			end
			numMods = numMods + 1
			setStringTokenLua("<ACTOKEN>",characters[currentID].AC.missile)
			compiledAC = compiledAC .. " " .. t("ACMOD_VS_MISSILE")
			removeStringTokenLua("<ACTOKEN>")
		end

		if characters[currentID].AC.piercing > 0 then
			if numMods > 0 then
				compiledAC = compiledAC .. ", "
			end
			numMods = numMods + 1
			setStringTokenLua("<ACTOKEN>","+"..characters[currentID].AC.piercing)
			compiledAC = compiledAC .. " " .. t("ACMOD_VS_PIERCING")
			removeStringTokenLua("<ACTOKEN>")
		elseif characters[currentID].AC.piercing < 0 then
			if numMods > 0 then
				compiledAC = compiledAC .. ", "
			end
			numMods = numMods + 1
			setStringTokenLua("<ACTOKEN>",characters[currentID].AC.piercing)
			compiledAC = compiledAC .. " " .. t("ACMOD_VS_PIERCING")
			removeStringTokenLua("<ACTOKEN>")
		end

		if characters[currentID].AC.slashing > 0 then
			if numMods > 0 then
				compiledAC = compiledAC .. ", "
			end
			numMods = numMods + 1
			setStringTokenLua("<ACTOKEN>","+"..characters[currentID].AC.slashing)
			compiledAC = compiledAC .. " " .. t("ACMOD_VS_SLASHING")
			removeStringTokenLua("<ACTOKEN>")
		elseif characters[currentID].AC.slashing < 0 then
			if numMods > 0 then
				compiledAC = compiledAC .. ", "
			end
			numMods = numMods + 1
			setStringTokenLua("<ACTOKEN>",characters[currentID].AC.slashing)
			compiledAC = compiledAC .. " " .. t("ACMOD_VS_SLASHING")
			removeStringTokenLua("<ACTOKEN>")
		end

		compiledAC = compiledAC .. ")"
	end

	return compiledAC
end

function displaySTR()
	strtxt = characters[currentID].attr.str.current

	if characters[currentID].attr.str.current == 18 and characters[currentID].attr.str.extra > 0 then
		if characters[currentID].attr.str.extra == 100 then
			strtxt = strtxt .. '/00'
		elseif characters[currentID].attr.str.extra > 9 then
			strtxt = strtxt .. '/' .. characters[currentID].attr.str.extra
		elseif characters[currentID].attr.str.extra > 0 then
			strtxt = strtxt .. '/0' .. characters[currentID].attr.str.extra
		end
	end
	if(characters[currentID].attr.str.current > characters[currentID].attr.str.base or characters[currentID].attr.str.extra > characters[currentID].attr.str.extraBase) then
		strtxt = '^G' .. strtxt .. '^-'
	end
	if(characters[currentID].attr.str.current < characters[currentID].attr.str.base or characters[currentID].attr.str.extra < characters[currentID].attr.str.extraBase) then
		strtxt = '^R' .. strtxt .. '^-'
	end
	return strtxt
end

function GetProfs(str)
	local t = {}
	local tprof = {}
	local tcount = 0
	proftext = ""
	if characters[currentID].proficiencies.weapons.current == nil or characters[currentID].proficiencies.weapons.current == "" then return proftext end
	linescount = select(2, str:gsub('\n', '\n')) + 1
	if linescount ~= 0 then
		local function helper(line) table.insert(t, line) return "" end
		helper((str:gsub("(.-)\r?\n", helper)))

		for i = 1, #t, 1 do
			if string.find(string.lower(t[i]), string.lower("%+%+%+%+%+")) then
				justprof = string.gsub(t[i] , " %+%+%+%+%+$", "")
				lvlprof = "+++++"
				profdesc = 1
				elseif string.find(string.lower(t[i]), string.lower("%+%+%+%+")) then
				justprof = string.gsub(t[i] , " %+%+%+%+$", "")
				lvlprof = "++++"
				profdesc = 2
			elseif string.find(string.lower(t[i]), string.lower("%+%+%+")) then
				justprof = string.gsub(t[i] , " %+%+%+$", "")
				lvlprof = "+++"
				profdesc = 3
			elseif string.find(string.lower(t[i]), string.lower("%+%+")) then
				justprof = string.gsub(t[i] , " %+%+$", "")
				lvlprof = "++"
				profdesc = 4
			elseif string.find(string.lower(t[i]), string.lower("%+")) then
				justprof = string.gsub(t[i] , " %+$", "")
				lvlprof = "+"
				profdesc = 5
			end


			table.insert(tprof, {justprof, lvlprof, profdesc})
		end

		for i = 1, linescount, 1 do
			if i == 1 then
				proftext = '^D' .. tprof[i][1] .. ' ' .. tprof[i][2] .. '^B' .. '\n' .. PDD[tprof[i][3]] .. '\n'
			else
				proftext = proftext .. '^D' .. '\n' .. tprof[i][1] .. ' ' .. tprof[i][2] .. '^B' .. '\n' .. PDD[tprof[i][3]] .. '\n'
			end
		end
		return proftext
	end
end
function GetStyles(str)
	local t = {}
	local tprof = {}
	local tcount = 0
	fstext = ""
	if characters[currentID].proficiencies.fightingstyles.current == nil or characters[currentID].proficiencies.fightingstyles.current == "" then return fstext end
	linescount = select(2, str:gsub('\n', '\n')) + 1
	if linescount ~= 0 then
		local function helper(line) table.insert(t, line) return "" end
		helper((str:gsub("(.-)\r?\n", helper)))

		for i = 1, #t, 1 do
			if string.find(string.lower(t[i]), string.lower("%+%+%+%+%+")) then
				justfs = "Club"
				lvlfs = "+++++"
				fsdesc = 1
			elseif string.find(string.lower(t[i]), string.lower("%+%+%+%+")) then
				justfs = "Club"
				lvlfs = "++++"
				fsdesc = 2
			elseif string.find(string.lower(t[i]), string.lower("%+%+%+")) then
				justfs = string.gsub(t[i] , " %+%+%+$", "")
				lvlfs = "+++"
				if justfs == "Club" then
					fsdesc = 3
				else
					fsdesc = 12
				end
			elseif string.find(string.lower(t[i]), string.lower("%+%+")) then
				justfs = string.gsub(t[i] , " %+%+$", "")
				lvlfs = "++"
				if justfs == "Two-Handed Weapon Style" then
					fsdesc = 6
				elseif justfs == "Sword And Shield Style" then
					fsdesc = 8
				elseif justfs == "Two-Weapon Style" then
					fsdesc = 13
				elseif justfs == "Single-Weapon Style" then
					fsdesc = 10
				elseif justfs == "Club" then
					fsdesc = 4
				end
			elseif string.find(string.lower(t[i]), string.lower("%+")) then
				justfs = string.gsub(t[i] , " %+$", "")
				lvlfs = "+"
				if justfs == "Two-Handed Weapon Style" then
					fsdesc = 7
				elseif justfs == "Sword and Shield Style" then
					fsdesc = 9
				elseif justfs == "Two-Weapon Style" then
					fsdesc = 14
				elseif justfs == "Single-Weapon Style" then
					fsdesc = 11
				elseif justfs == "Club" then
					fsdesc = 5
				end
			end
			table.insert(tprof, {justfs, lvlfs, fsdesc})
		end

		for i = 1, linescount, 1 do
			if i == 1 then
				fstext = '^D' .. tprof[i][1] .. ' ' .. tprof[i][2] .. '^B' .. '\n' .. PDD[tprof[i][3]] .. '\n'
			else
				fstext = fstext .. '\n' .. tprof[i][1] .. ' ' .. tprof[i][2] .. '^B' .. '\n' .. PDD[tprof[i][3]] .. '\n'
			end
		end
		return fstext
	end
end

function has_value(val)
	for index, value in ipairs(statusEffectsReal) do
		if value == val then
			return true
		end
	end

	return false
end

listStrengthAbility = {}
function strengthAbility()
	for k, v in ipairs(characters[currentID].proficiencies.ability) do
		if v.current == 'To hit: +3' then
		table.insert(listStrengthAbility, {v.current, ''})
		end
	end
end

function updateAttrTablex()
listItems = {}

	if statusEffects[1] ~= nil then
		table.insert(listItems, { nil, '^D' .. t('STATUS_EFFECTS_LABEL') .. ':' .. '^B'})
	end
	for k, v in pairs(characters[currentID].statusEffects) do
		table.insert(listItems, {v.current, '    ' .. Infinity_FetchString(v.strRef)})
	end
	if statusEffects[1] ~= nil then
		table.insert(listItems, { nil, '' })
	end
	table.insert(listItems, { nil, '^D' .. t('SKILLS_LABEL') .. ':' .. '^B'})
	table.insert(listItems, { nil, t('LORE_LABEL') .. ': ' .. characters[currentID].proficiencies.lore.current })
	table.insert(listItems, { nil, t('REPUTATION_LABEL') .. ': ' .. characters[currentID].proficiencies.reputation.current })


	for k, v in ipairs(characters[currentID].proficiencies.class_skills) do
		table.insert(listItems, { nil, Infinity_FetchString(v.strRef) .. ': '.. v.current .. '^-'})
	end

	table.insert(listItems, { nil, '' })
	table.insert(listItems, { nil, '^D' .. t('PROFICIENCIES_LABEL') .. ':' .. '^B'})
	if characters[currentID].proficiencies.weapons.current ~= "" then
		table.insert(listItems, { nil, characters[currentID].proficiencies.weapons.current })
	end

	if characters[currentID].proficiencies.fightingstyles.current ~= "" then
		table.insert(listItems, { nil, characters[currentID].proficiencies.fightingstyles.current})
	end

	table.insert(listItems, { nil, '' })
	table.insert(listItems, { nil, '^D' .. t('SAVING_THROWS_LABEL') .. ':' .. '^B'})
	table.insert(listItems, { nil, characters[currentID].proficiencies.savingThrows})
	table.insert(listItems, { nil, '' })
	table.insert(listItems, { nil, '^D' .. t('RESISTANCES_LABEL') .. ':' .. '^B' .. '^B'})
	table.insert(listItems, { nil, characters[currentID].proficiencies.resistances})
	--table.insert(listItems, { nil, '' })
	table.insert(listItems, { nil, '^D' .. '\n' .. t('RG_ABILITY_BONUSES') .. ':^B'})
	for k, v in ipairs(characters[currentID].proficiencies.ability) do
		table.insert(listItems, {nil, v.current})
	end
end

function updateAttrTable()

	--statusEffectsReal = { }
	--for k, v in pairs(characters[currentID].statusEffects) do
	--	table.insert(statusEffectsReal, v)
	--
	--end
	statusEffects = { }
	for k, v in pairs(characters[currentID].statusEffects) do
		table.insert(statusEffects, v)

	end
	--for k, v in pairs(characters[currentID].proficiencies.class_skills) do
	--	table.insert(statusEffects, v)
	--end

	--table.insert(statusEffects, 'SKILLS_LABEL')

	listAbilities = { }
	for k, v in ipairs(characters[currentID].proficiencies.ability) do
			table.insert(listAbilities, {v.strRef, v.current, v.helpStrRef})
			--table.insert(listAbilities, {v.helpStrRef, ''})
		end

		showAbilityBonuses = 1
		showJustText = 0
		showStats = 0
		showSpells = 0
		for k, v in ipairs(listAbilities) do
			helpTextString = helpTextString .. '^M' .. v[2] .. '\n \n'
		end

	listItems = { }
	listTest = { }

	lastID = currentID
	helpTextString = ''
	showClassInfo = 0
	showJustText = 0
	showMemorized = 0
	showBothLists = 0
	showStats = 1
	showAbilityBonuses = 0

	otherlist = { }

	attributeItems = {
		{ characters[currentID].attr.str, 9582 },
		{ characters[currentID].attr.dex, 9584 },
		{ characters[currentID].attr.con, 9583 },
		{ characters[currentID].attr.int, 9585 },
		{ characters[currentID].attr.wis, 9586 },
		{ characters[currentID].attr.cha, 9587 }
		}



	if statusEffects[1] ~= nil then
		table.insert(listItems, { nil, '^D' .. t('STATUS_EFFECTS_LABEL') .. ':' .. '^B'})
	end
	for k, v in pairs(characters[currentID].statusEffects) do
		table.insert(listItems, {v.current, '    ' .. Infinity_FetchString(v.strRef), bam = v.bam})
	end
	if statusEffects[1] ~= nil then
		table.insert(listItems, { nil, '' })
	end
	table.insert(listItems, { nil, '^D' .. t('SKILLS_LABEL') .. ':' .. '^B'})
	table.insert(listItems, { nil, t('LORE_LABEL') .. ': ' .. characters[currentID].proficiencies.lore.current })
	table.insert(listItems, { nil, t('REPUTATION_LABEL') .. ': ' .. characters[currentID].proficiencies.reputation.current })


	for k, v in ipairs(characters[currentID].proficiencies.class_skills) do
		table.insert(listItems, { nil, Infinity_FetchString(v.strRef) .. ': '.. v.current .. '^-'})
	end

	table.insert(listItems, { nil, '' })
	table.insert(listItems, { nil, '^D' .. t('PROFICIENCIES_LABEL') .. ':' .. '^B'})
	if characters[currentID].proficiencies.weapons.current ~= "" then
		table.insert(listItems, { nil, characters[currentID].proficiencies.weapons.current })
	end

	if characters[currentID].proficiencies.fightingstyles.current ~= "" then
		table.insert(listItems, { nil, characters[currentID].proficiencies.fightingstyles.current})
	end

	table.insert(listItems, { nil, '' })
	table.insert(listItems, { nil, '^D' .. t('SAVING_THROWS_LABEL') .. ':' .. '^B'})
	table.insert(listItems, { nil, characters[currentID].proficiencies.savingThrows})
	table.insert(listItems, { nil, '' })
	table.insert(listItems, { nil, '^D' .. t('RESISTANCES_LABEL') .. ':' .. '^B' .. '^B'})
	table.insert(listItems, { nil, characters[currentID].proficiencies.resistances})
	--table.insert(listItems, { nil, '' })
	table.insert(listItems, { nil, '^D' .. '\n' .. t('RG_ABILITY_BONUSES') .. ':^B'})
	for k, v in ipairs(characters[currentID].proficiencies.ability) do
		table.insert(listItems, {nil, v.current})
	end

	characterViewable = characterScreen:IsCharacterViewable()

	-- From patch 2.5, but unused by DUI:
	-- showClassInfo = showClassInfo == 1 and characterViewable == true
	-- showJustText = showJustText == 1 and characterViewable == true
	-- showMemorized = showMemorized == 1 and characterViewable == true
	-- showBothLists = showBothLists == 1 and characterViewable == true
	-- showStats = showStats == 1 and characterViewable == true
	-- showAbilityBonuses = showAbilityBonuses == 1 and characterViewable == true

	record = Record:create(characterViewable and currentID)
end

characters = {}
statusEffects = { }

currentID = 16974083
canLevelUp = 0
openAdvance = 0
notrealValue = 0

function trunc(str, len)
	if str:len() < len then
		return str
	else
		return str:sub(1,len) .. "..."
	end
end

function characterDescString(char)
	return Infinity_FetchString(char.gender) .. "\n" .. Infinity_FetchString(char.race) .. "\n" .. char.class .. "\n" .. Infinity_FetchString(char.alignment) .. ""
end

function isStatModified(index)
	if (index == 1 ) then
		--strength
		return (characters[currentID].attr.str.current ~= characters[currentID].attr.str.base or characters[currentID].attr.str.extra ~= characters[currentID].attr.str.extraBase)
	else
		return attributeItems[index][1].current ~= attributeItems[index][1].base
	end
end

function displayAttr(index)
	str = 0
	if (index == 1 ) then
		str = displaySTR()
	else
		str = displayBuff( attributeItems[index][1].current, attributeItems[index][1].base, 1)
	end
	return str
end

function getPercent(first, second)
	tempNumber = ( first/second ) *100
	return tempNumber
end

function displayBuff( current, base, highisbetter)

	tmpstr = ''
	--Infinity_Log( current .. ' - '.. base )
	if(highisbetter) then
		if(current > base) then
			tmpstr	= '^G' .. current .. '^-'
		elseif (current < base) then
			tmpstr	= '^R' .. current .. '^-'
		end
	else
		if(current > base) then
			tmpstr	= '^R' .. current .. '^-'
		elseif (current < base) then
			tmpstr	= '^G' .. current .. '^-'
		end
	end
	if(current == base) then
		tmpstr = current
	end
	return tmpstr
end

function getNextLevelString()
	local nextLevelXp = characters[currentID].level.nextLvlXp - characters[currentID].level.xp
	local str = ""
	if(nextLevelXp > 0) then
		str = t("NEXT_LEVEL_LABEL")
		str = str .. " "
		str = str .. nextLevelXp
		str = str .. " "
		str = str .. t("XP_LABEL")
	else
		str = t("READY_TO_LEVEL_LABEL")
	end
	return str

end

function CurrentlyInGame()
	if characterScreen:IsInGame() == true then
		return true
	else
		return false
	end
end
function getClassString()
	local out = characters[currentID].classlevel.first.details
	if ( characters[currentID].classlevel.second ) then
		out = out .. '\n\n' .. characters[currentID].classlevel.second.details
	end
	if ( characters[currentID].classlevel.third ) then
		out = out .. '\n\n' .. characters[currentID].classlevel.third.details
	end

	out = out .. '\n\n' .. characters[currentID].kitDesc

	return out
end

function rgtoggleCombatStats()
		if(toggleCombatStats == 1) then return 0 else return 1 end
end

function getGeneralInfo()
	local out = characters[currentID].classlevel.first.details
	if ( characters[currentID].classlevel.second ) then
		out = out .. '\n\n' .. characters[currentID].classlevel.second.details
	end
	if ( characters[currentID].classlevel.third ) then
		out = out .. '\n\n' .. characters[currentID].classlevel.third.details
	end

	out = out .. '\n\n' .. t('LORE_LABEL') .. ': ' .. characters[currentID].proficiencies.lore.current
		.. '\n' .. t('REPUTATION_LABEL') .. ': ' .. characters[currentID].proficiencies.reputation.current
		.. '\n' .. t('CURRENT_SCRIPT_LABEL') .. ': ' .. characters[currentID].proficiencies.currentScript.. '\n\n'

	return out
end

function getClassString1()
	local firstClass = ',' .. characters[currentID].classlevel.first.details
	local out = ''
	if ( characters[currentID].classlevel.second ) then
		local firstClass1 = string.match(firstClass, ',.-:')
		out = string.match(firstClass1, '[^,:]+') .. ' -'
	end

	return out
end
function getClassString2()
	local secondClass = ',' .. characters[currentID].classlevel.second.details
	local secondClass1 = string.match(secondClass, ',.-:')
	local out = string.match(secondClass1, '[^,:]+')
	return out
end
function getClassString3()
	local thirdClass = ',' .. characters[currentID].classlevel.third.details
	local thirdClass1 = string.match(thirdClass, ',.-:')
	local out = string.match(thirdClass1, '[^,:]+')
	return out
end
function getLevelString1()
	local firstLevel = string.match(characters[currentID].classlevel.first.details, '%d.')
	local out = string.match(firstLevel, '[^\n]+')
	return out
end
function getLevelString2()
	local secondLevel = string.match(characters[currentID].classlevel.second.details, '%d.')
	local out = string.match(secondLevel, '[^\n]+')
	return out
end
function getLevelString3()
	local thirdLevel = string.match(characters[currentID].classlevel.third.details, '%d.')
	local out = string.match(thirdLevel, '[^\n]+')
	return out
end
function getStrengthDetail()
	local outList = { }
	for k, v in ipairs(characters[currentID].proficiencies.ability) do
		table.insert(outList, {v.current})
	end
	local out = outList[1][1] .. ', ' .. outList[2][1]
	return out
end
function getDexDetail()
	local outList = { }
	for k, v in ipairs(characters[currentID].proficiencies.ability) do
		table.insert(outList, {v.current})
	end
	local out = outList[5][1]
	return out
end
function getConDetail()
	local outList = { }
	for k, v in ipairs(characters[currentID].proficiencies.ability) do
		table.insert(outList, {v.current})
	end
	local out = outList[8][1]
	return out
end
function getChaDetail()
	local outList = { }
	local out = ''
	for k, v in ipairs(characters[currentID].proficiencies.ability) do
		table.insert(outList, {v.current})
	end
	if characters[currentID].hasMageBook and (tablelength(outList) < 11) then
		out = outList[10][1]
	elseif characters[currentID].hasMageBook and (tablelength(outList) >= 11) then
		out = outList[12][1]
	else
		out = outList[9][1]
	end
	return out
end
function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end
function getTHAC()
	local thactxt = characters[currentID].THAC0.current
	if (characters[currentID].THAC0.offhand ) then
		thactxt = thactxt .. '^X' .. '  |  ' .. characters[currentID].THAC0.offhand .. '^B'
	end
	return thactxt
end
function getDmg()
	local str = characters[currentID].damage.min .. ' - ' .. characters[currentID].damage.max
	if(characters[currentID].damage.minOffhand and characters[currentID].damage.maxOffhand) then
		str = str .. '^X' .. '  |  ' .. characters[currentID].damage.minOffhand .. ' - ' .. characters[currentID].damage.maxOffhand .. '^B'
	end
	return str
end

overviewList = { }


function getStatistics1()
	local out = Infinity_FetchString(characters[currentID].Stats.bestenemy.strRef) .. '\n\n' .. Infinity_FetchString(characters[currentID].Stats.timespent.strRef) .. '\n\n' .. Infinity_FetchString(characters[currentID].Stats.favspell.strRef) .. '\n\n' .. Infinity_FetchString(characters[currentID].Stats.favweapon.strRef)
	return out
end
function getStatistics2()
	local out = characters[currentID].Stats.bestenemy.current .. '\n\n' .. characters[currentID].Stats.timespent.current .. '\n\n' .. characters[currentID].Stats.favspell.current .. '\n\n' .. characters[currentID].Stats.favweapon.current
	return out
end
function getStatistics3()
	local out = '\n\n' .. Infinity_FetchString(characters[currentID].Stats.partychapxp.strRef) .. '\n\n' .. Infinity_FetchString(characters[currentID].Stats.partychapkills.strRef) .. '\n\n' .. Infinity_FetchString(characters[currentID].Stats.chapxpvalue.strRef) .. '\n\n' .. Infinity_FetchString(characters[currentID].Stats.chapkills.strRef)
	return out
end
function getStatistics4()
	local out = t('CHAPTER_LABEL') .. '\n\n' .. characters[currentID].Stats.partychapxp.current .. '%' .. '\n\n' .. characters[currentID].Stats.partychapkills.current .. '%' .. '\n\n' .. characters[currentID].Stats.chapxpvalue.current .. '\n\n' .. characters[currentID].Stats.chapkills.current
	return out
end
function getStatistics5()
	local out = t('GAME_LABEL') .. '\n\n' .. characters[currentID].Stats.partygamexp.current .. '%' .. '\n\n' .. characters[currentID].Stats.partygamekills.current .. '%' .. '\n\n' .. characters[currentID].Stats.gamexpvalue.current .. '\n\n' .. characters[currentID].Stats.gamekills.current
	return out
end
--function getClassString()
--	local str = Infinity_FetchString(11959)
--    return (str:gsub("^%l", string.upper))
--end
function getClassTitle()
	local MultiClass = ',' .. characters[currentID].proficiencies.details
	local out = ''
	if ( characters[currentID].classlevel.second ) then
		local MultiClass1 = string.match(MultiClass, ',.-\n\n')
		out = string.match(MultiClass1, '[^,\n\n]+')
	else
		local MultiClass2 = Infinity_FetchString(11959)
		out = (MultiClass2:gsub("^%l", string.upper))
	end

	return out
end

	listItems = { }
	listTest = { }
	overviewList = { }

	helpTextString = ''
	currentTabIndex = 0
	currentTab = 0
	currentItem = 0
	ShowClassInfo = 0
	showStats = 0
	showJustText = 0
	showMemorized = 0
	showBothLists = 0
	characterViewable = true

Record = {}

function Record:create(id)
	local character = characters[id]
	if not character then
		return { valid = false, classes = { {} } }
	end

	local classes = {}
	local record = {
		id = id,
		name = character.name,
		class = character.class,
		classes = classes,
		valid = true,
	}

	for _, key in ipairs({ "first", "second", "third" }) do
		local level = character.classlevel[key]
		if not level then
			break
		end

		-- Lines are (might be localized):
		-- [1] [className]: Level [N]
		-- [2] One of these:
		--   a) Experience: [XP]
		--   b) LEVEL DRAINED
		-- [3] One of these:
		--   a) Next Level: [XP] # first-class or multi-class
		--   b) Inactive         # inactive dual-class
		--   c) nil              # active dual-class
		local lines = {}
		for s in level.details:gmatch('[^\r\n]+') do
			table.insert(lines, s)
		end

		local xp = lines[2]:match('[0-9]+')
		local class = {
			name = lines[1]:match('^[^:]+'),
			level = lines[1]:match('[0-9]+$'),
		}

		if xp then
			if level.active == false then
				class.xp = xp .. ' XP'
				class.inactive = lines[3]
			else
				class.xp = level.xp .. ' / ' .. level.nextLvlXp .. ' XP'
				class.progress = 100 * level.xp / level.nextLvlXp
			end
		else -- level drained or something else non-numeric
			class.xp = lines[2]
		end

		table.insert(classes, class)
	end

	if #classes > 1 then
		classes[1].label = classes[1].name .. ' -'

		-- nil - first-class, true - multi-class, false - dual-class
		local level = character.classlevel.second
		if level.active == true then
			record.multiclass = true
		elseif level.active == false then
			record.dualclass = true
		end
	else
		classes[1].label = ''
	end

	return record
end
