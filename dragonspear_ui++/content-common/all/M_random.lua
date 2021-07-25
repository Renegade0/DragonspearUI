function randChar()
	RandGender = 0
	choosePortrait = 0
	toggleMale = 0
	toggleFemale = 0
	currentChargenRace = 0
	currentChargenClass = 0
	currentChargenKit = 0
	currentChargenAlignment = 0
	if randomCharacter == 0 then
		randomCharacter = 1
	end
	
	-- Gender
	if createCharScreen:GetCurrentStep() == 0 then
		RandGender = math.random(2)
		createCharScreen:OnMenuButtonClick()
		
		if RandGender == 1 then
			toggleMale = 1
			toggleFemale = 0
			createCharScreen:OnGenderSelectButtonClick(1)
		elseif RandGender == 2 then
			toggleMale = 0
			toggleFemale = 1
			createCharScreen:OnGenderSelectButtonClick(2)
		end
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
	
	
	-- Portrait
	if createCharScreen:GetCurrentStep() == 1 then
		if RandGender == 1 then
			while createCharScreen:GetCurrentPortrait() ~= "MAN2L" do
				createCharScreen:DecCurrentPortrait()
			end
		elseif RandGender == 2 then
			while createCharScreen:GetCurrentPortrait() ~= "WOMAN2L" do
				createCharScreen:DecCurrentPortrait()
			end
		end
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
		
	if createCharScreen:GetCurrentStep() == 2 then
		-- do nothing
	end
	
	-- Race
	if createCharScreen:GetCurrentStep() == 3 then
		createCharScreen:OnMenuButtonClick()
		currentChargenRace = math.random(#chargen.races)
		createCharScreen:OnRaceSelectButtonClick(chargen.races[currentChargenRace].id)
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
	
	-- Class
	if createCharScreen:GetCurrentStep() == 4 then
		createCharScreen:OnMenuButtonClick()
		currentChargenClass = math.random(#chargen.class)
		createCharScreen:OnClassSelectButtonClick(chargen.class[currentChargenClass].id)
		Infinity_PopMenu('CHARGEN_CLASS')
		createCharScreen:OnDoneButtonClick()
	end
	
	if createCharScreen:GetCurrentStep() == 5 then
		-- do nothing
	end
	
	-- Kit
	if createCharScreen:GetCurrentStep() == 6 then
		currentChargenKit = math.random(#chargen.kit)
		createCharScreen:OnKitSelectButtonClick(chargen.kit[currentChargenKit].id)
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
	
	-- Alignment
	if createCharScreen:GetCurrentStep() == 7 then
		createCharScreen:OnMenuButtonClick()
		currentChargenAlignment = math.random(#chargen.alignment)
		createCharScreen:OnAlignmentSelectButtonClick(chargen.alignment[currentChargenAlignment].id)
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
	
	-- Abilities
	if createCharScreen:GetCurrentStep() == 8 then
		createCharScreen:OnMenuButtonClick()
		while chargen.totalRoll < 85 do
			createCharScreen:OnAbilityReRollButtonClick()
		end
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
	
	-- Skills
	if createCharScreen:GetCurrentStep() == 9 then
		createCharScreen:OnMenuButtonClick()
		while chargen.extraProficiencySlots > 0 do
			currentChargenProficiency = math.random(#chargen.proficiency)
			createCharScreen:OnProficiencyPlusMinusButtonClick(chargen.proficiency[currentChargenProficiency].id, true)
		end
		while chargen.extraSkillPoints > 0 do
			currentChargenThiefSkill = math.random(#chargen.thief_skill)
			for i=1,5,1 do
				createCharScreen:OnThiefSkillPlusMinusButtonClick(chargen.thief_skill[currentChargenThiefSkill].id, true)
			end
		end
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
	
	-- Mage Choose Learned Spells
	if createCharScreen:GetCurrentStep() == 11 then
		while createCharScreen:GetCurrentStep() == 11 do
			randLearnedMage()
		end
	end
	
	-- Mage Choose Active Spells
	if createCharScreen:GetCurrentStep() == 12 then
		while createCharScreen:GetCurrentStep() == 12 do
			randActiveMage()
		end
	end
	
	-- Priest
	if createCharScreen:GetCurrentStep() == 13 then
		while createCharScreen:GetCurrentStep() == 13 do
			randPriest()
		end
	end
	
	if createCharScreen:GetCurrentStep() == 14 then
		-- do nothing
	end
	
	-- Racial Enemy
	if createCharScreen:GetCurrentStep() == 10 then
		currentChargenHatedRace = math.random(#chargen.hatedRace)
		createCharScreen:OnRacialEnemySelectButtonClick(chargen.hatedRace[currentChargenHatedRace].id)
		createCharScreen:OnDoneButtonClick()
	end
	chargen.information = t("RG_RANDOM") .. ':\n\n' .. chargen.information
end


function randLearnedMage()
	while chargen.extraSpells > 0 do
		currentChargenChooseMageSpell = math.random(#chargen.choose_spell)
		createCharScreen:OnLearnMageSpellButtonClick(currentChargenChooseMageSpell)
	end
	createCharScreen:OnDoneButtonClick()
end


function randActiveMage()
	while chargen.extraSpells > 0 do
		currentChargenMemorizeMageSpell = math.random(#chargen.choose_spell)
		createCharScreen:OnMemorizeMageSpellButtonClick(currentChargenMemorizeMageSpell, 1)
		if chargen.extraSpells == 0 and not createCharScreen:IsDoneButtonClickable() then
			createCharScreen:OnMemorizeMageSpellButtonClick(currentChargenMemorizeMageSpell, -1)
		end
	end
	createCharScreen:OnDoneButtonClick()
end


function randPriest()
	while chargen.extraSpells > 0 do
		currentChargenMemorizePriestSpell = math.random(#chargen.choose_spell)
		createCharScreen:OnMemorizePriestSpellButtonClick(currentChargenMemorizePriestSpell, 1)
	end
	createCharScreen:OnDoneButtonClick()
end