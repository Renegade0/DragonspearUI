--Multiplayer start.
mp_shownSessions = {}
selectedMp = 0
detailsStr = ""
passwordReq = 0
passwordMp = ""
connectionPlayerNameEdit = ""
connectionFilterNoPasswords = 0
connectionFilterNoFullGames = 0
selectedIndex = 0
connectionIsHosting = false

function connectionBuildGameList()
	local index = 1
	local count = 0
	local entryOK = true
	local foundSelected = false

	for index = 1, #(mp_sessions), 1 do
		entryOK = true
		Infinity_GetPasswordRequired(index)
		if mp_sessions[index] == nil then
			entryOK = false
		elseif mp_sessions[index]["flags"] == nil then
			entryOK = false
		elseif connectionFilterNoPasswords == 1 and passwordReq ~= 0 then
			entryOK = false
		elseif connectionFilterNoFullGames == 1 and mp_sessions[index]["players"] == 6 then
			entryOK = false
		end

#if GAME_VERSION == 'sod' then
		if e:IsTouchUI() and mp_sessions[index]["version"] ~= "bgee-sod" then
			entryOK = false
		end
#end

		if entryOK == true then
			count = count + 1
			mp_shownSessions[count] = {}
			mp_shownSessions[count]["actualIndex"] = index
			mp_shownSessions[count]["updated_at"] = mp_sessions[index]["updated_at"]

			if mp_sessions[index]['sessionIDString'] == selectedIndex then
				selectedMp = count
				foundSelected = true
			end
		end
	end

	local tableCount = #(mp_shownSessions)
	while tableCount > count do
		mp_shownSessions[tableCount] = nil
		tableCount = tableCount - 1
	end

	if foundSelected == false then
		selectedMp = 0
	end
end
function chooseNetworkProtocol(num)
	connectionScreen:SelectServiceProvider(num)
end
function joinGameEnabled()
	if selectedMp <= 0 or mp_shownSessions[selectedMp]['actualIndex'] == nil then
		return 0
	else
		return 1
	end
end
function gameHasPassword(slot)
	if(mp_sessions[mp_shownSessions[slot]["actualIndex"]] == nil) then
		--if the session isn't loaded don't show anything.
		return ""
	end
	Infinity_GetPasswordRequired(mp_shownSessions[slot]["actualIndex"])
	if passwordReq ~= 0 then
		ret = t("YES")
	else
		ret = t("NO")
	end
	return ret
end
function connectionGetGameName(slot)
	ret = ""

	ret = mp_sessions[mp_shownSessions[slot]["actualIndex"]]['name']

	return ret
end
function connectionGetNumPlayers(slot)
	ret = 0

	ret = mp_sessions[mp_shownSessions[slot]["actualIndex"]]['players']

	return ret
end
function connectionGetGameType(slot)
	ret = ""

	if mp_sessions[mp_shownSessions[slot]["actualIndex"]] ~= nil then
#if GAME_VERSION == 'sod' then
		if mp_sessions[mp_shownSessions[slot]["actualIndex"]]["version"] == "bgee-main" then
			ret = t("MAIN_GAME_LABEL")
		elseif mp_sessions[mp_shownSessions[slot]["actualIndex"]]["version"] == "bgee-bp" then
			ret = t("ARENA_MODE_LABEL")
		elseif mp_sessions[mp_shownSessions[slot]["actualIndex"]]["version"] == "bgee-sod" then
			ret = t("EXPANSION_LABEL")
		end
#else
		if mp_sessions[mp_shownSessions[slot]["actualIndex"]]["version"] == "bg2ee-main" then
			ret = t("MAIN_GAME_BG2_LABEL")
		elseif mp_sessions[mp_shownSessions[slot]["actualIndex"]]["version"] == "bg2ee-bp" then
			ret = t("ARENA_MODE_BG2_LABEL")
		elseif mp_sessions[mp_shownSessions[slot]["actualIndex"]]["version"] == "bg2ee-tob" then
			ret = t("EXPANSION_BG2_LABEL")
		end
#end
	end

	return ret
end

function matchMultiplayerGameType(gameVersion)
#if GAME_VERSION == 'sod' then
	if gameVersion == "bgee-main" then
		startEngine:OnSoAButtonClick(false)
		e:CheckGUISong()
	elseif gameVersion == "bgee-bp" then
		startEngine:OnTBPButtonClick(false)
		e:CheckGUISong()
	elseif gameVersion == "bgee-sod" then
		startEngine:OnCampaignButtonClick('SOD',false)
#else
	if gameVersion == "bg2ee-main" then
		startEngine:OnSoAButtonClick(false)
		e:CheckGUISong()
	elseif gameVersion == "bg2ee-bp" then
		startEngine:OnTBPButtonClick(false)
		e:CheckGUISong()
	elseif gameVersion == "bg2ee-tob" then
		startEngine:OnToBButtonClick(false)
#end
		e:CheckGUISong()
	end
end