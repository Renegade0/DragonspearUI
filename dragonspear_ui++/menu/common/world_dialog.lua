	worldNPCDialogText = ""
	worldPlayerDialogChoices = {}
	glowTest = nil
	startingDialogHeight = 0
	previousTop = nil
	scrolled = false
	scrollToBottom = false

	function dialogScroll(top, height, contentHeight)
		if scrolled then
			if scrollToBottom and contentHeight > height then
				scrollToBottom = false
				return height - contentHeight
			end
			return nil
		end
		if previousTop ~= nil and top ~= previousTop then
			scrolled = true
			scrollToBottom = true
			return -1
		end
		previousTop = -1
		return -1
	end

	function mergeDialog(t)
		local dialog = {}
		for key, value in pairs(t) do
			dialog[key] = value
		end
		table.insert(dialog, 1, '')
		table.insert(dialog, 1, '')
		return dialog
	end

-- Drag Message History on Y-axis
	function dragMessagesBoxHistoryY(newY)
		setMessageBoxHistoryY(newY)
		worldMessageBoxClickedOnce = 1
	end

	function clampMessageBoxHistoryHeight(hNew, hOld)
			if(hNew <= 200) then
				--lower bound on height, sliced rects can't get too small and we don't want to make the message box invisible.
				return hOld - 200
			end
			if(hNew >= 500) then
				--also don't go too high because it looks bad.
				return hOld - 500
			end
			return hOld - hNew
	end

	function setMessageBoxHistoryY(newY)
			local x,y,w,hOld = Infinity_GetArea('worldMessageBoxHistoryBackground')
			h = hOld - newY
			newY = clampMessageBoxHistoryHeight(h,hOld)

			adjustItemGroup({"worldMessageBoxHistoryHandle"},0,newY,0,0)
			adjustItemGroup({"worldMessageBoxHistoryBackground","worldMessageBoxHistory"},0,newY,0,-newY)

			chatboxScrollToBottom = 1
	end

-- Drag Dialog on X axis
	function dragDialogX(newX)
		--do a quick bounds check.
		local screenWidth, screenHeight = Infinity_GetScreenSize()
		local area = {Infinity_GetArea("worldDialogBackground")}
		if(area[1] + newX) < 125 and worldNPCDialogPortrait ~= 'NONE' then
			Infinity_SetArea('worldDialogPortraitArea', area[1]+496, nil, nil, nil)
			PortPosition = 'Left'
		elseif (area[1] + newX) > screenWidth - 694 and worldNPCDialogPortrait ~= 'NONE' then
			Infinity_SetArea('worldDialogPortraitArea', area[1]-100, nil, nil, nil)
			PortPosition = 'Right'
		end

		if(area[1] + newX) < 0 then
			newX = 0 - area[1]
		elseif (area[1] + newX) > screenWidth - 569 then
			newX = screenWidth - 569 - area[1]
		end
		adjustItemGroup({"worldDialogBackground","worldDialogHandle","worldDialogHandleDrag","worldDialogPortraitArea","worldNPCDialog","worldPlayerDialogChoicesList","worldDialogConfirm","worldDialogPortraitBackgroundL","worldDialogPortraitBackgroundR","worldDialogButton1","worldDialogButton2","worldDialogButton3"}, newX, 0, 0, 0)
	end

-- NOT SURE but I left this just in case
	function dialogEntryGreyed()
		return not worldScreen:GetInControlOfDialog()
	end

-- Toggle MessageHistory
	function toggleDialogShowMessages()
		if(showWorldMessages == 1) then showWorldMessages = 0 else showWorldMessages = 1 end
	end

-- Sets the the desired dialog background area
	function getDesiredDialogHeight()

		--get npc area
		local npcX,npcY,npcW,npcH = Infinity_GetArea('worldNPCDialog')

		--get dialog choices height
		local choicesHeight = Infinity_GetListHeight('worldPlayerDialogChoicesList')

		-- set the area to npcDialog + choicesHeight + 100 (60,npcDialog,10,choices,30)
		if (choicesHeight + npcH + 100) < 300 then
			return 300
		else
			return (choicesHeight + npcH + 100)
		end
	end

