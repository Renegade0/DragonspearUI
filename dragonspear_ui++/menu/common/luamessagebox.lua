messageBoxCurMessage = nil
messageBoxMessages = {}
function initMessageBox(message)
	messageBoxMessages[message] = 1
	if(messageBoxCurMessage ~= nil) then
		--message box already active
		return
	end
	getNextMessage()
	Infinity_PushMenu('LuaMessageBox',0,0)
end

function getNextMessage()
	i = 1
	while ( i <= messageBoxMessageCount ) do
		showMessage = messageBoxMessages[i]
		if ( showMessage ~= nil ) then
			messageBoxCurMessage = i
			return 1
		end
		i = i + 1
	end
	--whole table scanned, all messages have been displayed
	return 0
end