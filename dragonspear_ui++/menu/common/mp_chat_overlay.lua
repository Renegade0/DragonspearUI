	function dragMPChat(newY)
		--do a quick bounds check.
		local area = {Infinity_GetArea("mpChatDisplayBackground")}
		if(area[4] + newY <= 150) then newY = 150 - area[4] end

		area = {Infinity_GetArea("mpChatHandle")}
		local screenWidth, screenHeight = Infinity_GetScreenSize()
		if(area[2] + area[4] + newY > screenHeight) then newY = screenHeight - area[2] - area[4] end

		adjustItemGroup({"mpChatDisplayBackground","mpChatDisplay"}, 0, 0, 0, newY)
		adjustItemGroup({"mpChatEditBackground","mpChatEdit","mpChatHandle"}, 0, newY, 0 , 0)
	end
	mpChatTable = {}
	showMpChat = 0
	function updateChatViewed()
		if(showMpChat == 0) then chatViewed = 0 end
	end
	function updateMPChatPreview(message)
		if(showMpChat == 0) then table.insert(mpChatTable,{text = message}) end
	end
	function getMPMessageOpacity()
		local current = mpChatTable[#mpChatTable]
		if(current == nil) then
			return 0
		end
		if(current.displayTime == nil) then
			current.displayTime = 500

			--set the box size
			Infinity_ScaleToText("mpChatPreview")

			--give some extra room for the padding
			adjustItemGroup({"mpChatPreview"},0,0,0,16)
		end
		if(current.displayTime > 0) then
			current.displayTime = current.displayTime - 4
		end
		if(current.displayTime > 255) then
			return 255
		else
			return current.displayTime
		end
	end
	function getMPMessage()
		if(#mpChatTable > 0 and mpChatTable[#mpChatTable].displayTime ~= nil) then
			return mpChatTable[#mpChatTable].text
		end
		return nil
	end
	function getChatIconOpacity()
		if(chatViewed == 1) then return 255 end
		local sinWave = math.sin(Infinity_GetFrameCounter() / 15)
		local sinWaveAdjusted = (sinWave / 2) + 0.5
		return sinWaveAdjusted * 255
	end
	function getChatBarTooltip()
		if(showMpChat == 0) then
			return t("MULTIPLAYER_CHAT_BAR_COLLAPSED")
		else
			return t("MULTIPLAYER_CHAT_BAR_EXPANDED")
		end
	end
	function resizeMpEditBox()
		Infinity_ScaleToText('mpChatEdit')
		local x,y,w,h = Infinity_GetArea('mpChatEdit')
		local offset = 20
		if(h + offset < 42) then h = (42 - offset) end


		Infinity_SetArea('mpChatEdit',x,y,w,h)
		Infinity_SetArea('mpChatEditBackground',nil,nil,nil,h + offset)
		Infinity_SetArea('mpChatHandle',nil,y+h+(offset/2),nil,nil)
	end

	function mpChatboxScroll(top, height, contentHeight)
		if(mpChatboxJumpToBottom and contentHeight > height) then
			mpChatboxJumpToBottom = nil
			return height-contentHeight
		end
		if(mpChatboxScrollToBottom == 0 and mpChatboxScrollLastHeight == contentHeight) then
			--defer to default scrolling
			return nil
		elseif mpChatboxScrollToBottom == 0 then
			mpChatboxScrollLastHeight = contentHeight
			return height-contentHeight
		end
		if(contentHeight < height) then
			--no scrolling required, content fits
			mpChatboxScrollToBottom = nil
			return nil
		end
		local dT = Infinity_GetClockTicks() - mpChatboxScrollTimeLast
		mpChatboxScrollTimeLast = Infinity_GetClockTicks()
		top = top + lastTrimmedContentHeight
		lastTrimmedContentHeight = 0
		local newTop = (dT * -0.25) + top
		if (newTop + contentHeight > height + 200) then
			return (height - contentHeight + 200)
		end
		if(newTop + contentHeight < height) then
			mpChatboxScrollToBottom = 0
			return height - contentHeight
		end
		return newTop
	end

	mpChatboxScrollLastHeight = 0
	mpChatboxScrollToBottom = nil
	mpChatboxScrollTimeLast = 0
	mpChatEditOverlay = ""