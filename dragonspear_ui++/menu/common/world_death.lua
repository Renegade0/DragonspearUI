	function worldDeathLoadClickable()
		if(e:IsMultiplayer() and not e:IsHosting()) then
			return false
		end
		return not worldScreen:GetHardPaused()
	end
	function worldDeathQuitClickable()
		return not worldScreen:GetHardPaused()
	end
	function worldDeathText()
		if(e:IsMultiplayer()) then
			if(e:IsHosting()) then
				return Infinity_FetchString(19377)
			else
				return Infinity_FetchString(11331)
			end
		else
			if(worldDeathStr == nil) then
				return Infinity_FetchString(16498)
			else
				return Infinity_FetchString(worldDeathStr)
			end
		end
	end
	function worldDeathQuitText()
		if(e:IsMultiplayer()) then
			return t('LOGOUT_BUTTON')
		else
			return t('QUIT_BUTTON')
		end
	end

	highlightButtonToggle = 0 -- TODO: review, added by SOD v2.5
	worldChatEdit = ""