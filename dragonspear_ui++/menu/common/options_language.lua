language = 0
showsubtitles = 0
displayLanguages = {}
function languageDetails()
	if displayLanguages[language] ~= nil then
		return Infinity_FetchString(displayLanguages[language][2]) .. '\n'  .. Infinity_FetchString(displayLanguages[language][3])
	else
		return ""
	end
end
function findCurrentLanguage()
	local lang = Infinity_GetINIString('Language', 'Text', '')
	for k,v in pairs(displayLanguages) do
		if v[1] == lang then
			language = k
		end
	end
end