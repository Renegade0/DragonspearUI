	function getActivePlayerIndex(index)
		local ret = -1
		local count = 0
		local slot = 0

		for slot = 1, 6, 1 do
			if mpaPlayers[slot]["name"] ~= '' then
				count = count + 1
			end
			if count == index then
				ret = slot
				break
			end
		end

		return ret
	end