-- Retrieves the current dialog background area

	function resizeDialog()
		buildResponsesList()

	if ( ClassicDialog == 1) then
	previousTop = nil
	scrolled = false
	else
		--fit the npc text area to the text height.
		Infinity_ScaleToText("worldNPCDialog")

		--Get available height to work in
		local desiredHeight = getDesiredDialogHeight()
		desiredHeight = desiredHeight + 30
		--get areas
		local npcX,npcY,npcW,npcH = Infinity_GetArea('worldNPCDialog')
		local choicesHeight = Infinity_GetListHeight('worldPlayerDialogChoicesList')
		choicesHeight = choicesHeight + 40
		local x,y,w,h = Infinity_GetArea('worldDialogBackground')
		local WDHx,WDHy,WDHw,WDHh = Infinity_GetArea('worldDialogHandleDrag')
		local xL,yL,wL,hL = Infinity_GetArea('worldDialogPortraitBackgroundL')
		local xR,yR,wR,hR = Infinity_GetArea('worldDialogPortraitBackgroundR')
		local x2,y2,w2,h2 = Infinity_GetArea('worldDialogPortraitArea')
		local WDB1x,WDB1y,WDB1w,WDB1h = Infinity_GetArea('worldDialogButton1')
		local WDB2x,WDB2y,WDB2w,WDB2h = Infinity_GetArea('worldDialogButton2')
		local WDB3x,WDB3y,WDB3w,WDB3h = Infinity_GetArea('worldDialogButton3')
		local screenWidth,screenHeight = Infinity_GetScreenSize()

		-- assume screenHeight >= 129, i.e. maxHeight >= 3
		local maxHeight = math.floor(screenHeight * 8 / 10) - 100
		if choicesHeight + npcH > maxHeight then
			if maxHeight < npcH then
				choicesHeight = math.min(50, choicesHeight - 40, math.floor(maxHeight / 3))
				npcH = maxHeight - choicesHeight
			else
				choicesHeight = maxHeight - npcH
			end
			desiredHeight = choicesHeight + 100 + npcH
		end

		if x > screenWidth - w - 69 then
			newX = screenWidth - w - 69
			WDHx = newX + 153
			npcX = newX + 30
			if newX < 0 then
				xR = newX + 488
				x2 = newX + 496
				PortPosition = 'Right'
			elseif newX > screenWidth - 197 - w then
				xL = newX - 112
				x2 = newX - 100
				PortPosition = 'Left'
			end
		end

		-- reposition all elements
		Infinity_SetArea('worldDialogBackground', newX, y, w, desiredHeight)
		Infinity_SetArea(('worldNPCDialog'), npcX,npcY,npcW,npcH)
		Infinity_SetArea(('worldDialogButton1'), newX, nil, nil, nil)
		Infinity_SetArea(('worldDialogButton2'), newX, nil, nil, nil)
		Infinity_SetArea(('worldDialogButton3'), newX, nil, nil, nil)
		Infinity_SetArea(('worldPlayerDialogChoicesList'), npcX,npcY+npcH+10,npcW,choicesHeight)

		Infinity_SetArea(('worldDialogConfirm'), WDHx+103, desiredHeight+2, nil, nil)
		Infinity_SetArea(('worldDialogHandle'), WDHx, desiredHeight-33, nil, nil)
		Infinity_SetArea(('worldDialogHandleDrag'), WDHx, 0, nil, nil)

		Infinity_SetArea(('worldDialogPortraitArea'), x2, nil, nil, nil)
		Infinity_SetArea(('worldDialogPortraitBackgroundR'), xR, nil, nil, nil)
		Infinity_SetArea(('worldDialogPortraitBackgroundL'), xL, nil, nil, nil)
	end
	end


	function getDialogButtonEnabled()
		if(gameOptions.m_bConfirmDialog == true) then
			return true
		else
			return (#worldPlayerDialogChoices == 0)
		end
	end

	function getDialogButtonClickable()
		local ret = worldScreen:GetInControlOfDialog()
		if(gameOptions.m_bConfirmDialog == true) then
			return ret and ((#worldPlayerDialogChoices == 0) or (worldPlayerDialogSelection and worldPlayerDialogSelection > 0)) --no choices, or we've selected a choice.
		else
			return ret
		end
	end

	function getDialogEntryText(row)
		if (ClassicDialog == 1) then
			row = row - 2
		end
	local text = worldPlayerDialogChoices[row].text
		if (ClassicDialog == 1) then
			row = row + 2
		end
		if (row == worldPlayerDialogSelection) then
			--Color the text white when selected
			text = string.gsub(text, "%^0xff212eff", "^0xFFFFFFFF")
		end
		return text
	end

-- World Messages Box Drag
	worldMessageBoxText = ""
	worldMessageBoxLines = 0
	worldMessageBoxClickedOnce = 0
	function dragMessagesY(newY)
		setMessagesY(newY)
		worldMessageBoxClickedOnce = 1
	end
	function clampMessageBoxHeight(hNew, hOld)
			if(hNew <= 64) then
				--lower bound on height, sliced rects can't get too small and we don't want to make the message box invisible.
				return hOld - 64
			end
			if(hNew >= 500) then
				--also don't go too high because it looks bad.
				return hOld - 500
			end
			return hOld - hNew
	end
	function setMessagesY(newY)
		local x,y,w,hOld = Infinity_GetArea('messagesRect')
		h = hOld - newY
		newY = clampMessageBoxHeight(h,hOld)

		adjustItemGroup({"messagesHandleY"},0,newY,0,0)
		adjustItemGroup({"messagesRect","worldMessageBox"},0,newY,0,-newY)

		chatboxScrollToBottom = 1
		worldMessageBoxTop = y + newY
	end

	PortPosition = "Left"

	function AddNewNote(text)
		if alreadyAdded == 0 then
			RevertJournal = 0
			if JournalSize == UIStrings.UI_Large then
				RevertJournal = 1
				JournalSize = UIStrings.UI_Small
			end
			e:GetActiveEngine():OnLeftPanelButtonClick(2)
			journalMode = const.JOURNAL_MODE_EDIT
			text = string.gsub(text, "%^0x........", "")
			text = string.gsub(text, '%\n', '\n"') .. '"'
			journalNoteEdit =  text
			journalNoteEditRef = nil
			journalNoteEdit = JFStrings.JF_Notes .. '\n' .. journalNoteEdit .. '\n - ' .. Infinity_GetTimeString()
			Infinity_OnAddUserEntry(journalNoteEdit)
			journalMode = const.JOURNAL_MODE_JOURNAL
			e:GetActiveEngine():OnLeftPanelButtonClick(2)
			if RevertJournal == 1 then
				RevertJournal = 0
				JournalSize = UIStrings.UI_Large
			end
			alreadyAdded = 1
		end
	end
	function SetPosition()
		local x,y,w,h = Infinity_GetArea('worldDialogBackground')
		local screenWidth, screenHeight = Infinity_GetScreenSize()
		if x < (screenWidth/2 - w/2) then
			x = screenWidth/2 - w/2
			PortPosition = 'Right'
			Infinity_SetArea(('worldDialogPortraitArea'), x-100, nil, nil, nil)
		elseif x < screenWidth - w - 69 then
			x = screenWidth - w - 69
			PortPosition = 'Right'
			Infinity_SetArea(('worldDialogPortraitArea'), x-100, nil, nil, nil)
		elseif x == screenWidth - w - 69 then
			x = 0
			PortPosition = 'Left'
			Infinity_SetArea(('worldDialogPortraitArea'), x+496, nil, nil, nil)
		end

		SetPositionX(x)
	end

	function SetPositionX(x)
		Infinity_SetArea('worldDialogBackground',x,nil,nil,nil)
		Infinity_SetArea(('worldNPCDialog'), x+30,nil,nil,nil)
		Infinity_SetArea(('worldDialogButton1'), x+340,nil,nil,nil)
		Infinity_SetArea(('worldDialogButton2'), x+380,nil,nil,nil)
		Infinity_SetArea(('worldDialogButton3'), x+420,nil,nil,nil)
		Infinity_SetArea(('worldPlayerDialogChoicesList'), x+30,nil,nil,nil)

		Infinity_SetArea(('worldDialogConfirm'), x+103,nil,nil,nil)
		Infinity_SetArea(('worldDialogHandle'), x,nil,nil,nil)
		Infinity_SetArea(('worldDialogHandleDrag'), x,nil,nil,nil)

		Infinity_SetArea(('worldDialogPortraitBackgroundR'), x+488, nil, nil, nil)
		Infinity_SetArea(('worldDialogPortraitBackgroundL'), x-112, nil, nil, nil)
	end

	function SetBottomPosition()
		local screenWidth, screenHeight = Infinity_GetScreenSize()

		Infinity_SetArea(('worldDialogBackgroundBottom'),(screenWidth/2)-432,screenHeight-353,nil,nil)
		Infinity_SetArea(('worldDialogBackgroundBottom1'),(screenWidth/2)-432,screenHeight-83,nil,nil)
		Infinity_SetArea(('worldDialogPortraitAreaBottom'), (screenWidth/2)-533,screenHeight-283,nil,nil)
		Infinity_SetArea(('worldDialogPortraitBackgroundBottom'), (screenWidth/2)-544,screenHeight-303,nil,nil)
		Infinity_SetArea(('worldPlayerDialogChoicesListBottom'), (screenWidth/2)-394,screenHeight-324,nil,nil)
	end

	WorldDialog = {
		restored = false
	}

	function WorldDialog:save()
		if ClassicDialog == 1 then
			return
		end

		local x, y, w, h = Infinity_GetArea('worldDialogBackground')
		Infinity_SetINIValue('WorldDialog', 'Position', x)
		Infinity_SetINIValue('WorldDialog', 'PortPosition', PortPosition)
	end

	function WorldDialog:restore()
		-- only try to restore the first time and for enhanced dialog
		if ClassicDialog == 1 or self.restored then
			return
		end
		self.restored = true

		-- get values from config
		local x = tonumber(Infinity_GetINIString('WorldDialog', 'Position', ''))
		local portPosition = Infinity_GetINIString('WorldDialog', 'PortPosition', '')
		if x == nil or not (portPosition == 'Left' or portPosition == 'Right') then
			return
		end

		-- TODO swap Left and Right
		-- TODO: make worldNPCDialogPortrait either nil or valid string
		-- window might have been resized, make sure we don't overflow

		local wd = select(3, Infinity_GetArea('worldDialogBackground'))
		local wp = select(3, Infinity_GetArea('worldDialogPortraitArea'))
		local portrait = portPosition == 'Left' and worldNPCDialogPortrait or ''
		if portrait == '' or portrait == 'NONE' then
			wp = 0
		end

		-- margin + dialog + dialog portrait + portraits panel
		local w = 5 + wd + wp + (LargePortraits == 1 and 86 or 68)
		x = math.min(x, math.max(0, Infinity_GetScreenSize() - w))

		-- everything is okay, finally set the variables
		if portPosition == 'Left' then
			Infinity_SetArea('worldDialogPortraitArea', x + 496, nil, nil, nil)
		else
			Infinity_SetArea('worldDialogPortraitArea', x - 100, nil, nil, nil)
		end

		SetPositionX(x)
		PortPosition = portPosition
	end
