#if INVENTORY == 'v1' then
	TEXT_inventoryError = ""

function resetStatsDisplay()
	tempStats = {}
end
function getTempDamage()
	local str = ""
	local dmgMinTemp = getTempStat(characters[id].damage.min,'dmgMin',1)
	local dmgMaxTemp = getTempStat(characters[id].damage.max,'dmgMax',1)
	if(dmgMinTemp == "-" and dmgMaxTemp == "-") then
		return "-"
	end
	if(dmgMinTemp == "-") then
		str = characters[id].damage.min
	else
		str = dmgMinTemp
	end
	str = str .. " - "
	if(dmgMaxTemp == "-") then
		str = str .. characters[id].damage.max
	else
		str = str .. dmgMaxTemp
	end

	return str
end
function getStat(old, newName, coeff)
	return old
end
function getTempStat(old, newName, coeff)
	if(tempStats[id] == nil) then
		return "-"
	end
	local new = tempStats[id][newName]
	local score = coeff * (new - old)
	if(score == 0) then
		return "-"
	end
	if(score < 0) then
		return "^R" .. new .. "^-"
	end
	if(score > 0) then
		return "^G" .. new .. "^-"
	end
end
function getStatsTitle()
	if(tempStats[id] ~= nil) then
		return tempStats[id].tempItem
	else
		return ""
	end
end
function slotDoubleClick(slotName, force)
	local slot = characters[id].equipment[slotName]

	if(string.sub(slotName,1,6) == "ground" and force == nil) then
		--this hack is needed because the unlike other slots, ground item add/remove is a message (doesnt get executed immediately)
		--since the double click removes the item before re-adding it, we need to wait for that re-add to complete before continuing.
		doubleClickEventScheduled = slotName
		return
	end

	if(slot ~= nil) then
		if(slot.item.isBag ~= 0) then
			Infinity_OpenInventoryContainer(slot.item.res)
		else
			showItemAmountRequester(slotName)
		end
	end
end
function checkDoubleClickScheduled(slotName)
	if(doubleClickEventScheduled == slotName) then
		slotDoubleClick(doubleClickEventScheduled, true)
		doubleClickEventScheduled = nil
	end
end
function getTempHP()
	local maxHP = getTempStat(characters[id].HP.max,'maxHP',1)
	local currentHP = getTempStat(characters[id].HP.current, 'currentHP',1)
	if(maxHP == "-" and currentHP == "-") then
		--nothing changed.
		return "-"
	end
	if(maxHP == "-") then
		--only current HP changed.
		maxHP = characters[id].HP.max
	end
	if(currentHP == "-") then
		--only max HP changed.
		currentHP = characters[id].HP.current
	end

	return currentHP .. '/' .. maxHP
end
function shouldGreyOutInventory()
	return characters[id].HP.current <= 0 or inventoryScreen:IsSpriteOrderable() == false
end
function shouldGreyOutInventory1()
	return characters[id].HP.current > 0 and inventoryScreen:IsSpriteOrderable() == false
end
function getInventoryTHAC0()
	local str = characters[id].THAC0.current
	if(characters[id].THAC0.offhand) then
		str = str .. "\n" .. characters[id].THAC0.offhand
	end
	return str
end
function getInventoryDamage()
	local str = characters[id].damage.min .. ' - ' .. characters[id].damage.max
	if(characters[id].damage.minOffhand and characters[id].damage.maxOffhand) then
		str = str .. "\n" .. characters[id].damage.minOffhand .. ' - ' .. characters[id].damage.maxOffhand
	end
	return str
end
function getInventoryDamageDetails()
	if characters[id].damage.detailsOffhand == nil or characters[id].damage.detailsOffhand == "" then
		return characters[id].damage.details
	else
		return characters[id].damage.details.."\n\n"..characters[id].damage.detailsOffhand
	end
end
function getInventoryTHAC0Details()
	if characters[id].THAC0.detailsOffhand == nil or characters[id].THAC0.detailsOffhand == "" then
		return characters[id].THAC0.details
	else
		return characters[id].THAC0.details.."\n\n"..characters[id].THAC0.detailsOffhand
	end
end
function scrollGroundItems()
	if scrollDirection > 0 then
		Infinity_OnGroundPage(-1)
	elseif scrollDirection < 0 then
		Infinity_OnGroundPage(1)
	end
