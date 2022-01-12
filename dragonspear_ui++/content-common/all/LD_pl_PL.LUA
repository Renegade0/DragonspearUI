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

PPStrings = {
	PP_CHAR_MALE = "Mężczyzna",  -- 'Male'
	PP_CHAR_FEMALE = "Kobieta", -- 'Female'
	PP_SORTAZ = "od A do Z", -- 'A to Z'
	PP_SORTZA = "od Z do A", -- 'Z to A'
	PP_SORTDC = "Domyślne potem Własne", -- 'Default to Custom'
	PP_SORTCD = "Własne potem Domyśln", -- 'Custom to Default'
	PP_TOTAL = "Ilość portretów", -- 'TOTAL PORTRAITS'
	PP_DEFAULT = "Domyślne: ", -- 'Default: '
	PP_CUSTOM = "Własne: ", -- 'Custom: '
	PP_SORT = "Sortuj: ", -- 'Sort: '
	PP_SORT_LABEL = "Sortuj", -- 'SORT'
	PP_FILENAME = "Nazwa pliku: " -- 'Filename'
}

-- beware of the "\n" symbols (they are beginnings of new rows), do not move them, just ignore them
PDD = {
	"TraK0: -3 \nObrażenia: +5 \nCzynnik szybkości: -3 \nDodatkowy atak na rundę: 1/2 (tylko wojownicy)",
	"TraK0: -3 \nObrażenia: +4 \nCzynnik szybkości: -1 \nDodatkowy atak na rundę: 1/2 (tylko wojownicy)",
	"TraK0: -3 \nObrażenia: +3 \nDodatkowy atak na rundę: 1/2 (tylko wojownicy)",
	"TraK0: -1 \nObrażenia: +2 \nDodatkowy atak na rundę: 1/2 (tylko wojownicy)",
	"Brak kar",
	"Obrażenia: +1 \nSzybkość broni: -4 \nTrafienie krytyczne: +1",
	"Obrażenia: +1 \nSzybkość broni: -2 \nTrafienie krytyczne: +1",
	"KP przeciwko pociskom: -4",
	"KP przeciwko pociskom: -2",
	"KP: -2 \nTrafienie krytyczne: +1",
	"KP: -1 \nTrafienie krytyczne: +1" ,
	"TraK0 drugiej ręki: +2",
	"TraK0 drugiej ręki: +4",
	"TraK0 pierwszej ręki: +2\nTraK0 drugiej ręki: +6"
}

