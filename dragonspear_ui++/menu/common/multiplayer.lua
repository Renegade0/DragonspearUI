multiplayer = {}
mpChatEdit = ""
mpHelpTextString = ""
mpModifyingCharacter = -1
mpErrorText = -1
mpErrorState = -1
text_GUIMP_0_25 = ""
text_GUIMP_0_25_lines = 0
multiplayerInPermission = false
multiplayerInPermissionForPlayer = 0

multiplayerSessionName = ""
multiplayerSaveName = ""
multiplayerChapter = ""
multiplayerTimePlayed = ""
multiplayerDifficultyLabel = ""
multiplayerDifficultyImage = 0
mulitplayerPreexistingDifficulty = 0;

multiplayerLocalPlayerID = 1

multiplayerFromInGame = false

mpaCharacters =
{
	{ready = false, name = "", class = "", player = 1, portrait = "NOPORTLS", inprogress = false, color = "0xffffff"},
	{ready = false, name = "", class = "", player = 1, portrait = "NOPORTLS", inprogress = false, color = "0xffffff"},
	{ready = false, name = "", class = "", player = 1, portrait = "NOPORTLS", inprogress = false, color = "0xffffff"},
	{ready = false, name = "", class = "", player = 1, portrait = "NOPORTLS", inprogress = false, color = "0xffffff"},
	{ready = false, name = "", class = "", player = 1, portrait = "NOPORTLS", inprogress = false, color = "0xffffff"},
	{ready = false, name = "", class = "", player = 1, portrait = "NOPORTLS", inprogress = false, color = "0xffffff"}
}

mpaPlayers =
{
	{name = "", id = 0, color = "0x7a7aFF"},
	{name = "", id = 0, color = "0xFFAF7A"},
	{name = "", id = 0, color = "0x7aFFa3"},
	{name = "", id = 0, color = "0x57F9FF"},
	{name = "", id = 0, color = "0xF2F188"},
	{name = "", id = 0, color = "0xFE97FF"}
}

function updateMultiplayerPlayerSlot(slot,setting,value)
	if multiplayerLocalPlayerID == 1 and setting == "name" and mpaPlayers[slot][setting] == "" and value ~= "" then
		mpaPlayers[slot][setting] = value
		broadcastPlayerAdded(slot)
	elseif multiplayerLocalPlayerID == 1 and setting == "name" and mpaPlayers[slot][setting] ~= "" and value == "" then
		broadcastPlayerRemoved(slot)
		mpaPlayers[slot][setting] = value
	else
		mpaPlayers[slot][setting] = value
	end
end
function updateMultiplayerCharacterSlot(slot,setting,value)
	if multiplayerLocalPlayerID == 1 and setting == "color" and mpaCharacters[slot][setting] == "0xffffff" and value ~= "0xffffff" then
		mpaCharacters[slot][setting] = value
		broadcastCharacterAdded(slot)
	elseif multiplayerLocalPlayerID == 1 and setting == "ready" and mpaCharacters[slot][setting] == false and value == true then
		broadcastCharacterReady(slot)
		mpaCharacters[slot][setting] = value
	elseif multiplayerLocalPlayerID == 1 and setting == "ready" and mpaCharacters[slot][setting] == true and value == false then
		broadcastCharacterNotReady(slot)
		mpaCharacters[slot][setting] = value
	else
		mpaCharacters[slot][setting] = value
	end
end

function clearCharacterSlot(slot, announce)
	if announce == true and mpaCharacters[slot]['name'] ~= "" then
		broadcastCharacterRemoved(slot)
	end
	mpaCharacters[slot]['ready'] = false
	mpaCharacters[slot]['name'] = ""
	mpaCharacters[slot]['class'] = ""
	mpaCharacters[slot]['portrait'] = "NOPORTLS"
	mpaCharacters[slot]['inprogress'] = false
	mpaCharacters[slot]['color'] = "0xffffff"
end

function clearPlayerSlot(slot, announce)
	if announce == true and mpaPlayers[slot]["name"] ~= "" then
		broadcastPlayerRemoved(slot)
	end
	mpaPlayers[slot]["name"] = ""
	mpaPlayers[slot]["id"] = 0
end

