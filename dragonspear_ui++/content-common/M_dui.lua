local function updateTable(first, second)
	for k, v in pairs(second) do
		first[k] = v
	end
end

fontcolors['X'] = 'FF7D7D7D' -- gold yellow/orange
chapterBackground = ""

-- 0 = BGEE, 1 = BG2EE, 2 = IWDEE
if engine_mode == 0 then
    -- chapterBackgrounds is empty from 14 to 51 except at 20
    -- fill it with GUICHP0A
	for i = 14, 51 do
		-- DUI doesn't check for nil and overwrites existing values
		-- I don't know if it's intentional, only single value is actually replaced
		--	chapterBackgrounds[20] = "BPEND"
		-- everything else from 14 to 51 is nil
		if chapterBackgrounds[i] == nil then
			chapterBackgrounds[i] = "GUICHP0A"
		end
	end
end

-- vanilla SoD styles
updateTable(styles, {
	gamelog =
	{
		color = 'B',
		font = 'POSTANTI',
		point = 12,
		useFontZoom = 1,
		valign = 'top',
		halign = 'left',
	},
	normal =
	{
		color = 'B',
		font = 'MODESTOM',
		point = 14,
		useFontZoom = 1,
		valign = 'top',
		halign = 'left',
	},
	normal_parchment =
	{
		color = '5',
		font = 'POSTANTI',
		point = 12,
		useFontZoom = 1,
		valign = 'top',
		halign = 'left',
	},
	title =
	{
		color = '1',
		font = 'SHERWOOD',
		point = 20,
		useFontZoom = 0,
		valign = 'center',
		halign = 'center',
	},
	parchment =
	{
		color = '5',
		font = 'POSTANTI' ,
		point = 12,
		useFontZoom = 1,
		valign = 'top',
		halign = 'left',
	},
	button =
	{
		color = 'B',
		font = 'MODESTOM' ,
		point = 18,
		useFontZoom = 0,
		valign = 'center',
		halign = 'center',
		upper = 1,
		pad = {8,8,8,8},
	},
	label =
	{
		color = 'B',
		font = 'MODESTOM',
		point = 14,
		useFontZoom = 0,
		valign = 'center',
		halign = 'center',
	},
	label_parchment =
	{
		color = '5',
		font = 'POSTANTI',
		point = 12,
		useFontZoom = 0,
		valign = 'center',
		halign = 'center',
	},
	button_parchment =
	{
		color = '5',
		font = 'POSTANTI',
		point = 12,
		useFontZoom = 0,
		valign = 'center',
		halign = 'center',
		pad = {0,5,0,0},
	},
	edit =
	{
		color = 'B',
		font = 'MODESTOM',
		point = 14,
		useFontZoom = 1,
		valign = 'top',
		halign = 'left',
	},
	edit_parchment =
	{
		color = '5',
		font = 'POSTANTI',
		point = 12,
		useFontZoom = 1,
		valign = 'top',
		halign = 'left',
	},
	list =
	{
		color = 'B',
		font = 'STONESML',
		point = 18,
		useFontZoom = 0,
		valign = 'center',
		halign = 'left',
	},
	list_parchment =
	{
		color = '5',
		font = 'POSTANTI',
		point = 12,
		useFontZoom = 0,
		valign = 'center',
		halign = 'left',
	},
	gold =
	{
		color = '$',
		font = 'MODESTOM',
		point = 12,
		useFontZoom = 0,
		valign = 'center',
		halign = 'center',
	},
	label_loadname =
	{
		color = 'B',
		font = 'MODESTOM',
		point = 20,
		useFontZoom = 0,
		valign = 'center',
		halign = 'center',
	},
})

-- DUI specific styles
updateTable(styles, {
	rg_trajan =
	{
		color = '5',
		font = 'RGTRAJ',
		point = 14,
		useFontZoom = 1,
		valign = 'top',
		halign = 'left',
	},
	normal_big =
	{
		color = 'B',
		font = 'MODESTOM',
		point = 18,
		useFontZoom = 1,
		valign = 'top',
		halign = 'left',
	},
})

updateTable(const, {
	START_CAMPAIGN_BG = 1,
	START_CAMPAIGN_BP = 2,
	START_CAMPAIGN_SOD = 3,
})

