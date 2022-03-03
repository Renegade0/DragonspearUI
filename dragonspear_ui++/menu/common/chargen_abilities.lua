RerollFrame = 0
storedTotalRoll = 0
ptflat = 0
MethodToggle = 0
MethDescToggle = 0
rolling = 0
fiftyStr = 0
seventyfiveStr = 0
ninetyStr = 0
ninetynineStr = 1
hundredStr = 2
minStr = 1
PBuy = 75
rollMinValue = 1
rollMaxValue = 108
downkeep = 0
arspeed = 1
arse = 1760

chargen.ability = {
	{name = 'STRENGTH_LABEL', desc = 9582},
	{name = 'DEXTERITY_LABEL', desc = 9584},
	{name = 'CONSTITUTION_LABEL', desc = 9583},
	{name = 'INTELLIGENCE_LABEL', desc = 9585},
	{name = 'WISDOM_LABEL', desc = 9586},
	{name = 'CHARISMA_LABEL', desc = 9587},
}

function abilityOrGeneralHelp()
	ability = chargen.ability[currentChargenAbility]
	if ability and ability.desc ~= -1 then
		createCharScreen:SetAbilityHelpInfo(currentChargenAbility)
		return Infinity_FetchString(ability.desc)
	else
		return Infinity_FetchString(17247)
	end
end

raceHasExceptionalStr = {
	true, -- Human
	true, -- Elf
	true, -- Half-Elf
	true, -- Dwarf
	false, -- Halfling
	true, -- Gnome
	true -- Half-Orc
	}

classHasExceptionalStr = {
	false, -- Mage
	true, -- Fighter
	false, -- Cleric
	false, -- Thief
	false, -- Bard
	true, -- Paladin
	true, -- Fighter / Mage
	true, -- Fighter / Cleric
	true, -- Fighter / Thief
	true, -- Fighter / Mage / Thief
	false, -- Druid
	true, -- Ranger
	false, -- Mage / Thief
	false, -- Cleric / Mage
	false, -- Cleric / Thief
	true, -- Fighter / Druid
	true, -- Fighter / Mage / Cleric
	true, -- Cleric / Ranger
	false, -- Sorcerer
	false, -- Monk
	false -- Shaman
	}

function HasExceptionalStrength( )
	return raceHasExceptionalStr[ chargen.selectedRace ] and classHasExceptionalStr[ chargen.selectedClass ]
end

function ShowExceptionalStrength( )
	local strength = tonumber( string.sub( chargen.ability[ 1 ].roll, 1, 2 ) )
	local abilityToDec = 2
	if strength ~= nil then
		while ( strength ~= nil ) and ( strength < 18 ) do
			createCharScreen:OnAbilityPlusMinusButtonClick( abilityToDec, false )
			abilityToDec = abilityToDec + 1
			if( abilityToDec == 7 ) then
				abilityToDec = 2
			end
			createCharScreen:OnAbilityPlusMinusButtonClick( 1, true )
			strength = tonumber( string.sub( chargen.ability[ 1 ].roll, 1, 2 ) )
		end
	end
end

