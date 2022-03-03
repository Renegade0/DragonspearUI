function getDonationFrame()
	if(store.hasDonated ~= nil and store.hasDonated == 1) then
		return 1
	else
		return 0
	end
end
storeDonateAmountEdit = 0 --no longer used in ui, but the engine needs it.
function changeDonationAmount(amount)
	if (amt == nil) then
		amt = 0
	end
	amt = amt + amount

	if (amt > 0) then
		storeDonateAmountEdit = tostring(amt)
	else
		storeDonateAmountEdit = '0'
	end
end