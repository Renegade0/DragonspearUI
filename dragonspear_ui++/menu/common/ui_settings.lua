function duiHighlightSelectedText(text, value, selected)
	if value == selected then
		return '^R' .. text .. '^-'
	end
	return text
end

function duiToggle(value, a, b)
	if value == b then
		return a
	else
		return b
	end
end