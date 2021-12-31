local config = include 'sod.lua'

-- constants --
GAME_VERSION = "bg1"

START_CAMPAIGNS = {
	{ name = "BG", index = 1, sequence = 3, action = "startEngine:OnSoAButtonClick(true)" },
	{ name = "BP", index = 3, sequence = 1, action = "startEngine:OnTBPButtonClick(true)" },
}


return config