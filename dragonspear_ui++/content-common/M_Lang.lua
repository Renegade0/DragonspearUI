
	currentlanguage = Infinity_GetINIString('Language', 'Text', '')
	if currentlanguage == "it_IT" then			-- Italian
			JFStrings = {
			JF_All = "Tutte",
			JF_Active = "Attive",
			JF_Completed = "Completate",
			JF_Notes = "Le Mie Note:",
			JF_Edited = "Aggiornato:"
		}
			UIStrings = {
			UI_JMode = "Modalità Diario",
			UI_Large = "Larga",
			UI_Small = "Stretta",
			UI_JToggle = "Cambiare questa opzione permetterà di impostare il diario predefinito in versione stretta ovvero larga.",
			UI_QLMode = "Modalità Bottino Rapido",
			UI_QToggle = "Cambiare questa opzione permetterà di scegliere fra le modalità bottino rapido avanzata e esperta.",
			UI_Advanced = "Avanzata",
			UI_Expert = "Esperta",
			UI_QShow = "- All'inizio del gioco, Bottino rapido è:",
			UI_QShowExp = "Questa opzione permette di impostare il bottino rapido per essere visibile fin dall'avvio del gioco. Puoi abilitarla o disabilitarla in qualsiasi momento. (Nota: Bottino rapido sarà nascosto quando non c'è alcunché da mostrare).",
			UI_Hidden = "Nascosto",
			UI_Visible = "Visibile",
			UI_QRows = "- File:",
			UI_QRowsExp = "Questa opzione permette di selezionare quante file devono essere mostrate dal bottino rapido esperto. Solo i primi 60 oggetti saranno mostrati e dovrete sfogliare per visualizzare i seguenti/precedenti 60 oggetti."
		}
	elseif currentlanguage == "pl_PL" then			-- Polish
			JFStrings = {
			JF_All = "Wszystkie",
			JF_Active = "Aktywne",
			JF_Completed = "Wykonane",
			JF_Notes = "Moje notatki:",
			JF_Edited = "Zmieniony:"
		}
			UIStrings = {
			UI_JMode = "Tryb dziennika",
			UI_Large = "Duży",
			UI_Small = "Mały",
			UI_JToggle = "Włączenie tej opcji pozwala na wybór domyślnej wielkości dziennika. Dostępne są dwie wersje: Duża lub Mała.",
			UI_QLMode = "Tryb Weź wszystko",
			UI_QToggle = "Włączenie tej opcji pozwala na wybór trybu wyświetlania paska Weź wszystko. Dostępne są dwa tryby: Zaawansowany lub Ekspert.",
			UI_Advanced = "Zaawansowany",
			UI_Expert = "Ekspert",
			UI_QShow = "- Wygląd paska Weź wszystko po uruchomieniu gry:",
			UI_QShowExp = "Włączenie tej opcji sprawia, że pasek Weź wszystko staje się widoczny po rozpoczęciu gry. Można włączać i wyłączać tę opcję wedle uznania. Uwaga: pasek Weź wszystko zostanie ukryty, jeśli nie będą dostępne przedmioty do wyświetlania.",
			UI_Hidden = "Ukryty",
			UI_Visible = "Widoczny",
			UI_QRows = "- Wiersze:",
			UI_QRowsExp = "Opcja ta pozwala na wybranie ilości wierszy, które będą wyświetlane na pasku Weź wszystko w trybie Ekspert. Widoczne będzie jedynie pierwsze 60 przedmiotów, z możliwością zmiany stron w celu przejścia do poprzednich lub kolejnych 60 przedmiotów."
		}
	elseif currentlanguage == "de_DE" then			-- German
			JFStrings = {
			JF_All = "Alle",
			JF_Active = "Offen",
			JF_Completed = "Abgeschlossen",
			JF_Notes = "Meine Notizen:",
			JF_Edited = "Bearbeitet:"
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
	elseif currentlanguage == "pt_BR" then			-- Brazilian Portuguese 
			JFStrings = {
			JF_All = "Todas",
			JF_Active = "Ativas",
			JF_Completed = "Concluídas",
			JF_Notes = "Minhas Anotações:",
			JF_Edited = "Editado:"
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
	elseif currentlanguage == "fr_FR" then			-- French
			JFStrings = {
			JF_All = "Toutes",
			JF_Active = "Actives",
			JF_Completed = "Accomplies",
			JF_Notes = "Mes notes:",
			JF_Edited = "Modifiée:"
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
	elseif currentlanguage == "cs_CZ" then			-- Czech
			JFStrings = {
			JF_All = "Všechny",
			JF_Active = "Aktivní",
			JF_Completed = "Dokončené",
			JF_Notes = "Poznámky:",
			JF_Edited = "Upravené:"
		}
			UIStrings = {
			UI_JMode = "Režim deníku",
			UI_Large = "Velký",
			UI_Small = "Malý",
			UI_JToggle = "Toto nastavení umožňuje přepnout mezi malým a velkým deníkem.",
			UI_QLMode = "Režim rychlého sběru",
			UI_QToggle = "Toto nastavení umožňuje přepnout mezi pokročilým a expertním režimem rychlého sběru (quicklootu).",
			UI_Advanced = "Pokročilý",
			UI_Expert = "Expertní",
			UI_QShow = "- Na začátku hry, rychlý sběr je:",
			UI_QShowExp = "Toto nastavení umožňuje vybrat, zda jsou sloty rychlého sběru skryté, či viditelné při zapnutí hry. Poznámka - pokud na zemi nejsou žádné předměty, rychlý sběr je automaticky skrytý.",
			UI_Hidden = "Skrytý",
			UI_Visible = "Viditelný",
			UI_QRows = "- Řady:",
			UI_QRowsExp = "Toto nastavení umožňuje vybrat počet řad, které expertní rychlý sběr zobrazí. Vždy bude zobrazeno maximálně 60 slotů (s šipkami pro posouvání pro více než 60 předmětů na zemi)."
		}
	else											-- no matching language or language strings not set, so default to en_US for the extra strings
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
	end