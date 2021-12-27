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

local function patchObject(object, keys, wrapper)
	local store = {}

	for _, name in pairs(keys) do
		local value = object[name]
		store[name] = value
		object[name] = wrapper(value, name)
	end

	return store
end

Inventory = {
	invalidSlot = { valid = 0 }
}


function Inventory:create()
	local self = setmetatable({}, { __index = self })

	-- ASSIGN_KEYS_QUICKSLOTS_CHARACTER[1-6]
	self.keymap = keybindingsForIds({ 56, 57, 58, 59, 60, 61 })
	for _, i in pairs(self.keymap.missing) do
		popupInfo(string.format(
			"Shortcut to select character %d is unassigned.\n" ..
			"Inventory won't work correctly."
		, i))
		break
	end

	-- Optional equipment comparison
	self.stats = { AC = '', THAC0 = '', damage = '', HP = '' }
	self.compare_equipment = Infinity_GetINIValue('Game Options', 'Equipment Comparison', 1) ~= 0
	self:updateStats()

	-- set offhand color
	self._patched_fontcolor = fontcolors['O']
	fontcolors['O'] = 'AA96C8FF' -- dimmed ^D, default text color for stats

	self.paused = false
	self.name_to_idx = {}
	self.idx_to_id = {}
	self.count = Infinity_GetNumCharacters()
	local selected = Infinity_GetSelectedCharacterName()

	for i = 1, self.count do
		Infinity_SetArea('slotsArea' .. i, nil, nil, 392, 98)
		Infinity_OnPortraitLClick(i - 1)
		Infinity_UpdateLuaStats()
		local char = characters[id]
		self.name_to_idx[char.name] = i
		self.idx_to_id[i] = id
	end

	for i = self.count + 1, 6 do
		Infinity_SetArea('slotsArea' .. i, nil, nil, 0, 0)
	end

	-- auto updated
	-- hovered: updated on slots area hover
	-- selected: gets updated on every frame
	-- this will set these variables to the synced state
	self:onSlotsAreaEnter(self.name_to_idx[selected])

	-- Inject updateSlotsHighlight to the functions listed below.
	-- It's needed to update slots' highlighting on item drag start/stop.
	self.slotsHighlightScheduled = nil
	local names = {
		'Infinity_SwapSlot',
		'Infinity_SwapWithPortrait',
		'Infinity_SwapWithAppearance'
	}

	local function wrapper(f, name)
		-- The game crashes if updateSlotsHighlight is called here
		-- when you swap an item with another one on the ground.
		-- There is a noticeable visual delay if the update is
		-- done later, so only do it conditionally.
		local needsWorkaround = name == 'Infinity_SwapSlot'

		return function(...)
			-- result = 1: item picked up, 2: put down
			local result = f(...)

			-- update equipment comparison info
			self:updateStats()

			if result == 1 and needsWorkaround then
				-- The returned mouse position is weird, I think it's relative
				-- to the center of some parent element, probably inventory window.
				-- Either way the character slots end at 700 apparently.
				local x = Infinity_GetMousePosition()
				if x > 700 then
					self.slotsHighlightScheduled = true
					return result
				end
			end

			self:updateSlotsHighlight()
			return result
		end
	end

	self._patched = patchObject(_G, names, wrapper)

	return self
end

function Inventory:deinit()
	-- restore patched swap slot functions
	if self._patched then
		for name, original in pairs(self._patched) do
			_G[name] = original
		end
		self._patched = {}
	end

	fontcolors['O'] = self._patched_fontcolor
end

function Inventory:slot(slot_idx, char_idx)
	if char_idx > self.count then
		return self.invalidSlot
	end

	local char = characters[self.idx_to_id[char_idx]]
	if char then
		return char.equipment['group' .. (slot_idx - 1)]
	end

	return self.invalidSlot
end

function Inventory:update()
	local selected = self.name_to_idx[Infinity_GetSelectedCharacterName()]

	if self.selected ~= selected then
		Infinity_SetArea('encumberanceButton', nil, 85 + (selected - 1) * 106, nil, nil)
		self.selected = selected

		-- we pressed a 1-6 key, we might be desynced
		if self.hovered and selected ~= self.hovered then
			Infinity_SetArea('slotsAreaCover', nil, 85 + 106 * (self.hovered - 1), 392, 98)
		else
			Infinity_SetArea('slotsAreaCover', nil, nil, 0, 0)
		end

		self:updateStats()
	end

	if self.slotsHighlightScheduled then
		self.slotsHighlightScheduled = nil
		self:updateSlotsHighlight()
	end

	return true
