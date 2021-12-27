function showItemDescriptionInventory(slotName)
	if(characters[id].equipment[slotName].empty ~= 0) then
		return
	end

	selectedSlot = slotName

	Infinity_CheckItemIdentify(characters[id].equipment[slotName].id)
	showItemDescription(characters[id].equipment[slotName].item, 0)
end

itemDesc = {}
function showItemDescription(item, mode)
	itemDesc.item = item
	itemDesc.mode = mode
	Infinity_PushMenu('ITEM_DESCRIPTION',0,0)
end

function itemDescLeftButtonEnabled()
	if(itemDesc.mode == 0) then
		return GetAbilityIdentifyString() ~= ""
	elseif(itemDesc.mode == 1) then
		return itemDesc.item.isBag
	end
	return 0
end
function itemDescLeftButtonText()
	if(itemDesc.mode == 0) then
		return GetAbilityIdentifyString()
	elseif(itemDesc.mode == 1) then
		return t('OPEN_CONTAINER_BUTTON')
	end
	return ""
end
function itemDescLeftButtonAction()
	if(itemDesc.mode == 0) then
		if(characters[id].equipment[selectedSlot].item.identified == 0) then
			Infinity_PushMenu('ITEM_IDENTIFY',0,0)
		else
			Infinity_PushMenu('ITEM_ABILITIES',0,0)
		end
	elseif(itemDesc.mode == 1) then
		storeScreen:OpenBag(itemDesc.item.res)
		Infinity_PopMenu()
	end
end

function itemDescRightButtonEnabled()
	if(itemDesc.mode == 0) then
		return characters[id].equipment[selectedSlot].useMode ~= -1
	else
		return 0
	end
end
function itemDescRightButtonText()
	return Infinity_GetUseButtonText(characters[id].equipment[selectedSlot].id, characters[id].equipment[selectedSlot].useMode)
end
function itemDescRightButtonAction()
	Infinity_PopMenu()
	Infinity_OnUseButtonClick(characters[id].equipment[selectedSlot].id, characters[id].equipment[selectedSlot].useMode)
end