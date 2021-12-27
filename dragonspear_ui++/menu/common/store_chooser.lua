	storePanelButtonHighlightGroup = nil
	function setStoreMainPanel(buttonId)
		local oldMenu  = storeScreen:GetMenuName(storeCurMenuId)
		Infinity_PopMenu(oldMenu)
		storeCurMenuId = storeScreen:GetPanelButtonPanelId(buttonId)
		Infinity_PushMenu(storeScreen:GetMenuName(storeCurMenuId))
	end
	function getBuySellTooltip()
		if(storeScreen:IsContainer()) then
			return t('TRANSFER_ITEMS_TOOLTIP')
		else
			return Infinity_FetchString(storeScreen:GetPanelButtonToolTip(0))
		end
	end