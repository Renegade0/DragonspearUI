currentHLASelection = nil
function chargenHLADescription()
	if currentHLASelection == nil then
		return 63817
	else
		return chargen.HLAs[currentHLASelection].description
	end
end
function chargenHLAPlusMinusFrame(cell, rownumber)
	if cell == 3 then
		if chargen.HLAs[rownumber].canAdd then
			return currentCellCheck(cell)
		else
			return 3
		end
	elseif cell == 4 then
		if chargen.HLAs[rownumber].canSubtract then
			return currentCellCheck(cell)
		else
			return 3
		end
	end
end