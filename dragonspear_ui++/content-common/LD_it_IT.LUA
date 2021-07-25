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

PPStrings = {
	PP_CHAR_MALE = "Maschile",  -- 'Male'
	PP_CHAR_FEMALE = "Femminile", -- 'Female'
	PP_SORTAZ = "Dalla A alla Z", -- 'A to Z'
	PP_SORTZA = "Dalla Z alla A", -- 'Z to A'
	PP_SORTDC = "Predefiniti poi Personalizzati", -- 'Default to Custom'
	PP_SORTCD = "Personalizzati poi Predefiniti", -- 'Custom to Default'
	PP_TOTAL = "TOTALE RITRATTI", -- 'TOTAL PORTRAITS'
	PP_DEFAULT = "Predefiniti: ", -- 'Default: '
	PP_CUSTOM = "Personalizzati: ", -- 'Custom: '
	PP_SORT = "Ordina: ", -- 'Sort: '
	PP_SORT_LABEL = "ORDINA", -- 'SORT'
	PP_FILENAME = "Nome File: " -- 'Filename'
}

-- beware of the "\n" symbols (they are beginnings of new rows), do not move them, just ignore them
PDD = {
	"THAC0: -3 \nDanno: +5 \nFattore-velocità: -3 \nAttacco addizionale per round: 1/2 (solo classi combattenti)",
	"THAC0: -3 \nDanno: +4 \nFattore-velocità: -1 \nAttacco addizionale per round: 1/2 (solo classi combattenti)",
	"THAC0: -3 \nDanno: +3 \nAttacco addizionale per round: 1/2 (solo classi combattenti)",
	"THAC0: -1 \nDanno: +2 \nAttacco addizionale per round: 1/2 (solo classi combattenti)",
	"Nessuna penalità",
	"Danno: +1 \nVelocità Arma: -4 \nColpo critico: +1",
	"Danno: +1 \nVelocità Arma: -2 \nColpo critico: +1",
	"CA contro proiettili: -4",
	"CA contro proiettili: -2",
	"CA: -2 \nColpo critico: +1",
	"AC: -1 \nColpo critico: +1" ,
	"THAC0 Mano Sinistra: +2",
	"THAC0 Mano Sinistra: +4",
	"THAC0 Mano Destra: +2\nTHAC0 Mano Sinistra: +6"	
}

