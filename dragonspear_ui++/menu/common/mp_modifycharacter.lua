	function multiplayerIsDelete ()
		if (multiplayer.character[mpModifyingCharacter+1].portrait ~= '') then
			return t("DELETE_BUTTON")
		else
			return t("CREATE_BUTTON")
		end
	end
	function getModifyConfirmationLabel()
		print(mpModifyingCharacter+1)
		return t('MULTIPLAYER_EDIT_CONFIRM').. ' ' .. getMultiplayerCharacterName(mpModifyingCharacter+1)
	end