function getMultiplayerCharacterName(slot, newLine, getClass)
	local ret = ""
	local separator = ", "

	if newLine == true then
		separator = "\n"
	end

	if mpaCharacters[slot]["name"] == "" and multiplayerLocalPlayerID == mpaCharacters[slot]["player"] then
		ret = t("MULTIPLAYER_CREATE_CHARACTER_MESSAGE")
	elseif mpaCharacters[slot]["name"] == "" and multiplayerLocalPlayerID ~= mpaCharacters[slot]["player"] and mpaCharacters[slot]["inprogress"] == false then
		ret = t("MULTIPLAYER_EMPTY_CHARACTER_MESSAGE")
	elseif mpaCharacters[slot]["inprogress"] == true and mpaCharacters[slot]["class"] == "" then
		setStringTokenLua("<PLAYER_NAME_1>",getMultiplayerPlayerName(mpaCharacters[slot]["player"], false, true))
		setStringTokenLua("<SEPERATOR>",separator)
		ret = t("MULTIPLAYER_CREATING_CHARACTER_MESSAGE")
		removeStringTokenLua("<SEPERATOR>")
		removeStringTokenLua("<PLAYER_NAME_1>")
	elseif mpaCharacters[slot]["name"] ~= "" and mpaCharacters[slot]["class"] ~= "" then
		ret = "^0xff"..mpaCharacters[slot]["color"]..mpaCharacters[slot]["name"].."^-"
		if getClass == true then
			ret = ret..separator..mpaCharacters[slot]["class"]
		end
	end

	return ret
end
function getMultiplayerCharacterButtonText(slot)
	local ret = ""

	if mpaCharacters[slot]["name"] == "" and multiplayerLocalPlayerID == mpaCharacters[slot]["player"] then
		ret = t("CREATE_CHAR_BUTTON")
	elseif mpaCharacters[slot]["name"] == "" and multiplayerLocalPlayerID ~= mpaCharacters[slot]["player"] then
		ret = ""
	elseif mpaCharacters[slot]["name"] ~= "" and mpaCharacters[slot]["class"] == "" then
		ret = ""
	elseif mpaCharacters[slot]["name"] ~= "" and mpaCharacters[slot]["class"] ~= "" and mpaCharacters[slot]["player"] ~= multiplayerLocalPlayerID then
		ret = t("MULTIPLAYER_VIEW_DETAILS_BUTTON")
	elseif mpaCharacters[slot]["name"] ~= "" and mpaCharacters[slot]["class"] ~= "" and mpaCharacters[slot]["player"] == multiplayerLocalPlayerID and multiplayer.allowreformparty == false and multiplayerDifficultyLabel ~= "" then
		ret = t("MULTIPLAYER_VIEW_DETAILS_BUTTON")
	elseif mpaCharacters[slot]["name"] ~= "" and mpaCharacters[slot]["class"] ~= "" and mpaCharacters[slot]["player"] == multiplayerLocalPlayerID then
		ret = t("MULTIPLAYER_EDIT_CHAR_BUTTON")
	end

	return ret
end
function shouldGreyscaleEditButton(slot)
	local ret = false
	local storedString = t("MULTIPLAYER_VIEW_DETAILS_BUTTON")

	if multiplayerFromInGame == true then
		ret = true
	end

	if ret == true and getMultiplayerCharacterButtonText(slot) == storedString  then
		ret = false
	end

	if ret == true and (multiplayerLocalPlayerID == 1 or multiplayer.player[multiplayerLocalPlayerID].permissions[7] == true) then
		ret = false
	end

	if ret == true and mpaCharacters[slot]["name"] == "" then
		ret = false
	end

	if ret == false and mpaCharacters[slot]['ready'] == true and getMultiplayerCharacterButtonText(slot) ~= storedString and multiplayerFromInGame == false then
		ret = true
	end

	return ret
end
function getMultiplayerCharacterReadyText(slot)
	local ret = ""

	if mpaCharacters[slot]["name"] == "" and mpaCharacters[slot]["inprogress"] == false then
		ret = ""
	elseif mpaCharacters[slot]["ready"] == false then
		ret = t("MULTIPLAYER_NOT_READY_MESSAGE")
	elseif mpaCharacters[slot]["ready"] == true then
		ret = t("MULTIPLAYER_READY_MESSAGE")
	end

	return ret
end
function getMultiplayerPlayerName(slot,newLine,hostyou)
	local ret = mpaPlayers[slot]["name"]
	if ret ~= "" then
		ret = "^0x"..mpaPlayers[slot]["color"]..mpaPlayers[slot]["name"].."^-"
	end

	local separator = " "
	if newLine == true then
		separator = "\n"
	end

	if hostyou == true then
		if slot == multiplayerLocalPlayerID then
			ret = ret..separator.."^0xFFFFFFFF"..t("MULTIPLAYER_PLAYER_YOU").."^-"
		elseif slot == 1 then
			ret = ret..separator.."^0xFFFFFFFF"..t("MULTIPLAYER_PLAYER_HOST").."^-"
		elseif ret == "" then
			ret = "^0xFF9B9B9B"..t("MULTIPLAYER_EMPTY_PLAYER").."^-"
		end
	end

	return ret
