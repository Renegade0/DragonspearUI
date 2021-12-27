	loot =
	{
		containerItems = {},
		groupItems = {},
		groundItems = {}
	}
	function getContainerItemProperty(index, property)
		local idxScrolled = index + worldScreen:GetTopContainerItem()
		if(loot.containerItems[idxScrolled] == nil or loot.containerItems[idxScrolled].item == nil) then
			return nil
		end
		return loot.containerItems[idxScrolled].item[property]
	end
	function getGroupItemProperty(index, property)
		local idxScrolled = index + worldScreen:GetTopGroupItem()
		if(loot.groupItems[idxScrolled] == nil or loot.groupItems[idxScrolled].item == nil) then
			return nil
		end
		return loot.groupItems[idxScrolled].item[property]
	end
	function scrollContainerItems()
		if scrollDirection > 0 then
			if worldScreen:ContainerScrollEnabled(-1) then
				worldScreen:OnContainerScroll(-1)
			end
		elseif scrollDirection < 0 then
			if worldScreen:ContainerScrollEnabled(1) then
				worldScreen:OnContainerScroll(1)
			end
		end
	end
	function scrollGroupItems()
		if scrollDirection > 0 then
			if worldScreen:GroupScrollEnabled(-1) then
				worldScreen:OnGroupScroll(-1)
			end
		elseif scrollDirection < 0 then
			if worldScreen:GroupScrollEnabled(1) then
				worldScreen:OnGroupScroll(1)
			end
		end
	end
	function showContainerItemDescription(index)
		local idxScrolled = index + worldScreen:GetTopContainerItem()
		if(loot.containerItems[idxScrolled] == nil or loot.containerItems[idxScrolled].item == nil) then
			return nil
		end
		Infinity_GetContainerItemDescription(idxScrolled)
		showItemDescription(loot.containerItems[idxScrolled].item, 2)
	end
	function showGroupItemDescription(index)
		local idxScrolled = index + worldScreen:GetTopGroupItem()
		if(loot.groupItems[idxScrolled] == nil or loot.groupItems[idxScrolled].item == nil) then
			return nil
		end
		Infinity_GetGroupItemDescription(idxScrolled)
		showItemDescription(loot.groupItems[idxScrolled].item, 2)
	end