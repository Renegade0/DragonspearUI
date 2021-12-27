connection = {}
connectionSessionNameEdit = ""
connectionSessionPasswordEdit = ""
connectionPasswordProtected = 0
connectionLocalNetworkGame = 0

function connectionCreateGameClickable()
	local ret = string.find(connectionPlayerNameEdit, '%S') ~= nil and string.find(connectionSessionNameEdit, '%S') ~= nil

	if connectionPasswordProtected == 1 then
		ret = ret and string.find(connectionSessionPasswordEdit, '%S') ~= nil
	end

	return ret
end
function connectionSetDefaultGameSettings()
	local player = t("MULTIPLAYER_DEFAULT_PLAYER")
	local game = t("MULTIPLAYER_ENTER_GAME_NAME")
	local pass = t("MULTIPLAYER_ENTER_GAME_PASSWORD")

	if connectionPlayerNameEdit == "" then
		connectionPlayerNameEdit = Infinity_GetINIString('Multiplayer', 'Player Name', player)
		Infinity_SetINIValue('Multiplayer', 'Player Name', connectionPlayerNameEdit)
	end

	if connectionSessionPasswordEdit == "" then
		connectionSessionPasswordEdit = Infinity_GetINIString('Multiplayer', 'Session Password', pass)
		Infinity_SetINIValue('Multiplayer', 'Session Password', connectionSessionPasswordEdit)
	end

	if connectionSessionNameEdit == "" then
		connectionSessionNameEdit = Infinity_GetINIString('Multiplayer', 'Session Name', game)
		Infinity_SetINIValue('Multiplayer', 'Session Name', connectionSessionNameEdit)
	end

	if connectionSessionPasswordEdit ~= "" then
		connectionPasswordProtected = 1
	else
		connectionPasswordProtected = 0
	end

	if connectionScreen:HasServiceProvider() then
		connectionLocalNetworkGame = 0
	else
		connectionLocalNetworkGame = 1
	end
end