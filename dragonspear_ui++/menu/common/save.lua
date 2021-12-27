function compareSaves(s1,s2)
		--return true if s1 comes before s2
		--show the most recent saves first
		return s1.fileTime > s2.fileTime
	end
	function sortSaves()
		table.sort(gameSaves.files,compareSaves)
end

SaveSearchString = ""
function SaveContainsSearchString(rowNumber)

	if(SaveSearchString == nil or SaveSearchString == "") then return 1 end --no search string, do nothing

	local text = gameSaves.files[rowNumber].sName
	if(string.find(string.lower(text),string.lower(SaveSearchString))) then
		return 1
	else
		return nil --does not contain search string
	end
end
SaveSearchString1 = ""
function SaveContainsSearchString1(rowNumber)

	if(SaveSearchString1 == nil or SaveSearchString1 == "") then return 1 end --no search string, do nothing

	local text = gameSaves.files[rowNumber].fileName
	if(string.find(string.lower(text),string.lower(SaveSearchString1))) then
		return 1
	else
		return nil --does not contain search string
	end
end
SaveSearchString2 = ""
function SaveContainsSearchString2(rowNumber)

	if(SaveSearchString2 == nil or SaveSearchString2 == "") then return 1 end --no search string, do nothing

	local text = gameSaves.files[rowNumber].chapter
	if(string.find(string.lower(text),string.lower(SaveSearchString2))) then
		return 1
	else
		return nil --does not contain search string
	end
end