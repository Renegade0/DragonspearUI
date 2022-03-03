	function getSlotContainerId(index)
		local idxScrolled = index + worldScreen:GetTopGroundItem()
		if(loot.groundItems[idxScrolled] == nil) then
			return nil
		end
		return loot.groundItems[idxScrolled].containerId
	end
	function hideQuicklootSlot()
		if QuicklootENum == "Ten" then
			QLrows = 10
		elseif QuicklootENum == "Six" then
			QLrows = 6
		elseif QuicklootENum == "Five" then
			QLrows = 5
		elseif QuicklootENum == "Four" then
			QLrows = 4
		elseif QuicklootENum == "Three" then
			QLrows = 3
		elseif QuicklootENum == "Two" then
			QLrows = 2
		end
		QLcols = 60 / QLrows
		QLrows = QLrows - 1
		for j = 0,QLrows,1 do
			for i = QLcols,0,-1 do
				if not getSlotContainerId(j*QLcols + i) then
					Infinity_SetArea('quicklootSlot' .. (j*QLcols + i), (i*54)+76, (j*54)+5, 0, 0)
				elseif getSlotContainerId(j*QLcols + i) then
					Infinity_SetArea('quicklootSlot' .. (j*QLcols + i), (i*54)+76, (j*54)+5, 52, 52)
				end
			end
		end
		if worldScreen:GroundScrollEnabled(-6) or worldScreen:GroundScrollEnabled(6) then
			Infinity_SetArea('quicklootArrowL', 8, 5, 34, 53)
			Infinity_SetArea('quicklootArrowR', 42, 5, 34, 53)
		else
			Infinity_SetArea('quicklootArrowL', 8, 5, 0, 0)
			Infinity_SetArea('quicklootArrowR', 42, 5, 0, 0)
		end
	end

	function getGroundItemProperty(index, property)
		local idxScrolled = index + worldScreen:GetTopGroundItem()
		if(loot.groundItems[idxScrolled] == nil or loot.groundItems[idxScrolled].item == nil) then
			return nil
		end
		return loot.groundItems[idxScrolled].item[property]
	end

	function groundItemClick(slotId)
		local slot = loot.groundItems[slotId]
		if(slot and slot.item) then
			worldScreen:OnGroundButtonClick(slot.slotId, slot.containerId, slot.item.res)
		end
	end
	function groundItemClick2(slotId)
		local slot = loot.groundItems[slotId + worldScreen:GetTopGroundItem()]
		if(slot and slot.item) then
			worldScreen:OnGroundButtonClick(slot.slotId, slot.containerId, slot.item.res)
		end
	end
	function dragQLX(newX)
		--do a quick bounds check.
		local area = {Infinity_GetArea("QLhandle")}
		if(area[1] + newX) < 66 then
			newX = 66 - area[1]
		elseif (area[1] + newX) > 1577 then
			newX = 1577 - area[1]
		end

		adjustItemGroup({"QLeditboxbackground","QLeditbox","QLeditboxX"}, newX, 0, 0, 0)
		adjustItemGroup({"QLdisplaybackground"}, newX, 0, 0, 0)
		adjustItemGroup({"QLdisplayrows"}, newX, 0, 0, 0)
		adjustItemGroup({"QLhandle","QLhandleMid","QLhandleL","QLhandleR"}, newX, 0, 0, 0)
		adjustItemGroup({"QLreset"}, newX, 0, 0, 0)

	end

	function dragQLY(newY)
		--do a quick bounds check.

		local area = {Infinity_GetArea("QLdisplaybackground")}
		if(area[4] + newY <= -40) then newY = 0 - area[4] - 40 end

		area = {Infinity_GetArea("QLhandle")}
		local screenWidth, screenHeight = Infinity_GetScreenSize()
		if(area[2] + area[4] + newY > screenHeight - 120) then newY = screenHeight - area[2] - area[4] - 120 end

		adjustItemGroup({"QLeditboxbackground","QLeditbox","QLeditboxX"}, 0, newY, 0, 0)
		adjustItemGroup({"QLdisplaybackground"}, 0, 0, 0, newY)
		adjustItemGroup({"QLdisplayrows"}, 0, 0, 0, newY)
		adjustItemGroup({"QLhandle","QLhandleMid","QLhandleL","QLhandleR"}, 0, newY, 0, 0)
		adjustItemGroup({"QLreset"}, 0, newY, 0, 0)
	end

	function QLfilter(rowNumber)
		if(QLSearchString == nil or QLSearchString == "") then return 1 end --no search string, do nothing
		local QLtext = loot.groundItems[rowNumber].item['name']
		if(string.find(string.lower(QLtext),string.lower(QLSearchString))) then
			return 1 --does contain search string
		else
			return nil
		end
	end

	function PickUpItem()
		if selectedLootItem == #loot.groundItems + 1 then selectedLootItem = 0 end
		groundItemClick(selectedLootItem)
	end

	function repositionQuickloot()
		Infinity_SetArea('QLdisplaybackground', 0, 0, 328, -40)
		Infinity_SetArea('QLeditboxbackground', 0, -40, 328, 40)
		Infinity_SetArea('QLeditbox', 0, -40, 328, 40)
		Infinity_SetArea('QLeditboxX', 298, -40, 30, 40)
		Infinity_SetArea('QLdisplayrows', 4, 10, 318, -60)
		Infinity_SetArea('QLhandle', 66, 0, 195, 28)
		Infinity_SetArea('QLhandleL', 66, 0, 50, 28)
		Infinity_SetArea('QLhandleR', 211, 0, 50, 28)
		Infinity_SetArea('QLhandleMid', 116, 0, 95, 28)
		Infinity_SetArea('QLreset', 114, 0, -1, -1)
	end

	function getHeight()
		local area = {Infinity_GetArea("QLdisplaybackground")}
		if area[4] < 100 then
			return 1
		else
			return nil
		end
	end

	function showGroundItemDescription(slotId)
		local slot = loot.groundItems[slotId + worldScreen:GetTopGroundItem()]
			if(slot and slot.item) then
				Infinity_GetGroundItemDescription(slotId + worldScreen:GetTopGroundItem(), slot.slotId, slot.containerId)
				showItemDescription(slot.item, 2)
		end
	end