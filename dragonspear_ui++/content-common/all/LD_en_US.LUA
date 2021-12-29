JFStrings = {
	JF_All = "All",
	JF_Active = "Active",
	JF_Completed = "Completed",
	JF_Notes = "My Notes:",
	JF_Edited = "Edited:"
}

UIStrings = {
	UI_JMode = "Journal Mode",
	UI_Large = "Large",
	UI_Small = "Small",
	UI_JToggle = "Toggling this option will allow set your default journal, either the small or large version.",
	UI_QLMode = "Quickloot Mode",
	UI_QToggle = "Toggling this option will allow you to switch between Advanced and Expert Quickloot Modes.",
	UI_Advanced = "Advanced",
	UI_Expert = "Expert",
	UI_QShow = "- On game start, Quickloot is:",
	UI_QShowExp = "This option allows you to set the quickloot to be visible when you first load the game. You can toggle it on/off whenever you like. Note - The quickloot will hide when there is nothing to display.",
	UI_Hidden = "Hidden",
	UI_Visible = "Visible",
	UI_QRows = "- Rows:",
	UI_QRowsExp = "This option allows you to select how many rows the Expert quickloot has for display. Only the first 60 items will be displayed and you will have pages to move to the next/previous 60 items."
}

PPStrings = {
	PP_CHAR_MALE = "Male",  -- 'Male'
	PP_CHAR_FEMALE = "Female", -- 'Female'
	PP_SORTAZ = "A to Z", -- 'A to Z'
	PP_SORTZA = "Z to A", -- 'Z to A'
	PP_SORTDC = "Default to Custom", -- 'Default to Custom'
	PP_SORTCD = "Custom to Default", -- 'Custom to Default'
	PP_TOTAL = "TOTAL PORTRAITS", -- 'TOTAL PORTRAITS'
	PP_DEFAULT = "Default: ", -- 'Default: '
	PP_CUSTOM = "Custom: ", -- 'Custom: '
	PP_SORT = "Sort: ", -- 'Sort: '
	PP_SORT_LABEL = "SORT", -- 'SORT'
	PP_FILENAME = "Filename: " -- 'Filename'
}

-- beware of the "\n" symbols (they are beginnings of new rows), do not move them, just ignore them
PDD = {
	"THAC0: -3 \nDamage: +5 \nSpeed factor: -3 \nExtra attack per round: 1/2 (warriors only)",
	"THAC0: -3 \nDamage: +4 \nSpeed factor: -1 \nExtra attack per round: 1/2 (warriors only)",
	"THAC0: -3 \nDamage: +3 \nExtra attack per round: 1/2 (warriors only)",
	"THAC0: -1 \nDamage: +2 \nExtra attack per round: 1/2 (warriors only)",
	"No penalties",
	"Damage: +1 \nWeapon Speed: -4 \nCritical hit: +1",
	"Damage: +1 \nWeapon Speed: -2 \nCritical hit: +1",
	"AC against missile: -4",
	"AC against missile: -2",
	"AC: -2 \nCritical hit: +1",
	"AC: -1 \nCritical hit: +1" ,
	"Off-hand THAC0: +2",
	"Off-hand THAC0: +4",
	"Main-hand THAC0: +2\nOff-hand THAC0: +6"	
}