function AutoRoll( )
	createCharScreen:OnAbilityReRollButtonClick()
	local MeetsCriteria = 0
	local exceptionalStrength = 0
	local MinValue = tonumber(rollMinValue)
	local MaxValue = tonumber(rollMaxValue)
	local minimumStr = tonumber(minStr)
	local foStr = tonumber(fiftyStr)
	local sfStr = tonumber(seventyfiveStr)
	local noStr = tonumber(ninetyStr)
	local nnStr = tonumber(ninetynineStr)
	local ohStr = tonumber(hundredStr)

	if( HasExceptionalStrength() ) then
		ShowExceptionalStrength( )
		exceptionalStrength = tonumber( string.sub( chargen.ability[ 1 ].roll, 4 ) )
		if exceptionalStrength ~= nil then
			if exceptionalStrength == 0 then
				exceptionalStrength = 100
			end
		else
			exceptionalStrength = 0
		end
	end

	if MethodToggle == 1 then
		if ( storedTotalRoll == chargen.totalRoll ) then
			if ( chargen.ability[ 1 ].exceptional < exceptionalStrength ) then
				MeetsCriteria = 1
			end
		elseif ( storedTotalRoll < chargen.totalRoll ) then
			MeetsCriteria = 1
		end
	elseif MethodToggle == 2 then
		if ( storedTotalRoll == chargen.totalRoll ) then
			if ( chargen.ability[ 1 ].exceptional < exceptionalStrength ) then
				MeetsCriteria = 1
			end
		elseif ( storedTotalRoll < chargen.totalRoll ) then
			if ( MinValue <= chargen.totalRoll ) then
				if ( MaxValue >= chargen.totalRoll ) then
					MeetsCriteria = 1
				end
			end
		end
	elseif MethodToggle == 3 then
		if ( PBuy == chargen.totalRoll ) then
			if ( chargen.ability[ 1 ].exceptional < exceptionalStrength ) then
				MeetsCriteria = 1
			elseif ( PBuy ~= storedTotalRoll ) then
				MeetsCriteria = 1
			end
		end
	elseif MethodToggle == 4 then
		if ( minimumStr <= exceptionalStrength ) then
			if ( storedTotalRoll == chargen.totalRoll ) then
				if ( chargen.ability [ 1 ].exceptional < exceptionalStrength ) then
					MeetsCriteria = 1
				end
			elseif ( storedTotalRoll < chargen.totalRoll ) then
				MeetsCriteria = 1
			end
		end
	elseif MethodToggle == 5 then
		if ( storedTotalRoll == chargen.totalRoll ) then
			if ( chargen.ability[ 1 ].exceptional < exceptionalStrength ) then
				MeetsCriteria = 1
			end
		elseif ( storedTotalRoll < chargen.totalRoll ) then
			MeetsCriteria = 1
			if ( downkeep <= storedTotalRoll ) then downkeep = 0 end
		elseif ( chargen.ability [ 1 ].exceptional < exceptionalStrength ) then
			if ( chargen.totalRoll >= downkeep ) then
				if ( ( chargen.totalRoll + ohStr >= storedTotalRoll ) and ( exceptionalStrength == 100 ) ) then
					downkeep = storedTotalRoll + ohStr
					MeetsCriteria = 1
				elseif ( ( chargen.totalRoll + nnStr >= storedTotalRoll ) and ( exceptionalStrength >= 91 ) ) then
					downkeep = storedTotalRoll + nnStr
					MeetsCriteria = 1
				elseif ( ( chargen.totalRoll + noStr >= storedTotalRoll ) and ( exceptionalStrength >= 76 ) ) then
					downkeep = storedTotalRoll + noStr
					MeetsCriteria = 1
				elseif ( ( chargen.totalRoll + sfStr >= storedTotalRoll ) and ( exceptionalStrength >= 51 ) ) then
					downkeep = storedTotalRoll + sfStr
					MeetsCriteria = 1
				elseif ( ( chargen.totalRoll + foStr >= storedTotalRoll ) and ( exceptionalStrength >= 1 ) ) then
					downkeep = storedTotalRoll + foStr
					MeetsCriteria = 1
				end
			end
		end

	end

	if MeetsCriteria == 1 then
		storedTotalRoll = chargen.totalRoll
		chargen.ability[ 1 ].exceptional = exceptionalStrength
		chargen.ability[ 1 ].storedRoll = chargen.ability[ 1 ].roll
		chargen.ability[ 2 ].storedRoll = chargen.ability[ 2 ].roll
		chargen.ability[ 3 ].storedRoll = chargen.ability[ 3 ].roll
		chargen.ability[ 4 ].storedRoll = chargen.ability[ 4 ].roll
		chargen.ability[ 5 ].storedRoll = chargen.ability[ 5 ].roll
		chargen.ability[ 6 ].storedRoll = chargen.ability[ 6 ].roll
		createCharScreen:OnAbilityStoreButtonClick()
		MeetsCriteria = 0
	end
end

function UpdateAutoRoll()
	if rolling == 1 then
		RerollFrame = RerollFrame + 1
		if RerollFrame > 1 then
			RerollFrame = 0
		end

		if RerollFrame == 0 then
			local index = 1
			for index = 1, arse, 1 do
				AutoRoll( )
			end
		end
	end
end

function PointReduction()
	local oldPoints
	for i = 1,6 do
		oldPoints = chargen.extraAbilityPoints + 1
		while oldPoints ~= chargen.extraAbilityPoints do
			oldPoints = chargen.extraAbilityPoints
			createCharScreen:OnAbilityPlusMinusButtonClick(i,false)
		end
	end
	StoreRoll()
	createCharScreen:OnAbilityStoreButtonClick()
end

function PointFlatten()
	local overAbility
	PointReduction()
	createCharScreen:OnAbilityRecallButtonClick()
	ptflat = math.floor(chargen.totalRoll/6)
	overAbility = 0
	for i = 1,6 do
		if tonumber(chargen.ability[i].roll) > ptflat then
			overAbility = overAbility + tonumber(chargen.ability[i].roll) - ptflat
		end
	end
	if overAbility > 0 then ptflat = math.floor((chargen.totalRoll - overAbility)/6) end
	for i = 1,6 do
		while ptflat > tonumber(chargen.ability[i].roll) do
			createCharScreen:OnAbilityPlusMinusButtonClick(i,true)
		end
	end
	StoreRoll()
	createCharScreen:OnAbilityStoreButtonClick()
end

function StoreRoll()
	storedTotalRoll = chargen.totalRoll
	chargen.ability[ 1 ].storedRoll = chargen.ability[ 1 ].roll
	chargen.ability[ 2 ].storedRoll = chargen.ability[ 2 ].roll
	chargen.ability[ 3 ].storedRoll = chargen.ability[ 3 ].roll
	chargen.ability[ 4 ].storedRoll = chargen.ability[ 4 ].roll
	chargen.ability[ 5 ].storedRoll = chargen.ability[ 5 ].roll
	chargen.ability[ 6 ].storedRoll = chargen.ability[ 6 ].roll
end

function rgAbilityText()
	if cheatMode == 1 then
	Infinity_SetArea('abilityText', 724, 157, 388, 193)
	else
	Infinity_SetArea('abilityText', 724, 157, 388, 393)
	end
end