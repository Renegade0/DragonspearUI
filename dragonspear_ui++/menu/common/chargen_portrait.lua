CurrentImage = ""
CImage = ""
charactergender = ""
toggleSex = ""
toggleSort = 0
faNot = 0
fbNot = 0
tSort = ""

-- might be nil
BGImages = BGImages or {}

function getAvailablePortraits()
	local seen = {}

	while true do
		local portrait = createCharScreen:GetCurrentPortrait()
		local key = portrait:lower()
		if seen[key] then
			break
		end
		seen[key] = portrait
		createCharScreen:IncCurrentPortrait()
	end

	return seen
end

function PortraitContainsSearchString(rowNumber)

	if(PortraitSearchString == nil or PortraitSearchString == "") then return 1 end --no search string, do nothing

	local Portraittext = PortraitPicker[rowNumber][1]
	if fbNot == 1 then
		if(string.find(string.lower(Portraittext),string.lower(PortraitSearchString))) then
			return nil --does not contain search string
		else
			return 1
		end
	else
		if(string.find(string.lower(Portraittext),string.lower(PortraitSearchString))) then
			return 1
		else
			return nil --does not contain search string
		end
	end
end

function PortContainsSearchString(rowNumber)

	if(PortSearchString == nil or PortSearchString == "") then return 1 end --no search string, do nothing

	local Porttext = PortraitPicker[rowNumber][1]
	if faNot == 1 then
		if(string.find(string.lower(Porttext),string.lower(PortSearchString))) then
			return nil --does not contain search string
		else
			return 1
		end
	else
		if(string.find(string.lower(Porttext),string.lower(PortSearchString))) then
			return 1
		else
			return nil --does not contain search string
		end
	end
end

function SexFilter(rowNumber)
	if (toggleSex == nil or toggleSex == "") then return 1 end --no sex selected

	local Sex = PortraitPicker[rowNumber][2]
	if(string.find(string.lower(Sex),string.lower(toggleSex))) or (string.find(string.lower(Sex),string.lower('d'))) then
		return 1
	else
		return nil --does not contain search string
	end
end

function compare2(a,b)
	if toggleSort == 0 or toggleSort == 1 then
		UpdatePortraitPicker()
	elseif toggleSort == 2 then
		tSort = PPStrings.PP_SORTAZ
		return string.lower(a[1]) < string.lower(b[1])
	elseif toggleSort == 3 then
		tSort = PPStrings.PP_SORTZA
		return string.lower(a[1]) > string.lower(b[1])
	end
end

function UpdatePortraitPicker()
	PortraitPicker = {}
	if toggleSort == 0 then
		Addportraits()
		AddBGImages()
		tSort = PPStrings.PP_SORTDC
	elseif toggleSort == 1 then
		AddBGImages()
		Addportraits()
		tSort = PPStrings.PP_SORTCD
	end
end

function AddBGImages()
	for i=1,#BGImages,1 do
		local name = BGImages[i][1]
		local fname = BGImages[i][3]:lower()
		if BGImages[i][2] == 'F' then
			BGgender = 'F'
		elseif BGImages[i][2] == 'M' then
			BGgender = 'M'
		elseif BGImages[i][2] == 'D' then
			BGgender = 'D'
		end

		if duiAvailablePortraits[fname] then
			table.insert(PortraitPicker, {name, BGgender, fname})
		end
	end
end

function Addportraits()
	for i=1,#portraits,1 do
		local name = portraits[i][1]
		local fname = name .. 'L'
		if nicks[name] ~= nil then
			name = nicks[name]
		end
		if portraits[i][2] == 2 then
			BGgender = 'F'
		elseif portraits[i][2] == 1 then
			BGgender = 'M'
		end

		if duiAvailablePortraits[fname:lower()] then
			table.insert(PortraitPicker, {name, BGgender, fname})
		end
	end
end

function GetMediumPortrait()
	HasMediumPortrait = ""
	if (PortraitPicker[CImage][3]) == "" or (PortraitPicker[CImage][3]) == nil then
		HasMediumPortrait = ""
	end

	if string.sub(PortraitPicker[CImage][3],-1) == "l" then
		HasMediumPortrait = string.sub(PortraitPicker[CImage][3], 1, (string.len(PortraitPicker[CImage][3])-1)) .. 'm'
	end

end

function getPortraitBackground(row)
	if(row == CImage) then
		return "RGCPBUT"
	else
		return "RGCPBUT1"
	end
end

portraitArray = {}

