function highlightSidebarButton(engine)
	return (engine == e:GetActiveEngine())
end
sidebarVisible =
{
	LEFT = 1,
	RIGHT = 1
}
function toggleSidebar(side)
	local show = side .. "_SIDEBAR"
	local hide = show .. "_HIDDEN"
	if(sidebarVisible[side] == 1) then
		local temp = show
		show = hide
		hide = temp
		sidebarVisible[side] = 0
	else
		sidebarVisible[side] = 1
	end
	Infinity_PushMenu(show)
	Infinity_PopMenu(hide)
end

function rggbuttHighlight1()	if rgHighlightLog == 1 then return 1 else return 0 end
end
function rggbuttHighlight2()	if rgHighlightMap == 1 then return 1 else return 0 end
end
function rggbuttHighlight3()	if rgHighlightJou == 1 then return 1 else return 0 end
end
function rggbuttHighlight4()	if rgHighlightInv == 1 then return 1 else return 0 end
end
function rggbuttHighlight5()	if rgHighlightRec == 1 then return 1 else return 0 end
end
function rggbuttHighlight6()	if rgHighlightMag == 1 then return 1 else return 0 end
end
function rggbuttHighlight7()	if rgHighlightPri == 1 then return 1 else return 0 end
end
function rggbuttHighlight8()	if rgHighlightSav == 1 then return 1 else return 0 end
end
function rggbuttHighlight9()	if rgHighlightQLo == 1 then return 1 else return 0 end
end
function rggbuttHighlight10()	if rgHighlightRes == 1 then return 1 else return 0 end
end
function rggbuttHighlight11()	if rgHighlightRev == 1 then return 1 else return 0 end
end
function rggbuttHighlight12()	if rgHighlightSAI == 1 then return 1 else return 0 end
end
function rggbuttHighlight13()	if rgHighlightSel == 1 then return 1 else return 0 end
end
function rggbuttHighlight14()	if rgHighlightMul == 1 then return 1 else return 0 end
end
sidebarForceTooltips = 0