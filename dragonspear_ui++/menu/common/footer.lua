function initQuests_Small()
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

function compareByRecvTime_Small(o1,o2)
	if(not o1.recvTime and not o2.recvTime) then return false end
	if(not o1.recvTime) then return false end
	if(not o2.recvTime) then return true end
	return o1.recvTime > o2.recvTime
end

function buildEntry_Small(text, recvTime, stateType, chapter, timeStamp)
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
function updateJournalEntry_Small(journalId, recvTime, stateType, chapter, timeStamp)
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
	if questId == nil then
		--add loose entries into the looseEntries table so they still get displayed.
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
function checkEntryComplete_Small(journalId, stateType)
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
function buildQuestDisplay_Small()
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


	table.sort(journalEntries, compareByState_Small)

	for k,entry in pairs(journalEntries) do
		local title  = {}
		title.title = 1
		title.text = entry.timeStamp
		title.chapters = entry.chapters
		table.insert(journalDisplay,title)
		table.insert(journalDisplay, entry)
	end
end
function questContainsSearchString_Small(row)
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
function containsChapter_Small(tab, chapter)
	if(not tab) then return nil end
	return tab[chapter]
end
function entryEnabled_Small(row)
	local rowTab =  questDisplay[row]
	if(rowTab == nil or rowTab.entry == nil or not containsChapter(rowTab.chapters,chapter)) then return nil end

	if(objectiveEnabled(rowTab.parent) and questDisplay[rowTab.parent].expanded) then return 1 else return nil end
end
function getEntryText_Small(row)
	return questDisplay[row].timeStamp .. "\n" .. questDisplay[row].text
end

function objectiveEnabled_Small(row)
	local rowTab =  questDisplay[row]
	if(rowTab == nil or rowTab.objective == nil or not containsChapter(rowTab.chapters,chapter)) then return nil end

	if(questEnabled(rowTab.parent) and questDisplay[rowTab.parent].expanded) then return 1 else return nil end
end
function getObjectiveText_Small(row)
	local rowTab =  questDisplay[row]
	if (rowTab == nil) then return nil end
	local text = rowTab.text
	if(text == "" or text == nil) then
		text = t("NO_OBJECTIVE_NORMAL")
	end
	--objectives shouldn't really display a completed state since they don't actually follow a progression.
	--if(getFinished(row)) then
	--	text = "^M .. text .. " (Finished)^-"
	--end

	return text
end

QFilter = Infinity_GetINIValue('Journal', 'Quest Filter', 0)

function setQuestFilter(value)
	QFilter = value
	saveQFilter = true
end

function highlightFilter_Small(text)
	if QFilter == 0 and text == 'All' then
		return '^M' .. text .. '^-'
	elseif QFilter == 1 and text == 'Active' then
		return '^M' .. text .. '^-'
	elseif QFilter == 2 and text == 'Completed' then
		return '^M' .. text .. '^-'
	end
	return '^5' .. text .. '^-'
end

function CloseAll_Small()
	for i=1,#questDisplay,1 do
		if questDisplay[i].expanded == 1 then questDisplay[i].expanded = nil end
	end
end

function CheckForOpenedQuests_Small()
	QuestOpen = 0
	for i=1,#questDisplay,1 do
		if questDisplay[i].expanded == 1  then
			QuestOpen = 1
		end
	end
end

function findQuestPopUp()
	FindTitle = string.sub(FindTitle,1,15)
	for i=1,#questDisplay,1 do
		local rowTab =  questDisplay[i]
		local text = Infinity_FetchString(rowTab.text)
		if string.find(string.lower(text), string.lower(FindTitle)) then
			questDisplay[i].expanded = 1
			questDisplay[i+1].expanded = 1
			QFilter = 3
		end
	end
end

