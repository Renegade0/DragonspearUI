currentSave = 0
function getSaveBackground(row)
	if(row == currentSave) then
		return "RGSAVEB"
	else
		return "RGSAVEA"
	end
end

function getLoadArea()
	local screenWidth, screenHeight = Infinity_GetScreenSize()
	if screenWidth <= 1372 and LeftSideMenu == 0 then
	Infinity_SetArea('SaveArea', 0, 0, screenWidth-444, screenHeight)
	Infinity_SetArea('SaveAreaPanel', -50, 0, screenWidth-394, 2160)
	elseif screenWidth > 1372 and screenWidth <= 1552 and LeftSideMenu == 0 then
	Infinity_SetArea('SaveArea', 0, 0, 928, screenHeight)
	Infinity_SetArea('SaveAreaPanel', -42, 0, 1012, 2160)
	elseif screenWidth > 1552 and LeftSideMenu == 0 then
	Infinity_SetArea('SaveArea', screenWidth-1552, 0, 928, screenHeight)
	Infinity_SetArea('SaveAreaPanel', screenWidth-1594, 0, 1012, 2160)

	elseif screenWidth <= 1372 and LeftSideMenu == 1 then
	Infinity_SetArea('SaveArea', 444, 0, screenWidth-444, screenHeight)
	Infinity_SetArea('SaveAreaPanel', 444, 0, screenWidth-444, 2160)
	elseif screenWidth > 1372 and screenWidth <= 1552 and LeftSideMenu == 1 then
	Infinity_SetArea('SaveArea', 444, 0, 928, screenHeight)
	Infinity_SetArea('SaveAreaPanel', 444, 0, 1012, 2160)
	elseif screenWidth > 1552 and LeftSideMenu == 1 then
	Infinity_SetArea('SaveArea', 624, 0, 928, screenHeight)
	Infinity_SetArea('SaveAreaPanel', 582, 0, 1012, 2160)
	end
	if LeftSideMenu == 1 then
	Infinity_SetArea('LoadPanel', 76, nil, nil, nil)
	Infinity_SetArea('LoadTitle1', 33, nil, nil, nil)
	Infinity_SetArea('LoadTitle2', 16, nil, nil, nil)
	Infinity_SetArea('LoadTitle3', 18, nil, nil, nil)
	Infinity_SetArea('LoadButton1', 135, nil, nil, nil)
	Infinity_SetArea('LoadButton2', 135, nil, nil, nil)
	Infinity_SetArea('LoadButton3', 135, nil, nil, nil)
	Infinity_SetArea('MenuLoadLabel', 135 , nil, nil, nil)
	Infinity_SetArea('LoadFilter1', 149, nil, nil, nil)
	Infinity_SetArea('LoadFilter2', 149, nil, nil, nil)
	Infinity_SetArea('LoadFilter3', 149, nil, nil, nil)
	Infinity_SetArea('LoadFilterLabel1', 135, nil, nil, nil)
	Infinity_SetArea('LoadFilterLabel2', 135, nil, nil, nil)
	Infinity_SetArea('LoadFilterLabel3', 135, nil, nil, nil)
	else
	Infinity_SetArea('LoadPanel', screenWidth-444, nil, nil, nil)
	Infinity_SetArea('LoadTitle1', screenWidth-`LOAD_TITLE_AREA_X_OFFSET`, nil, nil, nil)
	Infinity_SetArea('LoadTitle2', screenWidth-510, nil, nil, nil)
	Infinity_SetArea('LoadTitle3', screenWidth-532, nil, nil, nil)
	Infinity_SetArea('LoadButton1', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('LoadButton2', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('LoadButton3', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('MenuLoadLabel', screenWidth-384 , nil, nil, nil)
	Infinity_SetArea('LoadFilter1', screenWidth-370, nil, nil, nil)
	Infinity_SetArea('LoadFilter2', screenWidth-370, nil, nil, nil)
	Infinity_SetArea('LoadFilter3', screenWidth-370, nil, nil, nil)
	Infinity_SetArea('LoadFilterLabel1', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('LoadFilterLabel2', screenWidth-384, nil, nil, nil)
	Infinity_SetArea('LoadFilterLabel3', screenWidth-384, nil, nil, nil)
	end
end

LoadSearchString = ""
function LoadContainsSearchString(rowNumber)

	if(LoadSearchString == nil or LoadSearchString == "") then return 1 end --no search string, do nothing

	local text = gameSaves.files[rowNumber].sName
	if(string.find(string.lower(text),string.lower(LoadSearchString))) then
		return 1
	else
		return nil --does not contain search string
	end
end
LoadSearchString1 = ""
function LoadContainsSearchString1(rowNumber)

	if(LoadSearchString1 == nil or LoadSearchString1 == "") then return 1 end --no search string, do nothing

	local text = string.sub(gameSaves.files[rowNumber].fileName,10)
	if(string.find(string.lower(text),string.lower(LoadSearchString1))) then
		return 1
	else
		return nil --does not contain search string
	end
end
LoadSearchString2 = ""
function LoadContainsSearchString2(rowNumber)

	if(LoadSearchString2 == nil or LoadSearchString2 == "") then return 1 end --no search string, do nothing

	local text = gameSaves.files[rowNumber].chapter
	if(string.find(string.lower(text),string.lower(LoadSearchString2))) then
		return 1
	else
		return nil --does not contain search string
	end
end
function getLoadMenuTitle()
	if (gameSaves.isImporting~=1) then
		return t('LOAD_TITLE')
	end
	return t('IMPORT_TITLE')
end