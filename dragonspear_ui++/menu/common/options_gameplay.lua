function toggleFrame(curFrame)
	if curFrame == 0 then
		return 2
	else
		return 0
	end
end
function getSelected(cur, my)
	if cur == my then
		return 1
	else
		return 0
	end
end
function removeStoryModeOption()
	for index = 1, #toggleTitles-1, 1 do
		toggleTitles[index] = toggleTitles[index+1]
	end
	toggleTitles[#toggleTitles] = nil
end
function addStoryModeOption()
	for index = #toggleTitles, 1, -1 do
		toggleTitles[index+1] = toggleTitles[index]
	end
	toggleTitles[1] = {'DIFFICULTY_LABEL_STORYMODE',	'DIFFICULTY_DESCRIPTION_STORYMODE`CHARGEN_DIFFICULTY_DESCRIPTION_SUFFIX`',	65, 0, 0}
end

function removeOptionFromList(list, option)
	local startingPoint = 1
	local found = false
	for index = 1, #list-1, 1 do
		if list[index][3] == option then
			startingPoint = index
			found = true
			break
		end
	end
	if found == true then
		for index = startingPoint, #list-1, 1 do
			list[index] = list[index+1]
		end
		list[#list] = nil
	end
end

toggleTitles = {
{"DIFFICULTY_LABEL_STORYMODE_MIXED",	"DIFFICULTY_DESCRIPTION_STORYMODE`CHARGEN_DIFFICULTY_DESCRIPTION_SUFFIX`",	65, 0, 0},
{"ENABLE_CLOUD_LABEL",					"ENABLE_CLOUD_DESCRIPTION", 		60, 0, 0},
{"WORLDMAP_HIGHLIGHT_LABEL",			"WORLDMAP_HIGHLIGHT_DESCRIPTION", 	66, 0, 0},
{"MP_CHAT_LABEL",						"MP_CHAT_DESCRIPTION",				67, 0, 0},
{"GORE_LABEL",							"GORE_DESCRIPTION", 				19, 0, 0},
{"WEATHER_LABEL",						"WEATHER_DESCRIPTION", 				47, 0, 0},
{"GROUP_INFRA_LABEL",					"GROUP_INFRA_DESCRIPTION", 			42, 0, 0},
{"HEAL_ON_REST_LABEL",					"HEAL_ON_REST_DESCRIPTION", 		50, 0, 0},
{"MAX_HP_ON_LEVEL_LABEL",				"MAX_HP_ON_LEVEL_DESCRIPTION", 		55, 0, 0},
{"NO_DAMAGE_INCREASE_LABEL",			"NO_DAMAGE_INCREASE_DESCRIPTION", 	64, 0, 0},
{"AUTO_USE_MAGIC_AMMO_LABEL",			"AUTO_USE_MAGIC_AMMO_DESCRIPTION", 	68, 0, 0},
}

selectedOpt = 0
helpString = 0

ttDelaySLDR = 0
keyboardSLDR = 0
mouseSLDR = 0
difficultySLDR = 0

panelID = 8

function getDifficulty(d)
	local text = ""
	if ( d ==0 ) then
		text = t("DIFFICULTY_LABEL_EASY")
	elseif (d == 1) then
		text = t("DIFFICULTY_LABEL_NORMAL")
	elseif (d == 2) then
		text = t("DIFFICULTY_LABEL_CORERULES")
	elseif (d == 3) then
		text = t("DIFFICULTY_LABEL_HARD")
	elseif (d == 4) then
		text = t("DIFFICULTY_LABEL_INSANE")
	elseif (d == 5) then
		text = string.upper(t("MULTIPLAYER_DIFFICULTY_LABEL")).." "..t("DIFFICULTY_LABEL_LEGACYOFBHAAL")
	end
	return text
end