function questEnabled_Small(row)
	if (QFilter==0) then
		return (questDisplay[row] and questDisplay[row].quest and containsChapter(questDisplay[row].chapters,chapter) and (#questDisplay[row].children > 0))
	elseif (QFilter==1) then
		if getFinished(row) then
		-- Do Nothing
		else
			return (questDisplay[row] and questDisplay[row].quest and containsChapter(questDisplay[row].chapters,chapter) and (#questDisplay[row].children > 0))
		end
	elseif (QFilter==2) then
		if getFinished(row) then
			return (questDisplay[row] and questDisplay[row].quest and containsChapter(questDisplay[row].chapters,chapter) and (#questDisplay[row].children > 0))
		end
	elseif (QFilter==3) then
		if questDisplay[row].expanded == 1  then
			return (questDisplay[row] and questDisplay[row].quest and containsChapter(questDisplay[row].chapters,chapter) and (#questDisplay[row].children > 0))
		else
			-- Do Nothing
		end
	end
end

function getQuestText_Small(row)
	local rowTab =  questDisplay[row]
	if (rowTab == nil) then return nil end
	local text = Infinity_FetchString(rowTab.text)

	if(getFinished(row)) then
		text = "^5" .. text .. " (" .. t("OBJECTIVE_FINISHED_NORMAL") .. ")^-"
	end

	return text
end
function getArrowFrame_Small(row)
	if(questDisplay[row] == nil or (questDisplay[row].objective == nil and questDisplay[row].quest == nil)) then return "" end

	if(questDisplay[row].expanded) then
		return 0
	else
		return 1
	end
end
function getArrowEnabled_Small(row)
	if(questDisplay[row].quest == nil and questDisplay[row].objective == nil) then return nil end
	if(questDisplay[row].objective and not objectiveEnabled_Small(row)) then return nil end
	if(questDisplay[row].quest and not questEnabled_Small(row)) then return nil end
	return 1
end

function getFinished_Small(row)
	if(questDisplay[row].stateType == const.ENTRY_TYPE_COMPLETE) then return 1 else return nil end
end
function showObjectiveSeperator_Small(row)
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


function getJournalTitleEnabled_Small(row)
	return journalDisplay[row].title and containsChapter(journalDisplay[row].chapters,chapter) and journalContainsSearchString(row)
end
function getJournalTitleText_Small(row)
	return journalDisplay[row].text
end
function getJournalEntryEnabled_Small(row)
	return journalDisplay[row].entry and containsChapter(journalDisplay[row].chapters,chapter) and journalContainsSearchString(row)
end
function getJournalEntryText_Small(row)
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
function getJournalDarken_Small(row)
	local entry = journalDisplay[row]
	if(entry.title) then
		return (row == selectedJournal or row + 1 == selectedJournal)
	end
	if(entry.entry) then
		return (row == selectedJournal or row - 1 == selectedJournal)
	end
end
function journalContainsSearchString_Small(row)
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

function dragJournal(newX,newY)
	local area = {Infinity_GetArea("JournalSmall_Background")}
	local screenWidth, screenHeight = Infinity_GetScreenSize()

	--clamping
	if area[1] + newX < 1364/2 - screenWidth/2 then
		newX = ((1364 / 2) - (screenWidth / 2)) - area[1]
	end
	if area[2] + newY < 756/2 - screenHeight/2 then
		newY = 756/2 - screenHeight/2 - area[2]
	end

	if area[1] + area[3] + newX > 1364/2 + screenWidth/2 - 80 then
		newX = 1364/2 + screenWidth/2 - 80 - area[1] - area[3]
	end
	if area[2] + area[4] + newY > screenHeight/2 + 756/2 - 120 then
		newY = screenHeight/2 + 756/2 - area[2] - area[4] - 120
	end

	adjustItemGroup({"JournalSmall_Background","JournalSmall_1","JournalSmall_2","JournalSmall_3","JournalSmall_4","JournalSmall_6","JournalSmall_7","JournalSmall_8","JournalSmall_9","JournalSmall_10","JournalSmall_11","JournalSmall_12","JournalSmall_13","JournalSmall_14","JournalSmall_15","JournalSmall_16","JournalSmall_17","JournalSmall_18","JournalSmall_19","JournalSmall_20","JournalSmall_21","JournalSmall_22","JournalSmall_23","JournalSmall_24","JournalSmall_25","JournalSmall_26"}, newX, newY, 0, 0)
end
function journalEntryClickable_Small(selectedJournal)
	local entry = journalDisplay[selectedJournal]
	if(entry) then return true end
end
function getJournalEntryRef_Small(selectedJournal)
	local entry = journalDisplay[selectedJournal]
	if(not entry) then return end
	if(entry.title) then
		return journalDisplay[selectedJournal + 1].text
	else
		return entry.text
	end
end
function getJournalBackgroundFrame_Small()
	if(journalMode == const.JOURNAL_MODE_QUESTS) then
		return 0
	else
		return 1
	end
end
journalMode = const.JOURNAL_MODE_QUESTS
journalSearchString = ""
function processQuestsWithStyle_Small()
	out = ""
	for k,v in pairs(quests_old) do
		local questStrref = v[3]
		out = out .. "createQuest    ( " .. questStrref .. " )\n"

		for k2,v2 in pairs(journals_quests_old) do
			if(v2[2] == k) then
				local subgroup = v2[const.ENTRIES_IDX_SUBGROUP]
				if(subgroup == 0) then subgroup = "nil" end
				out = out .. "createEntry    ( " .. questStrref .. ", -1, " .. v2[1] .. ", {}, " .. subgroup .." )\n"
			end
		end
	end
	Infinity_Log(out)
end
function getJournalEditedColours(text)
	if string.sub(text, 1, string.len(JFStrings.JF_Notes)-1) == string.sub(JFStrings.JF_Notes, 1, string.len(JFStrings.JF_Notes) - 1) then
		text = string.sub(text, string.len(JFStrings.JF_Notes)+1)
		if getJournalDarken(rowNumber) then
			text = "^$" .. JFStrings.JF_Notes .. "^-" .. text
		else
			text = "^M" .. JFStrings.JF_Notes .. "^-" .. text
		end
	elseif string.sub(text, 1, string.len(JFStrings.JF_Edited)-1) == string.sub(JFStrings.JF_Edited, 1, string.len(JFStrings.JF_Edited) - 1) then
		text = string.sub(text, string.len(JFStrings.JF_Edited)+1)
		if getJournalDarken(rowNumber) then
			text = "^$" .. JFStrings.JF_Edited .. "^-" .. text
		else
			text = "^M" .. JFStrings.JF_Edited .. "^-" .. text
		end
	end
	return text
end