end
function getItemSlot1(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group0
end
function getItemSlot2(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group1
end
function getItemSlot3(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group2
end
function getItemSlot4(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group3
end
function getItemSlot5(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group4
end
function getItemSlot6(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group5
end
function getItemSlot7(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group6
end
function getItemSlot8(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group7
end
function getItemSlot9(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group8
end
function getItemSlot10(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group9
end
function getItemSlot11(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group10
end
function getItemSlot12(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group11
end
function getItemSlot13(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group12
end
function getItemSlot14(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group13
end
function getItemSlot15(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group14
end
function getItemSlot16(num)
	local exactCharId = charTable[num]
	return characters[exactCharId].equipment.group15
end

charTable = {}
function updateSlots()
	charTable = {}
	local curCharId = id
	--local charTable = {}

	Infinity_OnPortraitLClick(0)
	local CharId1 = id
	Infinity_UpdateLuaStats()
	table.insert(charTable, CharId1)
	Infinity_OnPortraitLClick(1)
	local CharId2 = id
	Infinity_UpdateLuaStats()
	if Infinity_GetNumCharacters() > 1 then
	table.insert(charTable, CharId2)
	end
	Infinity_OnPortraitLClick(2)
	local CharId3 = id
	Infinity_UpdateLuaStats()
	if Infinity_GetNumCharacters() > 2 then
	table.insert(charTable, CharId3)
	end
	Infinity_OnPortraitLClick(3)
	local CharId4 = id
	Infinity_UpdateLuaStats()
	if Infinity_GetNumCharacters() > 3 then
	table.insert(charTable, CharId4)
	end
	Infinity_OnPortraitLClick(4)
	local CharId5 = id
	Infinity_UpdateLuaStats()
	if Infinity_GetNumCharacters() > 4 then
	table.insert(charTable, CharId5)
	end
	Infinity_OnPortraitLClick(5)
	local CharId6 = id
	Infinity_UpdateLuaStats()
	if Infinity_GetNumCharacters() > 5 then
	table.insert(charTable, CharId6)
	end

	if curCharId == CharId1 then Infinity_OnPortraitLClick(0) getEncumberanceArea1()
	elseif curCharId == CharId2 then Infinity_OnPortraitLClick(1) getEncumberanceArea2()
	elseif curCharId == CharId3 then Infinity_OnPortraitLClick(2) getEncumberanceArea3()
	elseif curCharId == CharId4 then Infinity_OnPortraitLClick(3) getEncumberanceArea4()
	elseif curCharId == CharId5 then Infinity_OnPortraitLClick(4) getEncumberanceArea5()
	elseif curCharId == CharId6 then Infinity_OnPortraitLClick(5) getEncumberanceArea6()
	end

	--return charTable
end

function updateSlotsOnExit()
	local curCharId = id

	Infinity_OnPortraitLClick(0)
	Infinity_UpdateLuaStats()
	Infinity_OnPortraitLClick(1)
	Infinity_UpdateLuaStats()
	Infinity_OnPortraitLClick(2)
	Infinity_UpdateLuaStats()
	Infinity_OnPortraitLClick(3)
	Infinity_UpdateLuaStats()
	Infinity_OnPortraitLClick(4)
	Infinity_UpdateLuaStats()
	Infinity_OnPortraitLClick(5)
	Infinity_UpdateLuaStats()

	if curCharId == charTable[1] then Infinity_OnPortraitLClick(0) --getEncumberanceArea1()
	elseif curCharId == charTable[2] then Infinity_OnPortraitLClick(1) --getEncumberanceArea2()
	elseif curCharId == charTable[3] then Infinity_OnPortraitLClick(2) --getEncumberanceArea3()
	elseif curCharId == charTable[4] then Infinity_OnPortraitLClick(3) --getEncumberanceArea4()
	elseif curCharId == charTable[5] then Infinity_OnPortraitLClick(4) --getEncumberanceArea5()
	elseif curCharId == charTable[6] then Infinity_OnPortraitLClick(5) --getEncumberanceArea6()
	end
end

function getEncumberanceArea1()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
	Infinity_OnPortraitLClick(0)
	if id == charTable[1] then
	Infinity_SetArea('encumberanceButton', nil, 85, nil, nil)
	Infinity_SetArea('slotsArea1', nil, nil, 0, 0)
	Infinity_SetArea('slotsArea2', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea3', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea4', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea5', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea6', nil, nil, 392, 98)
	end
end
function getEncumberanceArea2()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
	Infinity_OnPortraitLClick(1)
	if id == charTable[2] then
	Infinity_SetArea('encumberanceButton', nil, 191, nil, nil)
	Infinity_SetArea('slotsArea1', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea2', nil, nil, 0, 0)
	Infinity_SetArea('slotsArea3', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea4', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea5', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea6', nil, nil, 392, 98)
	end
end
function getEncumberanceArea3()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
	Infinity_OnPortraitLClick(2)
	if id == charTable[3] then
	Infinity_SetArea('encumberanceButton', nil, 297, nil, nil)
	Infinity_SetArea('slotsArea1', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea2', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea3', nil, nil, 0, 0)
	Infinity_SetArea('slotsArea4', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea5', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea6', nil, nil, 392, 98)
	end
end
function getEncumberanceArea4()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
	Infinity_OnPortraitLClick(3)
	if id == charTable[4] then
	Infinity_SetArea('encumberanceButton', nil, 403, nil, nil)
	Infinity_SetArea('slotsArea1', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea2', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea3', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea4', nil, nil, 0, 0)
	Infinity_SetArea('slotsArea5', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea6', nil, nil, 392, 98)
	end
end
function getEncumberanceArea5()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
	Infinity_OnPortraitLClick(4)
	if id == charTable[5] then
	Infinity_SetArea('encumberanceButton', nil, 509, nil, nil)
	Infinity_SetArea('slotsArea1', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea2', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea3', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea4', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea5', nil, nil, 0, 0)
	Infinity_SetArea('slotsArea6', nil, nil, 392, 98)
	end
end
function getEncumberanceArea6()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
	Infinity_OnPortraitLClick(5)
	if id == charTable[6] then
	Infinity_SetArea('encumberanceButton', nil, 615, nil, nil)
	Infinity_SetArea('slotsArea1', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea2', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea3', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea4', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea5', nil, nil, 392, 98)
	Infinity_SetArea('slotsArea6', nil, nil, 0, 0)
	end
end


function getInventoryHP()
	return characters[id].HP.current .. '/' .. characters[id].HP.max
end

function getInventoryAC()
	return characters[id].AC.current
end

if Infinity_GetINIValue('Game Options', 'Equipment Comparison', 1) ~= 0 then
	-- dimmed ^D, default text color for stats
	fontcolors['O'] = 'AA96C8FF'

	function getInventoryAC()
		local character = characters[id]
		if not character then
			return ''
		end
		local value = character.AC.current

		local diff1 = getTempStat(value, 'AC', -1)
		if diff1 ~= '-' then
			value = ('%s ^8| %s'):format(value, diff1, tempStats.AC)
		end
		return value
	end

	function getInventoryTHAC0()
		local character = characters[id]
		if not character then
			return ''
		end

		local value = character.THAC0.current
		local diff1 = getTempStat(value, 'THAC0', -1)
		if diff1 ~= '-' then
				value = ('%s ^8| %s'):format(value, diff1, tempStats.THAC0)
				offhand_start, offhand_stop = '^O', '^-'

			if character.THAC0.offhand then
				value = ('%s\n^O%s^-'):format(value, character.THAC0.offhand)
			end
		elseif character.THAC0.offhand then
			value = ('%s\n%s'):format(value, character.THAC0.offhand)
		end
		return value
	end

	function getInventoryHP()
		local character = characters[id]
		if not character then
			return ''
		end

		local HP = character.HP
		local value  = ('%s / %s'):format(HP.current, HP.max)

		local diff1 = getTempStat(HP.current, 'currentHP', 1)
		local diff2 = getTempStat(HP.max, 'maxHP', 1)
		if diff1 ~= '-' or diff2 ~= '-' then
			value = ('%s / %s\n%s / %s'):format(
				diff1 ~= '-' and diff1 or HP.current,
				diff2 ~= '-' and diff2 or HP.max,
				HP.current, HP.max
			)
		end
		return value
	end

	function getInventoryDamage()
		local character = characters[id]
		if not character then
			return ''
		end

		local damage = character.damage
		local value = ('%s - %s'):format(damage.min, damage.max)
		local offhand_start, offhand_stop = '', ''

		local diff1 = getTempStat(damage.min, 'dmgMin', 1)
		local diff2 = getTempStat(damage.max, 'dmgMax', 1)
		if diff1 ~= '-' or diff2 ~= '-' then
			value = ('%s - %s\n%s - %s'):format(
				diff1 ~= '-' and diff1 or damage.min,
				diff2 ~= '-' and diff2 or damage.max,
				damage.min, damage.max
			)
			offhand_start, offhand_stop = '^O', '^-'
		end

		if damage.minOffhand and damage.maxOffhand then
			value = ('%s\n%s%s - %s%s'):format(
				value,
				offhand_start, damage.minOffhand,
				damage.maxOffhand, offhand_stop
			)
		end

		return value
	end
end
#end