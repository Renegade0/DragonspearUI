function reinitQuests()
	for questIdx, quest in pairs(quests) do
		local noquest = true
		for objIdx,objective in pairs(quest.objectives) do
			local noobjective = true
			for entryIdx,entry in pairs(objective.entries) do
				if quests[questIdx].objectives[objIdx].entries[entryIdx].stateType ~= const.ENTRY_TYPE_NONE and quests[questIdx].objectives[objIdx].entries[entryIdx].stateType ~= nil then
					noobjective = false
				end
			end
			if noobjective then
				quests[questIdx].objectives[objIdx].stateType = const.ENTRY_TYPE_NONE
			end
			if quests[questIdx].objectives[objIdx].stateType ~= const.ENTRY_TYPE_NONE and quests[questIdx].objectives[objIdx].stateType ~= nil then
				noquest = false
			end
		end
		if noquest then
			quests[questIdx].stateType = const.ENTRY_TYPE_NONE
		end
	end
end

function initQuests()
	--instead of always searching the quests, just map entry ids to their quests
	entryToQuest = {}
	for questIdx, quest in pairs(quests) do
		quests[questIdx].stateType = const.ENTRY_TYPE_NONE
		for objIdx,objective in pairs(quest.objectives) do
			quests[questIdx].objectives[objIdx].stateType = const.ENTRY_TYPE_NONE
			for entryIdx,entry in pairs(objective.entries) do
				quests[questIdx].objectives[objIdx].entries[entryIdx].stateType = const.ENTRY_TYPE_NONE
				entryToQuest[entry.id] = questIdx
			end
		end
	end
end

function compareByRecvTime(o1,o2)
	if(not o1.recvTime and not o2.recvTime) then return false end
	if(not o1.recvTime) then return false end
	if(not o2.recvTime) then return true end
	return o1.recvTime > o2.recvTime
end

function buildEntry(text, recvTime, stateType, chapter, timeStamp)
	local entry =
		{
			text = text,
			recvTime = recvTime,
			stateType = stateType,
			timeStamp = timeStamp,
			chapters = {}
		}
	entry.chapters[chapter] = 1
	return entry
end

--Update a journal entry by the strref/journalId
function updateJournalEntry(journalId, recvTime, stateType, chapter, timeStamp)
	if(stateType == const.ENTRY_TYPE_USER) then
		local entry = buildEntry(journalId, recvTime, stateType, chapter, timeStamp)
		table.insert(userNotes,entry)

		--update display data
		buildQuestDisplay()
		return
	end
	--find the quest that is parent to this entry.
	--NOTE this can be placed in a loop if there needs to be more than quest to an entry
	--this would just mean entryToQuest returns a table that we iterate over
	local questId = entryToQuest[journalId]
	if questId == nil or stateType == const.ENTRY_TYPE_INFO then
		--add loose entries into the looseEntries table so they still get displayed.
		for _,entry in pairs(looseEntries) do
			if entry.text == journalId then
				return
			end
		end
		local entry = buildEntry(journalId, recvTime, stateType, chapter, timeStamp)
		table.insert(looseEntries,entry)

		--update display data
		buildQuestDisplay()
		return
	end

	local quest = quests[questId]
	if quest == nil then
		print("JOURNAL ERROR - no quest entry associated with questId "..questId)
		return
	end
	local previous = nil
	--traverse quest to find objective and entry
	for objIdx,objective in pairs(quest.objectives) do
		for entryIdx,entry in pairs(objective.entries) do
			if(entry.id == journalId) then
				--now we know where our quest, objective, and entry are
				--update quest, objective and entry appropriately
				entry.recvTime = recvTime
				entry.stateType = stateType
				if(not entry.chapters) then entry.chapters = {} end
				entry.chapters[chapter] = 1
				entry.timeStamp = timeStamp
				objective.entries[entryIdx] = entry

				objective.recvTime = recvTime
				if(not objective.chapters) then objective.chapters = {} end
				objective.chapters[chapter] = 1
				if(objective.stateType ~= const.ENTRY_TYPE_COMPLETE) then
					objective.stateType = stateType
				end
				quest.objectives[objIdx] = objective

				quest.recvTime = recvTime
				if(not quest.chapters) then quest.chapters = {} end
				quest.chapters[chapter] = 1
				if(quest.stateType ~= const.ENTRY_TYPE_COMPLETE) then
					quest.stateType = stateType
				end

				--mark any previous objective as complete
				if(entry.previous ~= nil) then
					for objIdx2,objective2 in pairs(quest.objectives) do
						for k, prevObj in pairs(entry.previous) do
							if(prevObj == objective2.text) then
								quest.objectives[objIdx2].stateType = const.ENTRY_TYPE_COMPLETE
							end
						end
					end
				end

				quests[questId] = quest

				--remove all in subgroup (except myself!)
				if(stateType == const.JOURNAL_STATE_COMPLETE and entry.subGroup) then
					for k,v in pairs(subGroups[entry.subGroup]) do
						if(v.id ~= entry.id) then
							removeJournalEntry(v.id)
						end
					end
				end

			end
		end
	end
	--sort the objectives.
	table.sort(quest.objectives,compareByRecvTime)

	--update display data
	buildQuestDisplay()
