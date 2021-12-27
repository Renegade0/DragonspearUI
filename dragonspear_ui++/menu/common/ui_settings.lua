UIhelp = 0
function selectedENum(text)
	if QuicklootENum == "Ten" then
		ENumCheck = 10
	elseif QuicklootENum == "Six" then
		ENumCheck = 6
	elseif QuicklootENum == "Five" then
		ENumCheck = 5
	elseif QuicklootENum == "Four" then
		ENumCheck = 4
	elseif QuicklootENum == "Three" then
		ENumCheck = 3
	elseif QuicklootENum == "Two" then
		ENumCheck = 2
	end
	if ENumCheck == tonumber(text) then
		return '^R' .. text .. '^-'
	end
	return text
end
function selectedQLPref(text)
	if QuicklootPref ==  text then
		return '^R' .. text .. '^-'
	end
	return text
end
function selectedQLstartPref(text)
	if QuicklootStartPref ==  text then
		return '^R' .. text .. '^-'
	end
	return text
end