duiStrings = {
	ACM_STORED_LABEL = "memorizzati",
	ACM_ROLL_SPEED_LABEL = "Aggiorna Frequenza",
	ACM_CHEAT_METHOD = "Scegli Metodo per i Cheat:",
	ACM_UF_DESCRIPTION = "Aggiorna Frequenza è disponibile per molti metodi.\n\nUtilizza il dispositivo di scorrimento per selezionare la velocità che per te funziona meglio.\n",
	ACM_AUTOROLL_BUTTON = "Tiro Automatico",
	ACM_RANGEROLL_BUTTON = "Tiro nel Raggio",
	ACM_POINTBUY_BUTTON = " Compra Punti",
	ACM_MINSTR_BUTTON = "Minimo Forza",
	ACM_PRISTR_BUTTON = "Priorità a Forza",
	ACM_MAXMAX_BUTTON = "Massimo",
	ACM_AUTOROLL_DESCRIPTION = "Utilizza un tiratore automatico per ottenere il più alto tiro possibile.\nMemorizza il valore più alto di Forza quando il totale corrisponde ed è applicabile alla tua razza o classe.\n\nPiù attendi, più alto potrebbe essere.",
	ACM_RANGEROLL_DESCRIPTION = "Utilizza un tiratore automatico per ottenere un totale dentro un raggio che imposti.\nMemorizza il valore più alto di Forza quando il totale corrisponde ed è applicabile alla tua razza o classe.\n\nPotrebbe occorrere un po’ di tempo per tiri alti.",
	ACM_POINTBUY_DESCRIPTION = "Seleziona il totale desiderato e in seguito assegna i punti a tua scelta. (Le scelte sono 75, 80, 85 e 90).\nMemorizza il valore più alto di Forza quando il totale corrisponde ed è applicabile alla tua razza o classe.\n\nRapido!",
	ACM_MINSTR_DESCRIPTION = "Imposta il minimo desiderato di Forza. Il tiratore automatico cercherà i tiri più alti con un valore di Forza maggiore di quello da te inserito.\n\n\nValori alti possono richiedere parecchio tempo.",
	ACM_PRISTR_DESCRIPTION = "Imposta punti di priorità per ogni raggio di Forza. Il tiratore automatico seleziona i tiri che incontrano i tuoi criteri (ad esempio, se imposti un raggio da 91 a 100, un tiro di 93 con Forza 18/97 verrebbe salvato rispetto a un tiro di 94 con Forza 18/20).\n\nNumeri alti potrebbero generare risultati stravaganti.",
	ACM_MAXMAX_DESCRIPTION = "Risparmia tempo e imposta tutte le caratteristiche a 18.\n\n\n\n\n",
	ACM_CHANGEMETHOD_BUTTON = "Cambia Metodo",
	ACM_SELMETHOD_AUTOROLL_TEXT = " METODO: Tiro Automatico",
	ACM_SELMETHOD_RANGEROLL_TEXT = " METODO: Tiro nel Raggio",
	ACM_SELMETHOD_RANGEROLL_TO_TEXT = "a",
	ACM_SELMETHOD_POINTBUY_TEXT = " METODO: Compra Punti",
	ACM_SELMETHOD_POINTBUY_ACQUIRED = "ACQUISITO! Disattiva Tiratore Automatico!",
	ACM_SELMETHOD_MINSTR_TEXT = " METODO: Minimo Forza",
	ACM_SELMETHOD_MINSTR_MINSTR = "Minimo Forza",
	ACM_SELMETHOD_PRISTR_TEXT = "METODO: Priorità a Forza",
	ACM_SELMETHOD_MAXMAX_TEXT = " METODO: Massimo",
	ACM_SELMETHOD_MAXMAX_MAXMAX = "Modalità Debug Attiva.\n\n Premere Ctrl + 8.",
	ACM_START = "INIZIA",
	ACM_STOP = "FERMA",
	ACM_VIEW = "Cambia Visuale",
	ACM_FLATTEN = "Uguale",
	ACM_MINIMUM = "Riduci",
	RG_CLASS_BUTTON = " DESCRIZIONE CLASSE",
	RG_PROFS_BUTTON = "COMPETENZE/ABILITÀ",
	RG_OVERVIEW = "PANORAMICA",
	RG_RECORD = "Registro",
	RG_UI_TITLE = "Impostazioni IU",
	RG_UI_PANEL = "Pannello Menù Principale sul Lato Sinistro",
	RG_UI_PANEL1 = "Attiva questa opzione per visualizzare il pannello del Menù Principale sul lato sinistro anziché sul lato destro. Questo può essere utile per alcuni fondali personalizzati.",
	RG_UI_JOURNAL = "Diario Piccolo/Grande",
	RG_UI_JOURNAL1 = "Attiva questa opzione per passare dalle schermate originali del diario a quelle nuove e più grandi.",
	RG_UI_CHEAT = "Modalità Cheat",
	RG_UI_CHEAT1 = "Attiva questa opzione per utilizzare i cheat. Le opzioni del tiro automatico nel menù di creazione del personaggio saranno disponibili cliccando il pulsante Mostra Dettagli.",
	RG_UI_QUICKLOOT = "Barra Bottino Rapido Attiva/Disattiva per impostazione predefinita",
	RG_UI_QUICKLOOT1 = "Attiva questa opzione per rendere sempre visibile la barra del Bottino Rapido quando inizi o carichi una partita.",
	RG_RANDOM = "personaggio casuale",
	RG_PP_TOOLTIP = "Scegli il tuo ritratto dalla lista. Per maggiori informazioni sui ritratti personalizzati, clicca il pulsante Personalizza.",
	RG_PP_TOOLTIP1 = "Per utilizzare un ritratto personalizzato, inserisci l’immagine desiderata in Documents/Baldur's Gate - Enhanced Edition/portraits (è possibile che tu debba creare la cartella portraits). L’immagine deve essere in formato BMP 24-bit e il nome del file non deve essere più lungo di sette caratteri.",
	RG_PP_TOOLTIP2 = "Tieni presente che le dimensioni standard dei ritratti sono 210x330; le immagini più grandi o più piccole verranno riadattate affinché entrino nella cornice. Nessuna immagine può essere più grande di 1024 in entrambe le dimensioni.",
	RG_PP_TOOLTIP3 = "Per aggiornare la lista dei ritratti, esegui di nuovo la componente di WeiDU Portrait Picker. Aggiungere il prefisso f# (per il sesso femminile) o m# (per il sesso maschile) al nome del file del ritratto prima di eseguire Weidu imposterà automaticamente il suo genere. I nomi dei ritratti che terminano con m o con s non verranno mostrati nella lista. Se il nome di un file termina con l e un altro ritratto ha lo stesso nome del file ma termina con m, quest’ultimo sarà usato come ritratto piccolo nella colonna a destra dell’IU. Per aggiungere una descrizione e impostare il genere manualmente, potrai utilizzare lo strumento Portrait Picker, prossimamente in arrivo.",
	RG_PP_TOOLTIP4 = "Se vuoi dare una descrizione ai ritratti disponibili di default, devi editare manualmente il file M_nicks.lua cercando il nome del file di default sulla destra ed editando la descrizione tra le virgolette ad esso vicine.",
	RG_CURRENT_QUESTS = "Missioni in Corso",
	RG_FINISHED_QUESTS = "Missioni Completate",
	RG_TOTAL = "Totale",
	RG_SPELL_TOOLTIP = "Usa il click sinistro per memorizzare e il click destro per cancellare.",
	RG_FILTER1 = "Filtra per personaggio",
	RG_FILTER2 = "Filtra per nome salvataggio",
	RG_FILTER3 = "Filtra per capitolo",
	RG_UI_SETTINGS = "Impostazioni IU",
	RG_UI_CLASSIC_DIALOG = "Classic Dialog Window",
	RG_UI_CLASSIC_DIALOG1 = "Toggling this option on will display a static dialog window in the bottom center of the screen, where you can scroll up to see the dialog history.",
	RG_UI_MPPICKER = "Multi-portrait picker",
	RG_UI_MPPICKER1 = "Toggling this option on will display a multi-portrait picker in the character generation screen, instead of default list-based portrait picker.",
	RG_UI_LPORTRAITS = "Large portraits",
	RG_UI_LPORTRAITS1 = "Toggling this option on will display bigger portraits on a main gameplay screen. Instead of default 64x91 pixels they will have 82x123 pixels. This option mainly suits unscaled interface.",
	RG_UI_THIEFBUTT = "Permanent thieving button",
	RG_UI_THIEFBUTT1 = "Toggling this option on will display a permanent thieving button in the bottom right section of the screen, tied to a hotkey 'f'. This is useful for Cleric / Thiefs.",
}