end
function checkEntryComplete(journalId, stateType)
	--Check if a journal entry is part of a quest that's already complete

	--If anything other than an unfinished entry return false.
	if(stateType ~= const.ENTRY_TYPE_INPROGRESS) then return false end

	--Check if my quest is marked complete.
	local questIndex = entryToQuest[journalId]
	if (quests[questIndex].stateType == const.ENTRY_TYPE_COMPLETE) then
		return 1
	else
		return 0
	end
end
--this should maybe be done recursively, but i kinda want direct control over each level
function buildQuestDisplay()
	--this is basically just a flatten
	questDisplay = {}
	journalDisplay = {}

	local journalEntries = {} --temp holding table for sorting the entries

	for k,quest in pairs(quests) do
		--skip inactive quests
		if(quest.stateType ~= nil and quest.stateType ~= const.ENTRY_TYPE_NONE) then
			quest.quest = 1 -- tell the renderer what type of entry this is
			table.insert(questDisplay, quest)
			local curQuestIdx = #questDisplay --we'll need to modify current quest with it's children, store a reference.
			local questChildren = {}
			for k2,objective in pairs(quest.objectives) do
				if(objective.stateType ~= const.ENTRY_TYPE_NONE) then
					objective.objective = 1
					objective.parent = curQuestIdx
					if(objective.text == Infinity_FetchString(quest.text) or objective.text == nil) then
						objective.text = objective.entries[1].timeStamp
					end
					if(objective.stateType ~= const.ENTRY_TYPE_INFO) then
						--info entries should not go into quests
						table.insert(questDisplay, objective)
						table.insert(questChildren, #questDisplay)
					end

					local curObjectiveIdx = #questDisplay
					local objectiveChildren = {}
					for k3,entry in pairs(objective.entries) do
						entry.entry = 1

						entry.parent = curObjectiveIdx
						table.insert(questDisplay, entry)
						table.insert(objectiveChildren, #questDisplay)
					end
					questDisplay[curObjectiveIdx].children = objectiveChildren
				end
			end
			questDisplay[curQuestIdx].children = questChildren
		end
	end

	-- add the user entries to the journal display
	for k,entry in pairs(userNotes) do
		entry.entry = 1
		table.insert(journalEntries,entry)
	end

	--add the loose entries (entries without quests) to the journal display
	for k,entry in pairs(looseEntries) do
		entry.entry = 1
		table.insert(journalEntries,entry)
	end


	table.sort(journalEntries, compareByRecvTime)

	for k,entry in pairs(journalEntries) do
		local title  = {}
		title.title = 1
		title.text = entry.timeStamp
		title.chapters = entry.chapters
		table.insert(journalDisplay,title)
		table.insert(journalDisplay, entry)
	end
end
function questContainsSearchString(row)
	if(journalSearchString == nil or journalSearchString == "") then return 1 end --no search string, do nothing
	local text = Infinity_FetchString(questDisplay[row].text)
	if(string.find(string.lower(text),string.lower(journalSearchString))) then return 1 end -- string contains search string.
	if(questDisplay[row].children == nil) then return nil end --no children, does not contain search string.
	for k,v in pairs(questDisplay[row].children) do
		--Infinity_Log(v)
		if(containsSearchString(v)) then return 1 end -- one of children contains search string
	end
	return nil --does not contain search string
end
function containsChapter(tab, chapter)
	if(not tab) then return nil end
	return tab[chapter]
end
function entryEnabled(row)
	local rowTab =  questDisplay[row]
	if(rowTab == nil or rowTab.entry == nil or not containsChapter(rowTab.chapters,chapter)) then return nil end

	if objectiveEnabled(rowTab.parent) then return 1 else return nil end
end
function getEntryText(row)
	return questDisplay[row].timeStamp .. "\n" .. questDisplay[row].text
end

function objectiveEnabled(row)
	local rowTab =  questDisplay[row]
	if(rowTab == nil or rowTab.objective == nil or not containsChapter(rowTab.chapters,chapter)) then return nil end

	if(questEnabled(rowTab.parent) and questDisplay[rowTab.parent].expanded) then return 1 else return nil end
end
function getObjectiveText(row)
	local rowTab =  questDisplay[row]
	if (rowTab == nil) then return nil end
	local text = rowTab.text
	if(text == "" or text == nil) then
		text = t("NO_OBJECTIVE_NORMAL")
	end
	--objectives shouldn't really display a completed state since they don't actually follow a progression.
	--if(getFinished(row)) then
	--	text = "^0xFF666666" .. text .. " (Finished)^-"
	--end

	return text
end

--Many thanks to 'lefreut'
function childrenContainsChapter(children)
	for k,v in pairs(children) do
		if containsChapter(questDisplay[v].chapters,chapter) then
			return true
		end
	end
	return nil
end

function questEnabled(row)
	--return (questDisplay[row] and questDisplay[row].quest and containsChapter(questDisplay[row].chapters,chapter) and (#questDisplay[row].children > 0))
	return (questDisplay[row] and questDisplay[row].quest and containsChapter(questDisplay[row].chapters,chapter) and childrenContainsChapter(questDisplay[row].children))
end

function CloseAll(side)
	for i=1,#questDisplay,1 do
		if side == 1 then
			if questDisplay[i].expanded == 1 and questDisplay[i].stateType ~= const.ENTRY_TYPE_COMPLETE then
				questDisplay[i].expanded = nil
			end
		elseif side == 2 then
			if questDisplay[i].expanded == 1 and questDisplay[i].stateType == const.ENTRY_TYPE_COMPLETE then
				questDisplay[i].expanded = nil
			end
		end
	end
end


function hideFinished(row)
	return (questDisplay[row].stateType ~= const.ENTRY_TYPE_COMPLETE)
end
function hideUnfinished(row)
	return (questDisplay[row].stateType == const.ENTRY_TYPE_COMPLETE)
end
function getQuestText(row)
	local rowTab =  questDisplay[row]
	if (rowTab == nil) then return nil end
	local text = Infinity_FetchString(rowTab.text)

	if(getFinished(row)) then
		text = "^0xFF000000" .. text-- .. " (" .. t("OBJECTIVE_FINISHED_NORMAL") .. ")^-"
	end

	return text
end
function getArrowFrame(row)
	if(questDisplay[row] == nil or (questDisplay[row].objective == nil and questDisplay[row].quest == nil)) then return "" end


	if(questDisplay[row].expanded) then
		return 0
	else
		return 1
	end
end
function getArrowEnabled(row)
	if(questDisplay[row].quest == nil and questDisplay[row].objective == nil) then return nil end
	if(questDisplay[row].objective and not objectiveEnabled(row)) then return nil end
	if(questDisplay[row].quest and not questEnabled(row)) then return nil end
	if(questDisplay[row].objective) then return nil end
	return 1
end

function getFinished(row)
	if(questDisplay[row].stateType == const.ENTRY_TYPE_COMPLETE) then return 1 else return nil end
end
function showObjectiveSeperator(row)
	local tab = questDisplay[row]
	if(objectiveEnabled(row) or entryEnabled(row)) then
		--seperator is enabled for objective or entry as long as the next thing is an objective.
		--search until we find something enabled or end of table.
		local idx = row + 1
		while(questDisplay[idx]) do
			if(objectiveEnabled(idx)) then
				return 1
			else
				if(questEnabled(idx) or entryEnabled(idx)) then
					return nil
				end
			end
			idx = idx + 1
		end
	end
end


function getJournalTitleEnabled(row)
	return journalDisplay[row].title and containsChapter(journalDisplay[row].chapters,chapter) and journalContainsSearchString(row)
end
function getJournalTitleText(row)
	return journalDisplay[row].text
end
function getJournalEntryEnabled(row)
	return journalDisplay[row].entry and containsChapter(journalDisplay[row].chapters,chapter) and journalContainsSearchString(row)
end
function getJournalEntryText(row)
	local text = Infinity_FetchString(journalDisplay[row].text)
	if(text == nil or text == "") then
		text = journalDisplay[row].text
	end

	if(journalSearchString and journalSearchString ~= "") then
		--do the search string highlight
		text = highlightString(text, journalSearchString, "^0xFF0000FF")
	end

	return text
end
function getJournalDarken(row)
	local entry = journalDisplay[row]
	if(entry.title) then
		return (row == selectedJournal or row + 1 == selectedJournal)
	end
	if(entry.entry) then
		return (row == selectedJournal or row - 1 == selectedJournal)
	end
end
function journalContainsSearchString(row)
	if(journalSearchString == nil or journalSearchString == "") then return 1 end --no search string, do nothing
	local text = Infinity_FetchString(journalDisplay[row].text)
	if(text == "") then text = journalDisplay[row].text end --no stringref, use the text.
	if(string.find(string.lower(text),string.lower(journalSearchString))) then return 1 end -- string contains search string.

	--check if the corresponding row to this one contains the string.
	local pairText = nil
	if(journalDisplay[row].title) then
		--check the corresponding entry
		pairText = Infinity_FetchString(journalDisplay[row+1].text) or journalDisplay[row+1].text
		if(pairText == "") then pairText = journalDisplay[row+1].text end
	else
		if (journalDisplay[row].entry) then
			pairText = Infinity_FetchString(journalDisplay[row-1].text) or journalDisplay[row-1].text
			if(pairText == "") then pairText = journalDisplay[row-1].text end
		end
	end
	if(string.find(string.lower(pairText),string.lower(journalSearchString))) then return 1 end -- pair string contains search string.

	return nil --does not contain search string
end
-- function dragJournal()
	-- local offsetX,offsetY,menuWidth,menuHeight = Infinity_GetMenuArea('JOURNAL')
	-- offsetX = offsetX + motionX
	-- offsetY = offsetY + motionY

	-- clamping
	-- if(offsetX < 80) then
		-- offsetX = 80
	-- end
	-- if(offsetY < 0) then
		-- offsetY = 0
	-- end

	-- local screenWidth, screenHeight = Infinity_GetScreenSize()
	-- if(offsetX > screenWidth - 80 - menuWidth) then
		-- offsetX = screenWidth - 80 - menuWidth
	-- end
	-- if(offsetY > screenHeight - menuHeight) then
		-- offsetY = screenHeight - menuHeight
	-- end

	-- Infinity_SetOffset('JOURNAL', offsetX, offsetY)
-- end
function journalEntryClickable(selectedJournal)
	local entry = journalDisplay[selectedJournal]
	if(entry) then return true end
end
function getJournalEntryRef(selectedJournal)
	local entry = journalDisplay[selectedJournal]
	if(not entry) then return end
	if(entry.title) then
		return journalDisplay[selectedJournal + 1].text
	else
		return entry.text
	end
end
function getJournalBackgroundFrame()
	if(journalMode == const.JOURNAL_MODE_QUESTS) then
		return 0
	else
		return 1
	end
end
function PauseJournal()
	if worldScreen:CheckIfPaused() then
		return
	else
		worldScreen:TogglePauseGame(true)
	end
end
function getSidebarButtons_Large()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
	Infinity_SetArea('journalLeftBack1', -((screenWidth-1364)/2), ((screenHeight-756)/2)+640, nil, nil)
	Infinity_SetArea('journalLeftBack2', -((screenWidth-1364)/2), ((screenHeight-756)/2)+703, nil, nil)
	Infinity_SetArea('journalRightBack1', ((screenWidth-1364)/2)+1245, ((screenHeight-756)/2)+640, nil, nil)
	Infinity_SetArea('journalRightBack2', ((screenWidth-1364)/2)+964, ((screenHeight-756)/2)+703, nil, nil)
	Infinity_SetArea('journalLeftButton1a', -((screenWidth-1364)/2), ((screenHeight-756)/2)+691, nil, nil)
	Infinity_SetArea('journalLeftButton1b', -((screenWidth-1364)/2)+1, ((screenHeight-756)/2)+692, nil, nil)
	Infinity_SetArea('journalLeftButton1c', -((screenWidth-1364)/2)+1, ((screenHeight-756)/2)+691, nil, nil)
	Infinity_SetArea('journalLeftButton2', -((screenWidth-1364)/2)+69, ((screenHeight-756)/2)+708, nil, nil)
	Infinity_SetArea('journalLeftButton3', -((screenWidth-1364)/2)+119, ((screenHeight-756)/2)+709, nil, nil)
	Infinity_SetArea('journalLeftButton4', -((screenWidth-1364)/2)+169, ((screenHeight-756)/2)+708, nil, nil)
	Infinity_SetArea('journalLeftButton5', -((screenWidth-1364)/2)+216, ((screenHeight-756)/2)+709, nil, nil)
	Infinity_SetArea('journalLeftButton6', -((screenWidth-1364)/2)+261, ((screenHeight-756)/2)+709, nil, nil)
	Infinity_SetArea('journalLeftButton7', -((screenWidth-1364)/2)+309, ((screenHeight-756)/2)+709, nil, nil)
	Infinity_SetArea('journalLeftButton8', -((screenWidth-1364)/2), ((screenHeight-756)/2)+688, nil, nil)
	Infinity_SetArea('journalLeftButton9', -((screenWidth-1364)/2), ((screenHeight-756)/2)+688, nil, nil)
	Infinity_SetArea('journalLeftButton10', -((screenWidth-1364)/2), ((screenHeight-756)/2)+650, nil, nil)
	Infinity_SetArea('journalRightButton1', ((screenWidth-1364)/2)+1295, -((screenHeight-756)/2)+14, nil, nil)
	Infinity_SetArea('journalRightButton2', ((screenWidth-1364)/2)+1295, -((screenHeight-756)/2)+112, nil, nil)
	Infinity_SetArea('journalRightButton3', ((screenWidth-1364)/2)+1295, -((screenHeight-756)/2)+210, nil, nil)
	Infinity_SetArea('journalRightButton4', ((screenWidth-1364)/2)+1295, -((screenHeight-756)/2)+308, nil, nil)
	Infinity_SetArea('journalRightButton5', ((screenWidth-1364)/2)+1295, -((screenHeight-756)/2)+406, nil, nil)
	Infinity_SetArea('journalRightButton6', ((screenWidth-1364)/2)+1295, -((screenHeight-756)/2)+504, nil, nil)
	Infinity_SetArea('journalRightButton1a', ((screenWidth-1364)/2)+1292, -((screenHeight-756)/2)+10, nil, nil)
	Infinity_SetArea('journalRightButton2a', ((screenWidth-1364)/2)+1292, -((screenHeight-756)/2)+108, nil, nil)
	Infinity_SetArea('journalRightButton3a', ((screenWidth-1364)/2)+1292, -((screenHeight-756)/2)+206, nil, nil)
	Infinity_SetArea('journalRightButton4a', ((screenWidth-1364)/2)+1292, -((screenHeight-756)/2)+304, nil, nil)
	Infinity_SetArea('journalRightButton5a', ((screenWidth-1364)/2)+1292, -((screenHeight-756)/2)+402, nil, nil)
	Infinity_SetArea('journalRightButton6a', ((screenWidth-1364)/2)+1292, -((screenHeight-756)/2)+500, nil, nil)
	Infinity_SetArea('journalRightButton7', ((screenWidth-1364)/2)+1311, ((screenHeight-756)/2)+701, nil, nil)
	Infinity_SetArea('journalRightButton8', ((screenWidth-1364)/2)+1004, ((screenHeight-756)/2)+709, nil, nil)
	Infinity_SetArea('journalRightButton9', ((screenWidth-1364)/2)+1050, ((screenHeight-756)/2)+709, nil, nil)
	Infinity_SetArea('journalRightButton10', ((screenWidth-1364)/2)+1098, ((screenHeight-756)/2)+709, nil, nil)
	Infinity_SetArea('journalRightButton11', ((screenWidth-1364)/2)+1149, ((screenHeight-756)/2)+709, nil, nil)
	Infinity_SetArea('journalRightButton12', ((screenWidth-1364)/2)+1197, ((screenHeight-756)/2)+709, nil, nil)
	Infinity_SetArea('journalRightButton13', ((screenWidth-1364)/2)+1242, ((screenHeight-756)/2)+708, nil, nil)
	Infinity_SetArea('journalRightButton14', ((screenWidth-1364)/2)+1343, ((screenHeight-756)/2)+650, nil, nil)
end
FirstUse = 0
function positionSmallJournal()
	HideLargeJournal()
	if FirstUse == 0 then
		FirstUse = 1
		-- Set the background to 0,0 (top-left)
		local screenWidth, screenHeight = Infinity_GetScreenSize()
		local area = {Infinity_GetArea('JournalSmall_Background')}
		area[1] = (1364 / 2) - (screenWidth / 2)
		area[2] = (756 / 2) - (screenHeight / 2)

		Infinity_SetArea('JournalSmall_Background', area[1], area[2], 501, 773)
		Infinity_SetArea('JournalSmall_1', area[1], area[2], 485, 747)
		Infinity_SetArea('JournalSmall_2', area[1], area[2], 472, 80)
		Infinity_SetArea('JournalSmall_3', area[1]+218, area[2]+18, 134, 42)
		Infinity_SetArea('JournalSmall_4', area[1]+34, area[2]+18, 136, 42)
		Infinity_SetArea('JournalSmall_6', area[1]+84, area[2]+140, 118, 35)
		Infinity_SetArea('JournalSmall_7', area[1]+202, area[2]+140, 118, 35)
		Infinity_SetArea('JournalSmall_8', area[1]+320, area[2]+140, 118, 35)
		Infinity_SetArea('JournalSmall_9', area[1]+419, area[2]+13, 66, 67)
		Infinity_SetArea('JournalSmall_10', area[1]+170, area[2]+80, 146, 60)
		Infinity_SetArea('JournalSmall_11', area[1]+134, area[2]+80, 41, 60)
		Infinity_SetArea('JournalSmall_12', area[1]+306, area[2]+80, 41, 60)
		Infinity_SetArea('JournalSmall_13', area[1]+44, area[2]+175, 382, 29)
		Infinity_SetArea('JournalSmall_14', area[1]+62, area[2]+180, 357, 20)
		Infinity_SetArea('JournalSmall_15', area[1]+44, area[2]+174, 396, 490)
		Infinity_SetArea('JournalSmall_16', area[1]+44, area[2]+208, 396, 490)
		Infinity_SetArea('JournalSmall_17', area[1]+44, area[2]+140, 132, 35)
		Infinity_SetArea('JournalSmall_18', area[1]+176, area[2]+140, 132, 35)
		Infinity_SetArea('JournalSmall_19', area[1]+308, area[2]+140, 132, 35)
		Infinity_SetArea('JournalSmall_20', area[1]+44, area[2]+154, 382, 26)
		Infinity_SetArea('JournalSmall_21', area[1]+44, area[2]+200, 382, 4)
		Infinity_SetArea('JournalSmall_22', area[1]+44, area[2]+204, 382, 26)
		Infinity_SetArea('JournalSmall_23', area[1]+44, area[2]+230, 382, 411)
		Infinity_SetArea('JournalSmall_24', area[1]+44, area[2]+641, 162, 47)
		Infinity_SetArea('JournalSmall_25', area[1]+260, area[2]+641, 162, 47)
		Infinity_SetArea('JournalSmall_26', area[1]+400, area[2]+204, 30, 26)
	end
end
function HideLargeJournal()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
	for i = 1, 26, 1 do
		Infinity_SetArea(('journalLarge_' .. i), -(screenWidth * 2), -(screenHeight * 2), -1, -1)
	end
end
function unHideLargeJournal()
	Infinity_SetArea(('journalLarge_1'), 0,0,1364,756)
	Infinity_SetArea(('journalLarge_2'), 205,31,954,44)
	Infinity_SetArea(('journalLarge_3'), 879,82,52,44)
	Infinity_SetArea(('journalLarge_4'), 437,82,52,44)
	Infinity_SetArea(('journalLarge_5'), 122,90,230,44)
	Infinity_SetArea(('journalLarge_6'), 1012,90,234,44)
	Infinity_SetArea(('journalLarge_7'), 122,90,230,44)
	Infinity_SetArea(('journalLarge_8'), 582,83,200,40)
	Infinity_SetArea(('journalLarge_9'), 538,73,39,65)
	Infinity_SetArea(('journalLarge_10'), 788,73,42,65)
	Infinity_SetArea(('journalLarge_11'), 122,140,200,32)
	Infinity_SetArea(('journalLarge_12'), 124,144,192,29)
	Infinity_SetArea(('journalLarge_13'), 122,141,534,534)
	Infinity_SetArea(('journalLarge_14'), 712,141,534,540)
	Infinity_SetArea(('journalLarge_15'), 122,173,538,502)
	Infinity_SetArea(('journalLarge_16'), 712,173,534,502)
	Infinity_SetArea(('journalLarge_17'), 327,128,162,47)
	Infinity_SetArea(('journalLarge_18'), 489,128,162,47)
	Infinity_SetArea(('journalLarge_19'), 122,148,534,36)
	Infinity_SetArea(('journalLarge_20'), 122,185,534,4)
	Infinity_SetArea(('journalLarge_21'), 122,189,534,42)
	Infinity_SetArea(('journalLarge_22'), 122,231,534,379)
	Infinity_SetArea(('journalLarge_23'), 426,610,162,47)
	Infinity_SetArea(('journalLarge_24'), 190,610,162,47)
	Infinity_SetArea(('journalLarge_25'), 626,196,30,26)
	Infinity_SetArea(('journalLarge_26'), 1012,90,234,44)
end
journalMode = const.JOURNAL_MODE_QUESTS
journalSearchString = ""

function myNotes(row)
	local text = Infinity_FetchString(journalDisplay[row].text)
	if(text == "") then text = journalDisplay[row].text end

	--check if the corresponding row to this one contains the string.
	local pairText = nil
	if(journalDisplay[row].title) then
		--check the corresponding entry
		pairText = Infinity_FetchString(journalDisplay[row+1].text) or journalDisplay[row+1].text
		if(pairText == "") then pairText = journalDisplay[row+1].text end
	else
		if (journalDisplay[row].entry) then
			pairText = Infinity_FetchString(journalDisplay[row-1].text) or journalDisplay[row-1].text
			if(pairText == "") then pairText = journalDisplay[row-1].text end
		end
	end
	if(string.find(string.lower(pairText),string.lower(JFStrings.JF_Notes))) then return 1 end -- pair string contains My Notes

	if(string.find(string.lower(text),string.lower(JFStrings.JF_Notes))) then return 1 end -- string contains My Notes
	return nil --does not contain My Notes
end
function NotMyNotes(row)
	local text = Infinity_FetchString(journalDisplay[row].text)
	if(text == "") then text = journalDisplay[row].text end

	--check if the corresponding row to this one contains the string.
	local pairText = nil
	if(journalDisplay[row].title) then
		--check the corresponding entry
		pairText = Infinity_FetchString(journalDisplay[row+1].text) or journalDisplay[row+1].text
		if(pairText == "") then pairText = journalDisplay[row+1].text end
	else
		if (journalDisplay[row].entry) then
			pairText = Infinity_FetchString(journalDisplay[row-1].text) or journalDisplay[row-1].text
			if(pairText == "") then pairText = journalDisplay[row-1].text end
		end
	end
	if(string.find(string.lower(pairText),string.lower(JFStrings.JF_Notes))) then return nil end -- pair string contains My Notes

	if(string.find(string.lower(text),string.lower(JFStrings.JF_Notes))) then return nil end -- string contains My Notes
	return 1 --does contain My Notes
end
