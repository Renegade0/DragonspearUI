multiplayerPermissions =
{
	{'MULTIPLAYER_PERMISSIONS_MODIFY',	'MULTIPLAYER_PERMISSIONS_MODIFY_TOOLTIP',	false, false, 7},
	{'MULTIPLAYER_PERMISSIONS_GOLD',	'MULTIPLAYER_PERMISSIONS_GOLD_TOOLTIP',		false, false, 0},
	{'MULTIPLAYER_PERMISSIONS_TRAVEL',	'MULTIPLAYER_PERMISSIONS_TRAVEL_TOOLTIP',	false, false, 1},
	{'MULTIPLAYER_PERMISSIONS_VIEW',	'MULTIPLAYER_PERMISSIONS_VIEW_TOOLTIP',		false, false, 3},
	{'MULTIPLAYER_PERMISSIONS_DIALOGUE','MULTIPLAYER_PERMISSIONS_DIALOGUE_TOOLTIP',	false, false, 2},
	{'MULTIPLAYER_PERMISSIONS_PAUSE',	'MULTIPLAYER_PERMISSIONS_PAUSE_TOOLTIP',	false, false, 4}
}

function broadcastPermissionChange(player,permission,setting)
	local player = getMultiplayerPlayerName(player,false,true)
	local todo = t(multiplayerPermissions[permission][1])
	setStringTokenLua("<PLAYER_NAME_1>",player)
	setStringTokenLua("<PERMISSION>",todo)
	if setting == true then
		message = t("MULTIPLAYER_IS_NOW_PERMITTED")
	else
		message = t("MULTIPLAYER_IS_NOT_PERMITTED")
	end
	removeStringTokenLua("<PLAYER_NAME_1>")
	removeStringTokenLua("<PERMISSION>")
	print(message)
	Infinity_SendChatMessage(message, true)
end

function getMultiplayerPlayerPermissionDescription()
	local player = getMultiplayerPlayerName(multiplayerInPermissionForPlayer,false,false)
	setStringTokenLua("<PLAYER_NAME_1>",player)
	local canPerform = t("MULTIPLAYER_CAN_PERFORM")
	removeStringTokenLua("<PLAYER_NAME_1>")

	return canPerform
end