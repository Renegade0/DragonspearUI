function generateMegaCredits()
	megacredits = ''
	for k,v in pairs(credits) do
		megacredits = megacredits .. Infinity_FetchString(v)..'\n'
	end
end