end

function Inventory:updateSlotsHighlight()
	local n = self.selected
	for i = 1, self.count do
		if i ~= n then
			self:select(i)
		end
	end
	self:select(n)
end

function Inventory:select(i)
	local key = self.keymap[i]
	if key then
		Infinity_PressKeyboardButton(key)
	end
end

function Inventory:onSlotsAreaEnter(n)
	if self.hovered ~= n then
		-- we are in sync, i.e. hovered == nil or hovered == selected
		-- remove the cover
		Infinity_SetArea('slotsAreaCover', nil, nil, 0, 0)

		-- restore previously hovered area
		if self.hovered then
			Infinity_SetArea('slotsArea' .. self.hovered, nil, nil, 392, 98)
		end

		-- invalid area, we're done
		if n == nil then
			self.hovered = nil
			return
		end

		-- valid area, hide it, select hovered char
		-- NOTE: triggers actionExit for the slotsArea
		Infinity_SetArea('slotsArea' .. n, nil, nil, 0, 0)
		self.hovered = n
		self:select(n)
	end
end

function Inventory:togglePause()
	self.paused = not self.paused
end

function keybindingsForIds(keys)
	local bindingsById = {}
	for _, category in pairs(keybindings) do
		for _, key in pairs(category) do
			bindingsById[key[1]] = key
		end
	end

	local map = { missing = {} }

	for index, name in pairs(keys) do
		local key = bindingsById[name]
		if key and key[6] ~= 0 then
			map[index] = string.char(key[6])
		else
			table.insert(map.missing, index)
		end
	end

	return map
end

-- Same as getTempStat, but takes tempStats[key] as new not key
-- and returns nil instead of "-" when there is no difference
function Inventory.diffStats(old, new, coeff)
	local score = coeff * (new - old)
	if score < 0 then
		return '^R' .. new .. '^-'
	elseif score > 0 then
		return '^G' .. new .. '^-'
	end
end

function Inventory:updateStats()
	local stats = self.stats
	local character = characters[id]

	if not character then
		for key, _ in pairs(stats) do
			stats[key] = ''
		end
		return
	end

	-- offhand color, modified below if tmp is not nil
	local offhand_start, offhand_stop = '', ''
	local HP = character.HP
	local damage = character.damage

	stats.AC = character.AC.current
	stats.THAC0 = character.THAC0.current
	stats.damage = ('%s - %s'):format(damage.min, damage.max)
	stats.HP = ('%s / %s'):format(HP.current, HP.max)

	local tmp = self.compare_equipment and tempStats[id]

	if tmp then
		local diff1, diff2
		local fmt = '%s ^8| %s'

		diff1 = self.diffStats(stats.AC, tmp.AC, -1)
		if diff1 then
			stats.AC = fmt:format(stats.AC, diff1, tmp.AC)
		end

		diff1 = self.diffStats(stats.THAC0, tmp.THAC0, -1)
		if diff1 then
			stats.THAC0 = fmt:format(stats.THAC0, diff1, tmp.THAC0)
		end

		diff1 = self.diffStats(damage.min, tmp.dmgMin, 1)
		diff2 = self.diffStats(damage.max, tmp.dmgMax, 1)
		if diff1 or diff2 then
			stats.damage = ('%s - %s\n%s - %s'):format(
				diff1 or tmp.dmgMin, diff2 or tmp.dmgMax,
				damage.min, damage.max
			)
		end

		diff1 = self.diffStats(HP.current, tmp.currentHP, 1)
		diff2 = self.diffStats(HP.max, tmp.maxHP, 1)
		if diff1 or diff2 then
			stats.HP = ('%s / %s\n%s / %s'):format(
				diff1 or tmp.currentHP, diff2 or tmp.maxHP,
				HP.current, HP.max
			)
		end

		offhand_start, offhand_stop = '^O', '^-'
	end

	if character.THAC0.offhand then
		stats.THAC0 = ('%s\n%s%s%s'):format(
			stats.THAC0, offhand_start, character.THAC0.offhand, offhand_stop
		)
	end

	if damage.minOffhand and damage.maxOffhand then
		stats.damage = ('%s\n%s%s - %s%s'):format(
			stats.damage,
			offhand_start, damage.minOffhand,
			damage.maxOffhand, offhand_stop
		)
	end
end