duiStrings = {
	ACM_STORED_LABEL = "stored",
	ACM_ROLL_SPEED_LABEL = "Update Frequency",
	ACM_CHEAT_METHOD = "Choose Cheat Method:",
	ACM_UF_DESCRIPTION = "Update Frequency is available for most methods.\n\nUse the slider to pick the speed that works best for you and your setup.\n",
	ACM_AUTOROLL_BUTTON = "Auto Roll",
	ACM_RANGEROLL_BUTTON = "Range Roll",
	ACM_POINTBUY_BUTTON = "Point Buy",
	ACM_MINSTR_BUTTON = "Minimum Str %age",
	ACM_PRISTR_BUTTON = "Priority Str",
	ACM_MAXMAX_BUTTON = "Maximum",
	ACM_AUTOROLL_DESCRIPTION = "Uses an autoroller to roll to achieve the highest total roll possible.\nStores higher Str% when totals match and applicable to your race or class.\n\nThe longer you wait, the higher it might go.",
	ACM_RANGEROLL_DESCRIPTION = "Uses an autoroller to achieve a total within a range that you set.\nStores higher Str% when totals match and applicable to your race or class.\n\nHigh values may take longer.",
	ACM_POINTBUY_DESCRIPTION = "Select the desired total and then allocate the points as you choose.  (Choices are: 75, 80, 85 and 90).\nStores higher Str% when totals match and applicable to your race or class.\n\nQuick!",
	ACM_MINSTR_DESCRIPTION = "Set the desired minimum Str% and the autoroller will look for the highest total rolls with Str% higher than your set value.\n\n\nHigh values can take longer.",
	ACM_PRISTR_DESCRIPTION = "Set priority points for each range of Str%.  The autoroller selects rolls that meet your criteria, EG:\nSet range (91 to 100) to 1-point and a roll of (93 with Str 18/97) would be saved over a (94 with Str 18/20).\n\nLarge numbers may produce erratic results.",
	ACM_MAXMAX_DESCRIPTION = "Save time and set all abilities to 18.\n\n\n\n\n",
	ACM_CHANGEMETHOD_BUTTON = "Change Method",
	ACM_SELMETHOD_AUTOROLL_TEXT = "METHOD: Auto Roll",
	ACM_SELMETHOD_RANGEROLL_TEXT = "METHOD: Range Roll",
	ACM_SELMETHOD_RANGEROLL_TO_TEXT = "to",
	ACM_SELMETHOD_POINTBUY_TEXT = "METHOD: Point Buy",
	ACM_SELMETHOD_POINTBUY_ACQUIRED = "ACQUIRED!  Deactivate Autoroller!",
	ACM_SELMETHOD_MINSTR_TEXT = "METHOD: Minimum Strength %age",
	ACM_SELMETHOD_MINSTR_MINSTR = "Minimum Str%",
	ACM_SELMETHOD_PRISTR_TEXT = "METHOD: Priority Strength %age",
	ACM_SELMETHOD_MAXMAX_TEXT = "METHOD: Maximum",
	ACM_SELMETHOD_MAXMAX_MAXMAX = "Debug Mode Enabled.\n\n Please press Ctrl + 8.",
	ACM_START = "START",
	ACM_STOP = "STOP",
	ACM_VIEW = "Change View",
	ACM_FLATTEN = "Flat",
	ACM_MINIMUM = "Reduce",
	RG_CLASS_BUTTON = "CLASS DESCRIPTION",
	RG_PROFS_BUTTON = "PROFICIENCIES / SKILLS",
	RG_OVERVIEW = "OVERVIEW",
	RG_RECORD = "Record",
	RG_UI_TITLE = "UI Settings",
	RG_UI_PANEL = "Left Side Main Menu Panel",
	RG_UI_PANEL1 = "Toggling this option on will display the Main Menu panel on the left side, instead of the right. This may be useful for some custom backgrounds.",
	RG_UI_JOURNAL = "Small/Large Journal - DISABLED",
	RG_UI_JOURNAL1 = "Toggling this option will switch between the original and new large journal screens. - DISABLED",
	RG_UI_CHEAT = "Cheat Mode",
	RG_UI_CHEAT1 = "Toggling this option on will enable cheating. Autoroller options in the character generation menu will be available, holding the 'Reveal Details' button will explore the area.",
	RG_UI_QUICKLOOT = "Quickloot bar On/Off by default",
	RG_UI_QUICKLOOT1 = "Toggling this option on will cause quickloot menu to be always on, when starting or loading the game.",
	RG_RANDOM = "Random Character",
	RG_PP_TOOLTIP = "Choose your portrait from the list. For more information about custom portraits, press the 'Custom' button.", 
	RG_PP_TOOLTIP1 = "To use a custom portrait, place the desired portrait in 'Documents/Baldur's Gate - Enhanced Edition/portraits' (you may need to create the portraits folder). The image must be in 24-bit BMP format, and the file name must be no more than seven characters long.",
	RG_PP_TOOLTIP2 = "Note that the standard dimensions for portraits are 210x330; images that are larger or smaller will be resized to fit the frame. No image may be larger than 1024 in either dimension.",
	RG_PP_TOOLTIP3 = "For updating the portrait list, run the WeiDU 'Portrait Picker' component again. Adding 'f#' (for female) or 'm#' (for male) prefix to the portrait filename before running the WeiDU will automatically set its gender. Portrait filenames that end with 'm' or 's' will not show in the list. Instead, if the filename ends with 'l' and another portrait has the exact same filename except it ends with 'm', the latter will be used as a small portrait in the right sidebar. For adding a description and setting the gender manually, you will be able to use the 'Portrait Picker' tool, which will be coming soon.",
	RG_PP_TOOLTIP4 = "If you want to give the default portraits a description, you must manually edit the M_nicks.lua file by finding the default filename on the left and editing the description next to it between the quote marks.",
	RG_CURRENT_QUESTS = "Current Quests",
	RG_FINISHED_QUESTS = "Finished Quests",
	RG_TOTAL = "Total",
	RG_SPELL_TOOLTIP = "Use left-click to memorize and right-click to unmemorize.",
	RG_FILTER1 = "Filter by character",
	RG_FILTER2 = "Filter by save name",
	RG_FILTER3 = "Filter by chapter",
	RG_UI_SETTINGS = "UI Settings",
	RG_UI_CLASSIC_DIALOG = "Classic Dialog Window",
	RG_UI_CLASSIC_DIALOG1 = "Toggling this option on will display a static dialog window in the bottom center of the screen, where you can scroll up to see the dialog history.",
	RG_UI_MPPICKER = "Multi-portrait picker",
	RG_UI_MPPICKER1 = "Toggling this option on will display a multi-portrait picker in the character generation screen, instead of default list-based portrait picker.",
	RG_UI_LPORTRAITS = "Large portraits",
	RG_UI_LPORTRAITS1 = "Toggling this option on will display bigger portraits on a main gameplay screen. Instead of default 64x91 pixels they will have 82x123 pixels. This option mainly suits unscaled interface.",
	RG_UI_THIEFBUTT = "Permanent thieving button",
	RG_UI_THIEFBUTT1 = "Toggling this option on will display a permanent thieving button in the bottom right section of the screen. This is useful for Cleric / Thiefs.",
	RG_UI_THIEFBUTT_WARN = "Requires an assigned thieving key binding.",
	RG_ABILITY_BONUSES = 'Ability bonuses',
}

-- 0 = BGEE, 1 = BG2EE, 2 = IWDEE
if engine_mode == 0 then
	updateTable(duiStrings, {
		RG_MENU_CAMPAIGN = "Baldur's Gate EE Campaigns",
		RG_MENU_CAMPAIGN1 = "Baldur's Gate",
		RG_MENU_CAMPAIGN2 = "Siege of Dragonspear",
		RG_MENU_CAMPAIGN3 = "The Black Pits",
	})
elseif engine_mode == 1 then
	updateTable(duiStrings, {
		RG_MENU_CAMPAIGN = "Baldur's Gate 2 EE Campaigns",
		RG_MENU_CAMPAIGN1 = "Shadows of Amn",
		RG_MENU_CAMPAIGN2 = "Throne of Bhaal",
		RG_MENU_CAMPAIGN3 = "The Black Pits 2",
	})
else
	Infinity_Log(('Unsupported engine_mode "%s"'):format(engine_mode))
end