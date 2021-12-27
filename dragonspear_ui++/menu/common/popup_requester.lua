selectedSlot = nil
itemRequestAmt = 0

function showItemAmountRequester(slotName)
	local slot = characters[id].equipment[slotName]
	if(slot.item.count == nil) then
		Infinity_Log("Nil count in requester!")
		return
	end
	if(slot.item.count > 1) then
		selectedSlot = slotName
		popupRequester(slot.item.count, inventorySplitStack, false)
	end
end
function inventorySplitStack(cnt)
	Infinity_SplitItemStack(characters[id].equipment[selectedSlot].id, cnt,'slot_inv_' .. characters[id].equipment[selectedSlot].id)
end

function GetAbilityIdentifyString()
	if(characters[id].equipment[selectedSlot].item.identified == 0) then
		return t("IDENTIFY_BUTTON")
	end

	if(characters[id].equipment[selectedSlot].abilityMode == 1) then
		return t("ABILITIES_BUTTON")
	end

	return ""
end
requester = {}
requester.requesterMax = 0
requester.requesterFunc = nil
requester.selling = false
itemRequestAmt = 0
requestAmt = 0