end
function getMultiplayerPlayerControlledCharacter(player,slot)
	local count = 0
	local ret = "NOCTRL" -- need blank square or something

	local index = 1
	for index = 1, 6, 1 do
		if mpaCharacters[index]["player"] == player then
			count = count + 1
		end

		if currentMultiplayerSelectPlayer == player and mpDraggedCharacter == index then
			slot = slot + 1
		end

		if count == slot then
			ret = mpaCharacters[index]["portrait"]
			break
		end
	end

	return ret
end
function getMultiplayerPlayerControlledCharacterSlot(player,slot)
	local count = 0
	local ret = -1

	local index = 1
	for index = 1, 6, 1 do
		if mpaCharacters[index]["player"] == player then
			count = count + 1
		end

		if count == slot then
			ret = index
			break
		end
	end

	return ret
end

function getPlayerKickWidth(slot)
	if multiplayerLocalPlayerID ~= 1 or slot == 1 then
		return 0
	else
		return 10
	end
end

function getPlayerNameWidth(slot)
	if multiplayerLocalPlayerID ~= 1 or slot == 1 then
		return 45
	else
		return 35
	end
end

function getStartGameButtonTooltip()
	if multiplayer.donebuttonclickable then
		return ""
	else
		return t("MULTIPLAYER_CANNOT_START")
	end
end

function updateMultiplayerSessionData(sessionName, saveName, chapter, timePlayed, difficulty)
	local gold = "^0xffc7f8fb"
	multiplayerSessionName = gold..sessionName.."^-"

	if areaName ~= "" then
		multiplayerSaveName = gold..t("MULTIPLAYER_SAVED_GAME_LABEL").."^- ^0xffffffff"..saveName.."^-"
		multiplayerChapter = gold..t("MULTIPLAYER_CHAPTER_LABEL").."^- ^0xffffffff"..chapter.."^-"
		multiplayerTimePlayed = gold..t("MULTIPLAYER_TIME_PLAYED_LABEL").."^- ^0xffffffff"..timePlayed.."^-"
		if difficulty > 0 then
			mulitplayerPreexistingDifficulty = difficulty
			multiplayerDifficultyLabel = gold..t("MULTIPLAYER_DIFFICULTY_LABEL").."^-^0xffffffff"..t(difficulties[difficulty].name).."^-"
			multiplayerDifficultyImage = difficulty - 1
		end
	else
		multiplayerSaveName = gold..t("MULTIPLAYER_NEW_GAME_LABEL").."^- ^0xffffffff"..saveName.."^-"
		multiplayerChapter = gold..t("MULTIPLAYER_CHAPTER_LABEL").."^- ^0xffffffff"..chapter.."^-"
		multiplayerTimePlayed = gold..t("MULTIPLAYER_TIME_PLAYED_NEW_GAME").."^-"
		if difficulty > 0 then
			multiplayerDifficultyLabel = gold..t("MULTIPLAYER_DIFFICULTY_LABEL").."^-^0xffffffff"..t(difficulties[difficulty].name).."^-"
			multiplayerDifficultyImage = difficulty - 1
		end
	end
end

function broadcastCharacterControlChange(slot, newPlayer)
	print("newPlayer "..newPlayer.." current "..currentMultiplayerSelectPlayer.." playernumber "..mpaCharacters[slot]["player"])
	if mpaCharacters[slot]["player"] ~= newPlayer then
		local host = getMultiplayerPlayerName(1,false,false)
		local player = getMultiplayerPlayerName(newPlayer,false,false)
		setStringTokenLua("<PLAYER_NAME_1>",host)
		setStringTokenLua("<PLAYER_NAME_2>",player)
		local message = t("MULTIPLAYER_SLOT_"..slot.."_ASSIGNED_TO")
		removeStringTokenLua("<PLAYER_NAME_1>")
		removeStringTokenLua("<PLAYER_NAME_2>")
		print(message)
		Infinity_SendChatMessage(message, true)
	end
end

function broadcastCharacterAdded(slot)
	local player = getMultiplayerPlayerName(mpaCharacters[slot]["player"],false,false)
	local character = getMultiplayerCharacterName(slot, false, true)
	setStringTokenLua("<PLAYER_NAME_1>",player)
	setStringTokenLua("<CHARACTER_NAME_1>",character)
	local message = t("MULTIPLAYER_HAS_ADDED")
	removeStringTokenLua("<PLAYER_NAME_1>")
	removeStringTokenLua("<CHARACTER_NAME_1>")
	print(message)
	Infinity_SendChatMessage(message, true)
end

