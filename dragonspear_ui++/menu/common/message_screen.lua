function SmallEditAction()
	journalNoteEditRef = getJournalEntryRef_Small(selectedJournal)
	journalNoteOld = Infinity_FetchString(journalNoteEditRef)
	if string.find(string.lower(journalNoteOld),string.lower(JFStrings.JF_Notes)) then
		journalNoteEdit = string.sub(journalNoteOld,string.len(JFStrings.JF_Notes)+2) .. '\n\n'
	elseif string.find(string.lower(journalNoteOld),string.lower(JFStrings.JF_Edited)) then
		journalNoteEdit = string.sub(journalNoteOld,string.len(JFStrings.JF_Edited)+2) .. '\n\n'
	else
		journalNoteEdit = journalNoteOld .. '\n\n'
	end
	journalMode = const.JOURNAL_MODE_EDIT
end
function LargeEditAction()
	journalNoteEditRef = getJournalEntryRef(selectedJournal)
	journalNoteOld = Infinity_FetchString(journalNoteEditRef)
	if string.find(string.lower(journalNoteOld),string.lower(JFStrings.JF_Notes)) then
		journalNoteEdit = string.sub(journalNoteOld,string.len(JFStrings.JF_Notes)+2) .. '\n\n'
	elseif string.find(string.lower(journalNoteOld),string.lower(JFStrings.JF_Edited)) then
		journalNoteEdit = string.sub(journalNoteOld,string.len(JFStrings.JF_Edited)+2) .. '\n\n'
	else
		journalNoteEdit = journalNoteOld .. '\n\n'
	end
	journalMode = const.JOURNAL_MODE_EDIT
end

function processQuestsWithStyle()
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