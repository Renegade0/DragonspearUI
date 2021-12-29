	mouseOverPortrait = -1
	draggedPortrait = nil
	function swapPortraits(dest)
		worldScreen:SwapPortraits(dest,draggedPortrait)
		draggedPortrait = nil
	end

	function getPartyAITooltip()
		if aiButtonToggle == 1 then
			return Infinity_FetchString(15918)
		else
			return Infinity_FetchString(15917)
		end
	end

	function hidePortraits(suffix)
		local n = Infinity_GetNumCharacters()
		local visible, hidden = 'Big', 'Small'
		local sw, sh, bw, bh = 86, 131, 82, 123

		if LargePortraits == 0 then
			visible, hidden = 'Small', 'Big'
			sw, sh, bw, bh = 68, 99, 64, 91
		end

		if suffix then
			visible = visible .. suffix
			hidden = hidden .. suffix
		end

		for i = 1, n do
			Infinity_SetArea('portrait' .. i .. 'Shadow' .. visible, nil, nil, sw, sh)
			Infinity_SetArea('portrait' .. i .. 'Button' .. visible, nil, nil, bw, bh)
			Infinity_SetArea('portrait' .. i .. 'Shadow' .. hidden, nil, nil, 0, 0)
			Infinity_SetArea('portrait' .. i .. 'Button' .. hidden, nil, nil, 0, 0)
		end

		for i = n + 1, 6 do
			Infinity_SetArea('portrait' .. i .. 'ShadowBig', nil, nil, 0, 0)
			Infinity_SetArea('portrait' .. i .. 'ButtonBig', nil, nil, 0, 0)
			Infinity_SetArea('portrait' .. i .. 'ShadowSmall', nil, nil, 0, 0)
			Infinity_SetArea('portrait' .. i .. 'ButtonSmall', nil, nil, 0, 0)
		end
	end