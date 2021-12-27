function getDLCDescription()
	return Infinity_FetchString(dlcScreen:GetDLCDescription())
end
function getDLCTitle()
	return Infinity_FetchString(dlcScreen:GetDLCTitle())
end
function getDLCIndex()
	return dlcScreen:GetDLCIndex() .. "/" .. dlcScreen:GetDLCCount()
end
function isDLCBuyButtonClickable()
	local isBought = dlcScreen:GetDLCBought()
	return isBought == false
end

function setDLCPurchased(index, purchaseLevel)
	purchasedDLC[index] = purchaseLevel;
end