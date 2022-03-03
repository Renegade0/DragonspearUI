store = {}
storeGroupItemsVar = 0
storeItemsVar = 0
function getStoreSlotHighlight(highlight)
	if(highlight == 0) then
		return 0
	else
		return 2
	end
end
function storeSplitStack(count)
	storeScreen:SelectStoreItem(storeItemsVar-1, true);
	storeScreen:SetStoreItemCount(storeItemsVar-1, count);
end
function groupSplitStack(count)
	storeScreen:SelectGroupItem(storeGroupItemsVar-1, true);
	storeScreen:SetGroupItemCount(storeGroupItemsVar-1, count);
end
function checkContainerText(normalStr, containerStr)
	if(storeScreen:IsContainer()) then
		return t(containerStr)
	else
		return t(normalStr)
	end
end
function canSteal()
	local nb = 0
	for _, v in pairs(store.storeItems) do
		if v.highlight == 1 then
			nb = nb + 1
		end
	end
	return nb > 0 and nb + #store.groupItems <= 16
end
function getStoreItemCount(row)
	local count = store.storeItems[rowNumber].item.count
	if(count ~= 0xFFFF)  then
		return count
	else
		-- maxword, infinite count.
		return nil
	end
end
StoreSearchString = ""
function StoreContainsSearchString(rowNumber)

	if(StoreSearchString == nil or StoreSearchString == "") then return 1 end --no search string, do nothing

	local text = store.storeItems[rowNumber].label
	if(string.find(string.lower(text),string.lower(StoreSearchString))) then
		return 1
	else
		return nil --does not contain search string
	end
end
GroupSearchString = ""
function GroupContainsSearchString(rowNumber)

	if(GroupSearchString == nil or GroupSearchString == "") then return 1 end --no search string, do nothing

	local text = store.groupItems[rowNumber].label
	if(string.find(string.lower(text),string.lower(GroupSearchString))) then
		return 1
	else
		return nil --does not contain search string
	end
end

function duiBuySellSelectAllHelper(items)
	local selected, unselected = {}, {}
	local indices = unselected

	for k, v in ipairs(items) do
		if v.valid == 1 then
			if v.highlight == 1 and indices == unselected then
				indices = selected
			end
			table.insert(indices, k - 1)
		end
	end

	return indices, indices == unselected
end