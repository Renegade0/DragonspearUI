selectedAbility = -1
function initAbilities()
	--initialize selected ability
	local i = 1
	while ( i < 4 ) do
		local ability = characters[id].equipment[selectedSlot].abilities[i]
		if(ability ~= nil) then
			if(ability.selected == 1) then
				selectedAbility = i
				return
			end
		end
		i = i + 1
	end
end