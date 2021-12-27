multiplayerGameOptions =
{
	{"LISTEN_JOIN_LABEL",	"LISTEN_JOIN_TOOLTIP",	false, false},
	{"ALLOW_REFORM_LABEL",	"ALLOW_REFORM_TOOLTIP",	false, false}
}
multiplayerImportOptions =
{
	{"MULTIPLAYER_IMPORT_CHARACTER_RULES_SEI"},
	{"MULTIPLAYER_IMPORT_CHARACTER_RULES_SE"},
	{"MULTIPLAYER_IMPORT_CHARACTER_RULES_S"}
}
multiplayerImportOption = 0

function broadcastOptionChange(slot, onOff)
	if multiplayerLocalPlayerID == 1 then
		local message = ""
		if slot < 3 then
			local setting = t(multiplayerGameOptions[slot][1])
			setStringTokenLua("<SESSION_RULES>",setting)
			if onOff == true then
				message = t("MULTIPLAYER_GAME_WILL_NOW")
			else
				message = t("MULTIPLAYER_GAME_WILL_NO_LONGER")
			end
			removeStringTokenLua("<SESSION_RULES>")
		else
			local setting = t(multiplayerImportOptions[slot-2][1])
			setStringTokenLua("<IMPORT_RULES>",setting)
			message = t("MULTIPLAYER_IMPORT_SETTINGS_CHANGE")
			removeStringTokenLua("<IMPORT_RULES>")
		end
		print(message)
		Infinity_SendChatMessage(message, true)
	end
end