	identifyItemsVar = 0

function filter(t)
	local out = {}
	for k, v in pairs(t) do
		if v.valid == 1 then
			table.insert(out, v)
		end
	end
	return out
end
function getIdx(t, i)
	local o = 0
	for k, v in pairs(t) do
		o = o + 1
		if v.valid == 1 then i = i - 1 end
		if i == 0 then break end
	end
	return o
end