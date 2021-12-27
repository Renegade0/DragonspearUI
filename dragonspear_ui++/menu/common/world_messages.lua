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

		toolbarTop = toolbarTop - newY
		Infinity_SetOffset('WORLD_QUICKLOOT',0, -toolbarTop)

		chatboxScrollToBottom = 1
		worldMessageBoxTop = y + newY
end

