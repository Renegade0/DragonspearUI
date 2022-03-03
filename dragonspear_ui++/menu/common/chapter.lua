
chapterBackground = ""

text_CHAPTERSCROLL = ""
text_CHAPTERSCROLL_timeStart = 0
text_CHAPTERSCROLL_auto = 1
function UpdateChapterScroll(top, height, contentHeight)
	if(text_CHAPTERSCROLL_auto == 0) then
		--defer to default scrolling
		return nil
	end
	local dT = Infinity_GetClockTicks() - text_CHAPTERSCROLL_timeStart
	local timerCrawl = dT * -0.009
	if megacredits ~= '' then
		timerCrawl = dT * -0.09
	end
	local newTop = timerCrawl + height
	if(newTop + contentHeight + height < height) then
		return top
	end
	return newTop
end
function setChapterBackground(id)
	#if GAME_VERSION == 'sod' then
	--if chapterBackgrounds[id] == nil then
	--chapterBackground = chapterBackgrounds[0]
	--else
	--chapterBackground = chapterBackgrounds[id]
	--end
	#end
	chapterBackground = chapterBackgrounds[id]
end
function rgChapterNumber()
	local chapter = Infinity_GetMaxChapterPage()
	local chapters = {}
	for i = 0, 12 do
		local offset = i > 7 and 70004 or 16202
		chapters[chapterBackgrounds[i]] = offset + chapter
	end
	return Infinity_FetchString(chapters[chapterBackground])
end
function getChapterArea()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
	Infinity_SetArea('chpBottomLeft', nil, screenHeight-355, nil, nil)
	Infinity_SetArea('chpTopRight', screenWidth-287, nil, nil, nil)
	Infinity_SetArea('chpBottomRight', screenWidth-287, screenHeight-359, nil, nil)
	Infinity_SetArea('chpImage', 25, 65, screenWidth-48, screenHeight-133)
	Infinity_SetArea('chpTextRect', screenWidth-565, 139, nil, nil)
	Infinity_SetArea('chpNumber', (screenWidth-600)/2, 10, nil, nil)
	Infinity_SetArea('chpText', screenWidth-552, 146, nil, nil)
--	Infinity_SetArea('text_CHAPTERSCROLL_item', screenWidth-552, 146, nil, nil)
	Infinity_SetArea('chpDoneButt', (screenWidth/2)+5, screenHeight-58, nil, nil)
	Infinity_SetArea('chpReplayButt', (screenWidth/2)-235, screenHeight-58, nil, nil)
end