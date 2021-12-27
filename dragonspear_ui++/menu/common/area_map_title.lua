mapnoteSettings = {}
showNotes = 1
function showNote(instanceId)
	if(mapScreen:IsNoteVisible(mapnoteSettings[instanceId].worldCoord.x, mapnoteSettings[instanceId].worldCoord.y)
	and mapnoteSettings[instanceId].screenCoord.x >= 0
	and mapnoteSettings[instanceId].screenCoord.y >= 0) then
		return showNotes
	else
		return false
	end
end
notesAlpha = 0
function getAndIncrementNotesAlpha()
	if(notesAlpha < .99) then
		notesAlpha = notesAlpha + 0.075
	end
	if(notesAlpha > 1) then
		notesAlpha = 1
	end
	return notesAlpha
end