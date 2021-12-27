function getGooglePlaySignInText()
	if(Infinity_GooglePlaySignedIn() == 1) then
		return t("SIGN_OUT_BUTTON")
	else
		return t("SIGN_IN_BUTTON")
	end
end

keyCategory = 1
key = 0

function displayHelp()
	if not (key == 0) then
		return `REF_DISPLAY_HELP`
	end
	return 0
end

function formatKeyCode(number)
	local ret = ""

	if number < 127 and number > 32 then
		return string.format('%c', keybindings[keyCategory][rowNumber][6])
	end
	ret = t("SDL_" .. string.format('%d', keybindings[keyCategory][rowNumber][6]))

	return ret
end

function getHotkeyName(category,number)
	local ret = ""
	if category < 5 then
		ret = t(keybindings[category][number][4])
		if ret == keybindings[category][number][4] then
			ret = Infinity_FetchString(keybindings[category][number][4])
		end
	else
		ret = Infinity_FetchString(keybindings[category][number][4])
	end
	return ret
end