function math.sign(value)
	if value < 0 then return -1
	elseif value > 0 then return 1
	else return 0 end
end

SpellBook = {}

function SpellBook:create()
	local self = setmetatable({
		page = 1,
		columns = { {}, {} },
		spells = {},
	}, { __index = self })

	return self
end

function SpellBook:update(spells)
	self.spells = spells
	self:setPage(self.page, true)
end

function SpellBook:canScroll(direction)
	if direction < 0 then
		return self.page > 1
	elseif direction > 0 then
		return 24 * self.page < #self.spells
	end
	return false
end

function SpellBook:scroll(direction, force)
	local direction = math.sign(direction or -scrollDirection)
	self:setPage(self.page + direction, force)
end

function SpellBook:setPage(page, force)
	page = math.max(1, page)
	page = math.min(page, math.ceil(#self.spells / 24))

	-- force is used when the spell book is refreshed,
	-- i.e. on spell level change or when a spell is erased
	if page == self.page and not force then
		return
	end

	-- split into 2 columns
	self.columns = { {}, {} }
	self.page = page
	local offset = 1 + (page - 1) * 24

	for i = offset, math.min(#self.spells, offset + 23) do
		table.insert(self.columns[2 - i % 2], self.spells[i])
	end
end