duiStrings = {
	ACM_STORED_LABEL = "zapisane",
	ACM_ROLL_SPEED_LABEL = "Zmień częstotliwość",
	ACM_CHEAT_METHOD = "Wybierz metodę oszustwa:",
	ACM_UF_DESCRIPTION = "Zmiana częstotliwości jest dostępna dla wszystkich metod.\n\nUżyj suwaka by wybrać najbardziej odpowiadającą ci prędkość.\n",
	ACM_AUTOROLL_BUTTON = "Automatyczne rzuty",
	ACM_RANGEROLL_BUTTON = "Zakres rzutów",
	ACM_POINTBUY_BUTTON = "Zakup punktów",
	ACM_MINSTR_BUTTON = "Minimalna Siła",
	ACM_PRISTR_BUTTON = "Priorytet Siły",
	ACM_MAXMAX_BUTTON = "Maksimum",
	ACM_AUTOROLL_DESCRIPTION = "Losuje automatycznie rzuty, aż do otrzymania najwyższego, możliwego wyniku. \nZachowuje najwyższą Siłę dostępną dla twojej rasy i klasy. \n\nIm dłużej czekasz, tym wyższy jest wynik.",
	ACM_RANGEROLL_DESCRIPTION = "Losuje automatycznie rzuty, aż do otrzymania najwyższego wyniku z zakresu. \nZachowuje najwyższą Siłę dostępną dla twojej rasy i klasy. \n\nWysokie rzuty mogą zająć więcej czasu.",
	ACM_POINTBUY_DESCRIPTION = "Ustaw pożądaną wartość i rozłóż punkty wedle uznania. (Możesz wybrać: 75, 80, 85 and 90).\nZachowuje najwyższą Siłę dostępną dla twojej rasy i klasy.\n\nSzybkie!",
	ACM_MINSTR_DESCRIPTION = "Ustaw pożądaną minimalną wartość Siły, a Rzutnik będzie szukał najwyższych wyników z Siłą wyższą od ustawionej.\n\n\nWysokie rzuty mogą zająć więcej czasu.",
	ACM_PRISTR_DESCRIPTION = "Ustaw punkty priorytetu dla każdego zakresu Siły. Rzutnik wybierze rzuty spełniające kryteria. NP:\nDodaj 1 punkt zakresowi (91 to 100), a rzut (93 z Siłą 18/97) będzie zapisany przed (94 z Siłą 18/20).\n\nDuże liczby mogą skutkować nieobliczalnymi wynikami.",
	ACM_MAXMAX_DESCRIPTION = "Zaoszczędź czas i ustaw wszystkie cechy na 18.\n\n\n\n\n",
	ACM_CHANGEMETHOD_BUTTON = "ZMIEŃ METODĘ",
	ACM_SELMETHOD_AUTOROLL_TEXT = "METODA: Automatyczne rzuty",
	ACM_SELMETHOD_RANGEROLL_TEXT = "METODA: Zakres rzutów",
	ACM_SELMETHOD_RANGEROLL_TO_TEXT = "do",
	ACM_SELMETHOD_POINTBUY_TEXT = "METODA: Zakup punktów",
	ACM_SELMETHOD_POINTBUY_ACQUIRED = "OSIĄGNIĘTE!  Wyłącz Rzutnik!",
	ACM_SELMETHOD_MINSTR_TEXT = "METODA: Minimalna Siła",
	ACM_SELMETHOD_MINSTR_MINSTR = "Minimalna Siła",
	ACM_SELMETHOD_PRISTR_TEXT = "METODA: Priorytet Siły",
	ACM_SELMETHOD_MAXMAX_TEXT = "METODA: Maksimum",
	ACM_SELMETHOD_MAXMAX_MAXMAX = "Konsola aktywna.\n\n Wciśnij Ctrl + 8.",
	ACM_START = "START",
	ACM_STOP = "STOP",
	ACM_VIEW = "Rozłożenie punktów",
	ACM_FLATTEN = "RÓWNE",
	ACM_MINIMUM = "MINIMALNE",
	RG_CLASS_BUTTON = "KLASA",
	RG_PROFS_BUTTON = "STATYSTYKI BOJOWE",
	RG_OVERVIEW = "PODGLĄD",
	RG_RECORD = "Karta postaci",
	RG_UI_TITLE = "Ustawienia UI",
	RG_UI_PANEL = "Panel Menu Głównego po lewej stronie",
	RG_UI_PANEL1 = "Włączenie tej opcji wyświetli Menu Główne po lewej stronie, zamiast po prawej. Może się to przydać przy używaniu własnego tłach.",
	RG_UI_JOURNAL = "Mały/Duży Dziennik - WYŁĄCZONE",
	RG_UI_JOURNAL1 = "Włączenie tej opcji przełączy między oryginalnym, a nowym, dużym ekranem dziennika. - WYŁĄCZONE",
	RG_UI_CHEAT = "Metoda oszustwa",
	RG_UI_CHEAT1 = "Włączenie tej opcji pozwoli na oszukiwanie. W menu tworzenia postaci będą dostępne opcje Rzutnika, a przytrzymanie przycisku 'Pokazania Szczegółów' odkryje mapę.",
	RG_UI_QUICKLOOT = "Domyślne włączenie/wyłączenie paska szybkiego łupu",
	RG_UI_QUICKLOOT1 = "Włączenie tej opcji sprawi, że pasek szybkiego łupu będzie zawsze włączony w trakcie zaczynania, bądź ładowania gry.",
	RG_RANDOM = "Losowa Postać",
	RG_PP_TOOLTIP = "Wybierz swój portret z listy. By uzyskać więcej informacji na temat własnych portretów naciśnij przycisk 'Inne'.",
	RG_PP_TOOLTIP1 = "By używać własnego portretu, umieść pożądany obraz w folderze 'Documents/Baldur's Gate - Enhanced Edition/portraits' (możesz być zmuszony stworzyć go samemu). Musi być zapisany w dwudziestoczterobitowym formacie BMP i posiadać nazwę nie dłuższą niż siedem liter.",
	RG_PP_TOOLTIP2 = "Standardowa rozdzielczość portretów wynosi 210x330; większe i mniejsze portrety będą przeskalowane. Żaden obraz nie może być większy niż 1024x1024.",
	RG_PP_TOOLTIP3 = "By zaktualizować listę portretów włącz ponownie komponent WeiDU 'Portrait Picker'. Dodanie prefiksu 'f#' (dla kobiet) i 'm#' (dla mężczyzn) do nazwy portretu przed uruchomieniem WeiDU automatycznie ustawi jego płeć. Portrety, które kończą się na 'm' albo 's' nie będą pojawiać się na liście. Zamiast tego, jeśli nazwa kończy się na 'l', a inny portret ma dokładnie taką samą nazwę, z wyjątkiem tego że kończy się na 'm', to ten drugi będzie użyty jako mały portret po prawej stronie. By dodać ręcznie opis i ustawić płeć, będziesz mógł użyć narzędzia 'Portrait Picker', które pojawi się wkrótce.",
	RG_PP_TOOLTIP4 = "Jeśli chcesz dodać opis domyślnego portretu, to musisz ręcznie zedytować plik M_nicks.lua znajdując po lewej stronie jego domyślną nazwę i edytując opis obok niej w cudzysłowie.",
	RG_CURRENT_QUESTS = "Aktywne zadania",
	RG_FINISHED_QUESTS = "Wykonane zadania",
	RG_TOTAL = "Całkowite",
	RG_SPELL_TOOLTIP = "Użyj lewego przycisku myszy by zapamiętać i prawego by zapomnieć.",
	RG_FILTER1 = "Filtruj postacią",
	RG_FILTER2 = "Filtruj nazwą zapisu",
	RG_FILTER3 = "Filtruj rozdziałem",
	RG_UI_SETTINGS = "Ustawienia UI",
	RG_UI_CLASSIC_DIALOG = "Classic Dialog Window",
	RG_UI_CLASSIC_DIALOG1 = "Toggling this option on will display a static dialog window in the bottom center of the screen, where you can scroll up to see the dialog history.",
	RG_UI_MPPICKER = "Multi-portrait picker",
	RG_UI_MPPICKER1 = "Toggling this option on will display a multi-portrait picker in the character generation screen, instead of default list-based portrait picker.",
	RG_UI_LPORTRAITS = "Large portraits",
	RG_UI_LPORTRAITS1 = "Toggling this option on will display bigger portraits on a main gameplay screen. Instead of default 64x91 pixels they will have 82x123 pixels. This option mainly suits unscaled interface.",
	RG_UI_THIEFBUTT = "Permanent thieving button",
	RG_UI_THIEFBUTT1 = "Toggling this option on will display a permanent thieving button in the bottom right section of the screen. This is useful for Cleric / Thiefs.",
	RG_UI_THIEFBUTT_WARN = "Requires an assigned thieving key binding.",
	RG_MENU_BG1_CAMPAIGN = "Baldur's Gate EE Campaigns",
	RG_MENU_BG1_CAMPAIGN1 = "Baldur's Gate",
	RG_MENU_BG1_CAMPAIGN2 = "Siege of Dragonspear",
	RG_MENU_BG1_CAMPAIGN3 = "Kręgi Podmroku",
	RG_MENU_BG2_CAMPAIGN = "Baldur's Gate 2 EE Campaigns",
	RG_MENU_BG2_CAMPAIGN1 = "Cienie Amn",
	RG_MENU_BG2_CAMPAIGN2 = "Tron Bhaala",
	RG_MENU_BG2_CAMPAIGN3 = "Kręgi Podmroku 2",
}