function ZeroToggleArray()
	togglePort1 = 0
	togglePort2 = 0
	togglePort3 = 0
	togglePort4 = 0
	togglePort5 = 0
	togglePort6 = 0
	togglePort7 = 0
	togglePort8 = 0
	togglePort9 = 0
	togglePort10 = 0
	togglePort11 = 0
	togglePort12 = 0
	togglePort13 = 0
	togglePort14 = 0
	togglePort15 = 0
	togglePort16 = 0
	togglePort17 = 0
	togglePort18 = 0
	togglePort19 = 0
	togglePort20 = 0
	togglePort21 = 0
	togglePort22 = 0
	togglePort23 = 0
	togglePort24 = 0
	togglePort25 = 0
	togglePort26 = 0
	togglePort27 = 0
	togglePort28 = 0
end

function togglePortrait1()
	tempTog = togglePort1
	ZeroToggleArray()
	togglePort1 = tempTog
end

function togglePortrait2()
	tempTog = togglePort2
	ZeroToggleArray()
	togglePort2 = tempTog
end

function togglePortrait3()
	tempTog = togglePort3
	ZeroToggleArray()
	togglePort3 = tempTog
end

function togglePortrait4()
	tempTog = togglePort4
	ZeroToggleArray()
	togglePort4 = tempTog
end

function togglePortrait5()
	tempTog = togglePort5
	ZeroToggleArray()
	togglePort5 = tempTog
end

function togglePortrait6()
	tempTog = togglePort6
	ZeroToggleArray()
	togglePort6 = tempTog
end

function togglePortrait7()
	tempTog = togglePort7
	ZeroToggleArray()
	togglePort7 = tempTog
end

function togglePortrait8()
	tempTog = togglePort8
	ZeroToggleArray()
	togglePort8 = tempTog
end

function togglePortrait9()
	tempTog = togglePort9
	ZeroToggleArray()
	togglePort9 = tempTog
end

function togglePortrait10()
	tempTog = togglePort10
	ZeroToggleArray()
	togglePort10 = tempTog
end

function togglePortrait11()  tempTog = togglePort11 ZeroToggleArray() togglePort11 = tempTog end
function togglePortrait12()  tempTog = togglePort12 ZeroToggleArray() togglePort12 = tempTog end
function togglePortrait13()  tempTog = togglePort13 ZeroToggleArray() togglePort13 = tempTog end
function togglePortrait14()  tempTog = togglePort14 ZeroToggleArray() togglePort14 = tempTog end
function togglePortrait15()  tempTog = togglePort15 ZeroToggleArray() togglePort15 = tempTog end
function togglePortrait16()  tempTog = togglePort16 ZeroToggleArray() togglePort16 = tempTog end
function togglePortrait17()  tempTog = togglePort17 ZeroToggleArray() togglePort17 = tempTog end
function togglePortrait18()  tempTog = togglePort18 ZeroToggleArray() togglePort18 = tempTog end
function togglePortrait19()  tempTog = togglePort19 ZeroToggleArray() togglePort19 = tempTog end
function togglePortrait20()  tempTog = togglePort20 ZeroToggleArray() togglePort20 = tempTog end
function togglePortrait21()  tempTog = togglePort21 ZeroToggleArray() togglePort21 = tempTog end
function togglePortrait22()  tempTog = togglePort22 ZeroToggleArray() togglePort22 = tempTog end
function togglePortrait23()  tempTog = togglePort23 ZeroToggleArray() togglePort23 = tempTog end
function togglePortrait24()  tempTog = togglePort24 ZeroToggleArray() togglePort24 = tempTog end
function togglePortrait25()  tempTog = togglePort25 ZeroToggleArray() togglePort25 = tempTog end
function togglePortrait26()  tempTog = togglePort26 ZeroToggleArray() togglePort26 = tempTog end
function togglePortrait27()  tempTog = togglePort27 ZeroToggleArray() togglePort27 = tempTog end
function togglePortrait28()  tempTog = togglePort28 ZeroToggleArray() togglePort28 = tempTog end

function OnPortraitArrayClick(thisOne)
	if portraitChoice == thisOne then
		portraitChoice = -1
	else
		portraitChoice = thisOne
	end
end

function IncPortraitArray()
	for index = 1, 28, 1 do
		portraitArray[index] = createCharScreen:GetCurrentPortrait()
		createCharScreen:IncCurrentPortrait()
	end
	ZeroToggleArray()
	portraitChoice = -1
end

function DecPortraitArray()
	for index = 1, 56, 1 do
		createCharScreen:DecCurrentPortrait()
	end
	IncPortraitArray()
	ZeroToggleArray()
	portraitChoice = -1
end

function GetPortrait(portraitIndex)
	return portraitArray[portraitIndex]
end

function ChoosePortrait()
	if portraitChoice == -1 then
		Infinity_PopMenu()
		createCharScreen:OnCancelButtonClick()
	else
		for index = 29, portraitChoice+1, -1 do
			createCharScreen:DecCurrentPortrait()
		end
	end
end

function IsPortraitChosen()
	if portraitChoice == -1 then
		return 0
	else
		return 1
	end
end
