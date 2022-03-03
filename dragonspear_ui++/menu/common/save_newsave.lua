	newSaveName = ''
	function completeSave()
		Infinity_Log('not overwrite')
		Infinity_PopMenu('SAVE_NEWSAVE')
		saveScreen:SaveGame(#gameSaves.files, newSaveName)
	end
	function completeOverwrite()
		Infinity_Log('overwrite')
		Infinity_PopMenu('SAVE_NEWSAVE')
		saveScreen:SaveGame(gameSaves.files[currentSave].slotIndex,newSaveName)
	end