function broadcastCharacterRemoved(slot)
	local player = getMultiplayerPlayerName(mpaCharacters[slot]["player"],false,false)
	local character = getMultiplayerCharacterName(slot, false, true)
	setStringTokenLua("<PLAYER_NAME_1>",player)
	setStringTokenLua("<CHARACTER_NAME_1>",character)
	local message = t("MULTIPLAYER_HAS_REMOVED")
	removeStringTokenLua("<PLAYER_NAME_1>")
	removeStringTokenLua("<CHARACTER_NAME_1>")
	print(message)
	Infinity_SendChatMessage(message, true)
end

function broadcastCharacterReady(slot)
	local character = getMultiplayerCharacterName(slot, false, false)
	setStringTokenLua("<CHARACTER_NAME_1>",character)
	local message = t("MULTIPLAYER_IS_READY_TO_START")
	removeStringTokenLua("<CHARACTER_NAME_1>")
	print(message)
	Infinity_SendChatMessage(message, true)
end

function broadcastCharacterNotReady(slot)
	local character = getMultiplayerCharacterName(slot, false, false)
	setStringTokenLua("<CHARACTER_NAME_1>",character)
	local message = t("MULTIPLAYER_IS_NO_LONGER_READY")
	removeStringTokenLua("<CHARACTER_NAME_1>")
	print(message)
	Infinity_SendChatMessage(message, true)
end

function broadcastPlayerAdded(slot)
	local player = getMultiplayerPlayerName(slot,false,false)
	setStringTokenLua("<PLAYER_NAME_1>",player)
	local message = t("MULTIPLAYER_HAS_JOINED_THE_GAME")
	removeStringTokenLua("<PLAYER_NAME_1>")
	print(message)
	Infinity_SendChatMessage(message, true)
end

function broadcastPlayerRemoved(slot)
	local player = getMultiplayerPlayerName(slot,false,false)
	setStringTokenLua("<PLAYER_NAME_1>",player)
	local message = t("MULTIPLAYER_HAS_LEFT_THE_GAME")
	removeStringTokenLua("<PLAYER_NAME_1>")
	print(message)
	Infinity_SendChatMessage(message, true)
end

mpDraggedCharacter = nil
mpDraggedPortrait = 'NOCTRL'

function multiplayerStartSwapPortraits(player, character)
	if multiplayerLocalPlayerID == 1 and player > 0 and player < 7 and mpaPlayers[player]["name"] ~= "" then
		print("Starting the drag of player "..player.." character slot "..character)
		mpDraggedCharacter = character
		multiplayerScreen:SetModifiedCharacterSlot(character - 1)
		currentMultiplayerSelectPlayer = player
		mpDraggedPortrait = mpaCharacters[character]["portrait"]
	end
end

function multiplayerStopSwapPortraits(player)
	if multiplayerLocalPlayerID == 1 then
		if player > 0 and player < 7 and mpaPlayers[player]["name"] ~= "" and currentMultiplayerSelectPlayer ~= nil then
			if mpaCharacters[mpDraggedCharacter]['ready'] == true and mpaCharacters[mpDraggedCharacter]['player'] ~= player then
				multiplayerScreen:OnReadyButtonClick(mpDraggedCharacter-1)
			end
			broadcastCharacterControlChange(mpDraggedCharacter, player)
			multiplayerScreen:OnPlayerSelection(player-1)
		end
		mpDraggedCharacter = nil
		currentMultiplayerSelectPlayer = nil
		mpDraggedPortrait = 'NOCTRL'
	end
end

function getMultiplayerReadyTooltip(character)
	local ret = ""

	if mpaCharacters[character]["ready"] == true then
		ret = t("MULTIPLAYER_READY_BUTTON_ON_TOOLTIP")
	else
		ret = t("MULTIPLAYER_READY_BUTTON_OFF_TOOLTIP")
	end

	return ret
end

function multiplayerUpdateDraggedPortrait()
	if mpDraggedPortrait ~= 'NOCTRL' and multiplayerLocalPlayerID == 1 then
		local x,y,w,h = Infinity_GetArea('multiplayerDraggingPortraitImage')
		x,y = Infinity_GetMousePosition();
		x = x - 20
		y = y - 30
		Infinity_SetArea('multiplayerDraggingPortraitImage',x,y,w,h)
		return true
	else
		local x,y,w,h = Infinity_GetArea('multiplayerDraggingPortraitImage')
		Infinity_SetArea('multiplayerDraggingPortraitImage',-20,-20,w,h)
		return false
	end
end

function get4CheckFrame(slot)
	local ret = 1

	if mpaCharacters[slot]['ready'] == true and mpaCharacters[slot]['player'] == multiplayerLocalPlayerID then
		ret = 0
	elseif mpaCharacters[slot]['ready'] == true then
		ret = 2
	end

	return ret
end
