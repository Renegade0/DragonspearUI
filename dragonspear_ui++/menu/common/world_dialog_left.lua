	dialogTable = {}
	dialogOverflowTable = {}
	hasDialogResponse = nil

	chatboxScrollToBottom = nil
	chatboxScrollTimeLast = 0
	chatboxContentHeight = 0
	chatboxOverflowed = nil
	chatboxJumpToBottom = nil

	-- The following two values determine how many item entries can exist.  We trim
	-- the number of entries to numDialogTrimEntries once it has overflowed that value
	-- by numDialogOverflowLimit.
	numDialogTrimEntries = 512
	numDialogOverflowEntries = numDialogTrimEntries + 128

	lastTrimmedContentHeight = 0

	function getNumDialogTableEntries()
		local count = 0
		for _ in pairs(dialogTable) do count = count + 1 end
		return count
	end

	function trimDialogTableSize()
		local  numTableEntries = getNumDialogTableEntries()
		if (numTableEntries > numDialogOverflowEntries) then
			local numEntriesToRemove = numTableEntries - numDialogTrimEntries
			while (numEntriesToRemove > 0) do
				-- Get our table entry and calculate its size
				local tableEntry = dialogTable[1]
				local delta = Infinity_GetContentHeight(styles.normal.font, w, tableEntry.text, styles.normal.point, 1, styles.normal.useFontZoom) --1 for indent.
				chatboxContentHeight = chatboxContentHeight - delta
				lastTrimmedContentHeight = lastTrimmedContentHeight + delta

				table.remove(dialogTable, 1)
				numEntriesToRemove = numEntriesToRemove - 1
			end
		end
	end

	function buildResponsesList()

		hasDialogResponse = nil
		dialogResponses = {}
		for k,v in pairs(worldPlayerDialogChoices) do
			if v.marker then
				table.insert(dialogResponses, v)
				hasDialogResponse = 1
			end
		end
	end
	function canShowDialogButton(num)
		-- Show the buttons if we have a response, and the dialog button is not enabled
		return dialogResponses and dialogResponses[num] ~= nil and showDialogButtonChoices()
	end

	function addDialogMessage(text,marker,makeTop)
		local tab = {}
		tab.text = text
		tab.marker = marker
		if(marker) then
			dialogViewMode = nil
			if(text == "") then
				--empty markers are a signal, we shouldn't actually display them.
				if(makeTop == true) then
					--we'll ensure the next line is included in the visible content.
					chatboxContentHeight = 0
				end
				return
			else
				hasDialogResponse = 1
			end
		end

		--Calculate running total of dialog content height
		local x,y,w,h = Infinity_GetArea("worldPlayerDialogChoicesList")
		w = w - 18 --account for scrollbar influence on width
		local delta = Infinity_GetContentHeight(styles.normal.font, w, text, styles.normal.point, 1, styles.normal.useFontZoom) --1 for indent.
		chatboxContentHeight = chatboxContentHeight + delta

		if(marker and chatboxContentHeight > h) then
			--More to display than we have room for, put the responses in overflow and hide them behind button
			table.insert(dialogOverflowTable,tab)
		else
			table.insert(dialogTable,tab)
		end

		if(makeTop == true) then
			--we'll ensure the next line is included in the visible content.
			chatboxContentHeight = 0
		end

		trimDialogTableSize()

		triggerChatboxScroll()

		buildResponsesList()
	end
	function clearDialogResponses()
		for k,v in pairs(dialogTable) do
			if(v.marker) then
				table.remove(dialogTable,k)
				clearDialogResponses()
			end
		end
		hasDialogResponse = nil
		chatboxOverflowed = nil
		chatboxContentHeight = 0
		dialogOverflowTable = {}
	end
	function dialogEntrySelectable(row)
		return (dialogTable[row].marker ~= nil)
	end
	function showDialogButtonChoices()
		return not (not hasDialogResponse or dialogViewMode or #dialogOverflowTable > 0)
	end
	function getResponsePickable()
		return not hasDialogResponse or dialogViewMode or (gameOptions.m_bConfirmDialog == true)
	end
	function getDialogButtonText()
		if(dialogViewMode) then
			return t("DONE_BUTTON")
		end

		if(#dialogOverflowTable > 0) then
			return t("SHOW_MORE_RESPONSES_BUTTON")
		end

		if(gameOptions.m_bConfirmDialog == true) then
			return t("CHOOSE_RESPONSE_BUTTON")
		end

		return dialogButtonText
	end
	function triggerChatboxScroll()
		chatboxScrollToBottom = 1
		chatboxScrollTimeLast = Infinity_GetClockTicks()
	end
	function chatboxScroll(top, height, contentHeight)
		if(chatboxJumpToBottom and contentHeight > height) then
			chatboxJumpToBottom = nil
			return height-contentHeight
		end
		if(chatboxScrollToBottom == 0) then
			--defer to default scrolling
			return nil
		end
		if(contentHeight < height) then
			--no scrolling required, content fits
			chatboxScrollToBottom = nil
			return nil
		end
		local dT = Infinity_GetClockTicks() - chatboxScrollTimeLast
		chatboxScrollTimeLast = Infinity_GetClockTicks()
		top = top + lastTrimmedContentHeight
		lastTrimmedContentHeight = 0
		local newTop = (dT * -0.25) + top
		if (newTop + contentHeight > height + 200) then
			return (height - contentHeight + 200)
		end
		if(newTop + contentHeight < height) then
			chatboxScrollToBottom = 0
			return height - contentHeight
		end
		return newTop
	end
	function displayOverflowResponses()
		for k,v in pairs(dialogOverflowTable) do
			table.insert(dialogTable,v)
		end
		dialogOverflowTable = {}
		triggerChatboxScroll()
		buildResponsesList()
	end
	function GetFirstMarkedResponse()
		for k,v in pairs(dialogTable) do
			if v.marker ~= nil then
				return k
			end
		end
		return -1
	end
	function onDialogButtonClick()
		if(dialogViewMode) then
			--In dialog view mode this button closes the menu.
			worldScreen:StopDialogHistory()
			return
		end

		if(#dialogOverflowTable > 0) then
			displayOverflowResponses()
			return
		end

		if(gameOptions.m_bConfirmDialog == true and hasDialogResponse) then
			-- if confirm dialog and choices available.
			worldScreen:OnDialogReplyClick(dialogTable[worldPlayerDialogSelection].marker)
			worldPlayerDialogSelection = 0
			return
		else
			-- no choices, just step.
			worldScreen:StepDialog()
		end
	end
	function getDialogRowClickable(row)
		return dialogTable[row].marker ~= nil
	end
	function isTouchActionbar()
		--Make this read from an option to make it easy to switch out.
		local default = 0
		if(e:IsTouchUI()) then default = 1 end
		local val = Infinity_GetINIValue('Program Options', 'Use Touch Actionbar', default)
		if (val ~= 0) then
			return 1
		else
			return nil
		end
	end
