# Włączenie bieżącego kursu z zachowaniem głębi matematycznej

[English](2026-10-05-current-course-integration.md) | Polski

Status: implemented

## Problem i dostępne informacje

Notatki powinny wspierać kurs 2026–27 oraz rozumienie wystarczające do wyjaśniania
i odtwarzania matematyki. Bieżące materiały powinny ustalać zakres i priorytety
ćwiczeń; zależności matematyczne powinny wyznaczać kolejność objaśnień. Przytoczona
przez użytkownika relacja kolegi uzasadnia potrzebę czytelniejszego nauczania,
ale pozostaje informacją z drugiej ręki. Slajdy nie ustalają, co wyjaśniono ustnie.

Trzy niezależne analizy agentów dotyczyły pokrycia źródeł, głębi dydaktycznej
i organizacji repozytorium. Użytkownik zaakceptował podejście 2026-10-05.
Rozdziały pojęciowe, mapa bieżących źródeł, dodatek modelowania i pełne rozwiązania
zestawu już istnieją. Poniżej zachowano początkowe alternatywy i uzasadnienie;
wykonanie MATLAB-a było niezweryfikowane w chwili integracji; późniejsze pomyślne
wyjście użytkownika zapisano w [rejestrze weryfikacji](../../matlab-verification.pl.md).

Ścieżki źródeł są względne wobec katalogu głównego repozytorium; odwołania do stron
oznaczają strony PDF-ów.

- `../lectures-2026-27/ProgMat_w1.pdf`: 39 stron, od modelowania przez sympleks
  po zmienne sztuczne, inicjalizację dwufazową i duże M.
- `../execrices-2026-27/ProgMatc1.pdf`: dwie strony, pięć grup obejmujących 16
  podzadań albo 17 przypadków startowych po uwzględnieniu obu startów 1(f).
  Obejmuje dualność, komplementarność i sympleks dualny, których dostarczony
  wykład nie rozwija.

Wykład odpowiada głównie obecnym notatkom 02–03; zestaw wymaga też 04.
Obecne numery „Lecture 1–5” wynikają z materiałów historycznych, a nie kolejności
bieżących wykładów. Daty utworzenia PDF-ów nie ustalają dat zajęć; metadane
dostarczonego zestawu pochodzą z 2025 roku. Przyszły zakres kursu i zaliczenia pozostaje nieznany.

## Rozważane alternatywy

| Kierunek | Korzyść | Koszt lub ograniczenie |
| --- | --- | --- |
| Uporządkować główne notatki według bieżących wykładów | Bezpośrednia zgodność z wykładami | Wykład 1 skraca kilka rozdziałów pojęciowych; przebudowa przesuwa podstawy albo tworzy duży rozdział i powielenia |
| Zachować notatki i napisać pełne drugie opracowanie kursu | Dotychczasowa praca pozostaje; tygodniowe dokumenty są wygodne | Dwa omówienia tej samej matematyki wymagają równoległych poprawek |
| Zachować rozdziały pojęciowe, dodać mapę kursu i osobne rozwiązania zestawów | Zachowuje głębię i konkretyzuje przygotowanie do kursu | Wymaga utrzymywania niewielkiej mapy i precyzyjnych informacji o pokryciu |

Rekomendujemy trzeci kierunek. W razie potrzeby można później wyprowadzić z mapy
krótką tygodniową ścieżkę czytania, odsyłającą do głównych objaśnień bez ich powielania.

## Rekomendowany kierunek

Utrzymać jedno główne objaśnienie każdego pojęcia i początkowo zachować obecne
nazwy plików i odnośniki. W nawigacji opisywać numerowane notatki jako rozdziały
pojęciowe; rozważyć zmianę wyświetlanych tytułów „Lecture” na „Chapter” w późniejszej
spójnej edycji. Zachować historyczne rozszerzenia, w tym notatki 04–05, ograniczając
stwierdzenia o bieżącym kursie do tematów potwierdzonych dostarczonym wykładem lub zadaniami.

Dodać dwujęzyczny `docs/course-map-2026-27.md`, łączący strony źródeł i numery zadań
z sekcjami rozdziałów i lukami. Rozróżniać obecność na wykładzie, wymagania zadań
i dodatkowe objaśnienia. Przy rejestracji źródeł zaktualizować `docs/sources.md`,
polską wersję i nieaktualne informacje README o dostępności. Oryginały pozostają poza repozytorium.

Opracować właściwy zestaw w `notes/exercises/`, zachowując polskie polecenia,
wydrukowane dane i oryginalne numery zadań oraz dodając angielskie rozwiązania
ręczne. Dokumenty można podzielić według grup: sympleks prymalny (1), certyfikaty
i metody dwufazowe (2–3) oraz sympleks dualny i odzyskiwanie rozwiązania prymalnego
(4–5). Rozdziały teoretyczne uczą ogólnych idei; dokumenty ćwiczeniowe je stosują,
ze wskazaniem podstaw i dopasowanymi skryptami MATLAB.

Nadal stosować [przewodnik pisania](../../writing-guide.pl.md),
[politykę językową](../../language-policy.pl.md) i
[decyzję o samodzielnej treści dydaktycznej](../implemented/2026-10-04-self-contained-study-notes.pl.md).
Źródła, rozbieżności i historia uruchomień pozostają w końcowych uwagach redakcyjnych
albo `docs/`; założenia i ograniczenia matematyczne pozostają obok wyników.

## Pokrycie materiału i priorytety

Miejsca docelowe poniżej odnoszą się do `notes/lectures/`. Jest to porównanie treści
źródeł i propozycja pracy; nie stwierdza, że integracja bieżących źródeł jest już ukończona.

| Miejsce w źródle | Temat | Obecne miejsce docelowe i proponowana praca |
| --- | --- | --- |
| Wykład s. 2–8 | Produkcja i ogólne modele zasobów | 01 tok modelowania; 02 produkcja. Dodać model pięciu produktów z jednostkami i zadeklarowanymi założeniami zdolności produkcyjnej; zachować prostszy przykład geometryczny |
| Wykład s. 9 | Dieta | 02 inne schematy modelowania; wyjaśnić granice wymagań i jednostki |
| Wykład s. 10–12 | Mieszanie | Dodać bilans masy, przychód pomniejszony o koszty, ważoną twardość, założenie dodatniej produkcji i produkcję zerową do 02 lub osobnego rozdziału modelowania |
| Wykład s. 13, s. 20–24 | Liniowość, wybór celu, wiele celów, ograniczenia praktyczne | Rozwinąć 01–02 o konkretne przykłady, nieuniknione stałe a decyzje uruchomienia, cele ważone i skalowanie, ograniczenia progowe i przekształcenie max–min |
| Wykład s. 14–17 | Transport i produkcja z magazynowaniem | Rozwinąć 02: dokładne zapotrzebowanie klientów, zabronione trasy, koszty zależne od czasu i łuki do przodu w czasie |
| Wykład s. 18 | Przepływ o minimalnym koszcie | Dodać bilanse wierzchołków, przepustowości, konwencję podaży i diagram sieci |
| Wykład s. 19 | Regresja minimaksowa i minimalizacja sumy modułów reszt | Wykorzystać regresję w 02; wyjaśnić pomocnicze ograniczenia i dowolne zmienne nachylenia oraz wyrazu wolnego |
| Wykład s. 25–26 | Sprzeczne wymagania i programowanie celowe | Dodać nieujemne odchylenia, miary sumy/maksimum, uzasadnione wagi, wymagania twarde/miękkie i zmianę modelu przez relaksację |
| Wykład s. 27–30 | Standaryzacja, geometria, rola wierzchołków | Wykorzystać argumenty równoważności i wyniki o wierzchołkach/BRD z założeniami w 02; jawnie omówić zmienne niedodatnie i odtwarzanie pierwotnych celów |
| Wykład s. 31 | Slajd przejściowy z przykładami | Nie wymaga osobnego dodatku matematycznego |
| Wykład s. 32–35 | Sympleks, inicjalizacja, metoda dwufazowa i duże M | Wykorzystać wyprowadzenia i zastrzeżenia w 03; w końcowych uwagach opisać problemy indeksowania i kar w źródle |
| Wykład s. 36–39 | Przykład z równaniami i tablice ze zmiennymi sztucznymi | Ten sam przykład liczbowy jest już opracowany w 03, ze startem ze wszystkimi zmiennymi sztucznymi i innym startem; wykorzystać go |
| Zestaw s. 1, 1(a)–1(f) | Sympleks prymalny, starty, alternatywne optima, promienie wzrostu | 02 bazy/promienie i 03 sympleks/inicjalizacja; opracować wszystkie sześć zadań i oba starty 1(f) |
| Zestaw s. 1, 2(a)–2(c) | Optymalność kandydatów i komplementarność | 04 konstrukcja zadania dualnego i certyfikaty; najpierw sprawdzić dopuszczalność |
| Zestaw s. 2, 3(a)–3(b) | Zadanie dualne i rozwiązania dwufazowe | 02 dziedziny, 03 faza I/II, 04 reguły dualności dla różnych znaków |
| Zestaw s. 2, 4 | Sympleks dualny i rozwiązanie dualne | 04 wyprowadzenie sympleksu dualnego i certyfikat |
| Zestaw s. 2, 5(a)–5(d) | Rozwiązać zadanie dualne, odzyskać prymalne, ocenić alternatywne rozwiązania dualne | 04 różne dziedziny, komplementarność, wyniki i ściany optymalne; 03 inicjalizacja dwufazowa; jawnie obsłużyć wyniki wyjątkowe |

## Zachowanie i poprawa głębi

Obecną głębię warto zachować z konkretnych powodów: 02 rozwija certyfikaty ręczne,
odwzorowania równoważności, geometrię i bazy; 03 wyprowadza ceny zredukowane i test
ilorazów oraz podaje kontrprzykłady; 04 wyprowadza ograniczenia dualne i komplementarność;
05 łączy geometrię, mnożniki i wrażliwość. Jednak 01 pozostaje głównie abstrakcyjne,
a kilka schematów modelowania w 02 jest zwięzłych. Nowe źródła powinny poprawić te
części, zamiast jedynie dodać katalog wzorów.

Przy ważnych konstrukcjach podać pytanie, symbole, jednostki i założenia;
wyprowadzić równania; wyjaśnić, co zachowuje każde przekształcenie; opracować
przykład i uzasadnić wynik dowodem lub certyfikatem. Dodać geometrię i przypadki
niepowodzenia tam, gdzie pomagają. Są to składniki nauczania, a nie obowiązkowy
powtarzalny szablon. Głębia oznacza, że czytelnik umie uzasadnić metodę. Ścieżka
czytania na kurs może skrócić bieżącą pracę, zachowując dostęp do pełnych wyprowadzeń.

Przydatny pilotaż łączy standaryzację ze startem sympleksu. Udowodnić równoważność
nierówności i równania ze zmienną dopełniającą, następnie odróżnić punkty dopuszczalne
od baz dopuszczalnych. W 1(f)(i) punkt `(0,1,0)` ma zmienne dopełniające `(1,2,11)`:
cztery dodatnie współrzędne rozszerzonego układu przy trzech równaniach, więc nie
może być bazowy. W 1(f)(ii) punkt `(3,0,0)` ma zmienne dopełniające `(0,1,2)`
i dopuszcza bazę dopuszczalną. Wyjaśnić inicjalizację przed wymianami bazy.

Zachować konwencję maksymalizacji `q_j = z_j - c_j`, wyprowadzoną z
`c^T x = z0 - sum(q_j x_j)`. Wyprowadzić test ilorazów z nieujemności wzdłuż
kierunku dopuszczalnego. Zachować zastrzeżenia dotyczące kroków zdegenerowanych,
faktycznego dodatniego ruchu dla różnych alternatywnych optimów, założeń twierdzenia
o wierzchołkach i uzasadnionych kar dużego M.

Mieszanie daje kolejne konkretne objaśnienie: przy dodatniej całkowitej produkcji
twardość jest średnią ważoną masą. Mnożenie przez tę dodatnią produkcję zachowuje
kierunki nierówności i daje liniowe ograniczenia jakości. Przy produkcji zerowej
średnia jest nieokreślona; dopuszczenie zerowej produkcji jest jawną konwencją modelu.
Podobnie rozluźnienie wymagań oznacza rozwiązanie zmienionego modelu; wyjaśnić,
które ograniczenia można zmiękczyć i jak wagi porównują odchylenia w różnych jednostkach.

## Rozbieżności źródeł i wyniki matematyczne

Wykład na s. 4 podaje cztery szlifierki; s. 6–7 wykorzystują trzy i 144 godziny
tygodniowo. Cztery po 48 godzin dają 192 godziny. Zachować oba odczytania w uwagach
redakcyjnych i zadeklarować zdolność produkcyjną używaną w każdym opracowanym modelu.
Zamierzona wartość pozostaje nierozstrzygnięta.

Warunek początkowej kolumny na s. 34 wykładu używa indeksów wierszowych tam,
gdzie potrzebny jest warunek kolumnowy. Wyjaśnić poprawny warunek i normalizację.
Twierdzenia na s. 35 o dużym M i zmiennych sztucznych wymagają zastrzeżeń dotyczących
kar, już obecnych w 03. Zachować je przy uzgadnianiu źródeł. Tablice zapisane jako
obrazy na s. 37–39 sprawdzono wizualnie; wydobywanie tekstu je pomija.

Zachować podanych kandydatów: `(0,0,6)` z 1(e) narusza `x1 = 6`, a `(2,0,-2)`
z 2(b) narusza nieujemność i trzecią nierówność. Zadanie 1 dopuszcza podany start
tylko wtedy, gdy jest możliwy; zadanie 2 pyta, czy kandydat jest optymalny. Mogą
to być celowe sprawdziany. Odrzucać niedopuszczalne starty/kandydatów bez zakładania literówek.

Dwa wydrukowane zadania uniemożliwiają też spełnienie ogólnego polecenia grupy 5,
które wymaga optymalnych rozwiązań dualnych:

- **5(a):** `x(t) = (-2-t,0,0)`, `t >= 0`, jest dopuszczalne i ma cel
  `-6-3t`, nieograniczony z dołu. Zadanie dualne wymaga `-(y1+y2+y3+y4) >= 3`
  przy `y >= 0`, co jest niemożliwe.
- **5(c):** `x(t) = (-5-t,-t,0)`, `t >= 0`, jest dopuszczalne i ma cel
  `5-4t`, nieograniczony z dołu. Zadanie dualne wymaga `y1+y2+y3 = 1` i
  `-y1+y3-y4 = 5` przy `y >= 0`; lewa strona drugiego równania jest najwyżej równa 1.

Te promienie i nierówności kierunkowe niezależnie sprawdzono w dokładnej arytmetyce
całkowitoliczbowej podczas tego przeglądu. Ustalają wyniki dla wydrukowanych danych;
intencja pozostaje nieznana. Przyszłe rozwiązania powinny podać certyfikaty i wyjaśnić,
dlaczego wymagane optimum nie istnieje, zachowując oryginalne polecenia.

## Kolejność wdrożenia i kryteria akceptacji

1. **Rejestracja źródeł i nawigacja.** Ująć oba PDF-y w wykazie, stworzyć dwujęzyczną
   mapę kursu i zaktualizować informacje o dostępności. Każdy temat wykładu i wszystkie
   16 podzadań muszą mieć miejsce docelowe lub jawną lukę; nieznane daty pozostają nieznane.
2. **Pilotaż dydaktyczny.** Opracować oba starty 1(f) i ich rozwiązania ręczne.
   Czytelnik powinien umieć uzasadnić inicjalizację, znaki, wymiany bazy i wynik końcowy.
3. **Ukończenie zestawu 1 grupami.** Opracować 1, następnie 2–3, potem 4–5, korzystając
   z mapy podstaw. Zachować oryginalne polecenia, dokładne rozumowanie ręczne,
   wymagane argumenty o promieniach/alternatywach oraz poprawne certyfikaty
   dopuszczalności i optymalności. Wyjaśnić wyniki wyjątkowe, w tym 5(a) i 5(c).
4. **Rozwinięcie potwierdzonych luk modelowania.** Zacząć od mieszania, potem sieci
   i produkcji z magazynowaniem, następnie wyboru celu i miękkich ograniczeń.
   Wyprowadzić każdy model z założeniami i jednostkami, opracować przykład oraz
   zaktualizować mapę i uwagi o źródłach. Podzielić rozdział pojęciowy dopiero wtedy,
   gdy jego rozmiar utrudnia naukę.

Przy zmianach matematycznych podawać odnośniki do rzeczywistych skryptów MATLAB
i porównywać te same dane i tolerancje. Odróżniać dokładne rozumowanie, przegląd
statyczny i faktyczne wykonanie; rzetelnie oznaczać nieuruchomione skrypty.
Korzystać z obecnego przeglądu tłumaczeń, formatowania TeX, `./build.sh`, rejestru
budowania PDF-ów i sprawdzeń wyników. Przejrzeć diagramy w skompilowanych PDF-ach.
Ta propozycja nie wymaga nowych narzędzi.

## Założenia, ryzyka i zakres

Priorytetami są dogłębne osobiste zrozumienie i praktyczne przygotowanie do kursu.
Sprawdzić równowagę w pilotażu: odtworzyć metodę i znaleźć jej podstawy bez wcześniejszego
czytania wszystkich rozszerzeń. Dostępne są tylko jeden bieżący wykład i zestaw;
przyszła kolejność, laboratoria i nacisk na zaliczeniu pozostają nieznane.
Aktualizować mapę wraz z kolejnymi materiałami.

Mapa może się zdezaktualizować, a rozwiązania zestawów mogą powielać teorię.
Aktualizować wiersze przy każdej integracji i zachować ogólne wyprowadzenia w głównych
rozdziałach. Unikać rozwijania wszystkich historycznych tematów przed uzupełnieniem
potwierdzonych luk i potrzeb ćwiczeniowych.

Nie proponujemy drugiego podręcznika, obowiązkowych pełnych polskich rozdziałów,
nowego systemu solverów, zmiany nazw całego repozytorium ani usuwania historycznej
głębi. Obecne decyzje o języku, przechowywaniu źródeł, treści dydaktycznej i budowaniu
nadal obowiązują.

## Wdrożenie w dniu 2026-10-05

Wykaz źródeł i oba README opisują teraz dostarczone bieżące materiały.
Dwujęzyczna mapa kursu łączy każdy temat wykładu i wszystkie 16 podzadań
z rzeczywistymi objaśnieniami i rozwiązaniami ręcznymi. Wyświetlane tytuły
wskazują rozdziały 1–5, zachowując dotychczasowe ścieżki źródeł.

Rozdział 1 dodaje fabrykę pięciu produktów i rozwiązuje oba warianty zdolności
szlifowania. Rozdział 2 rozwija dietę, regresję i przekształcenia. Osobny dodatek
ze schematami modelowania rozwija mieszanie, transport z ograniczeniami tras,
produkcję z magazynowaniem, przepływ o minimalnym koszcie, cele i relaksację wymagań.
Obecne dowody geometryczne i rozdziały 3–5 zachowują swoją głębię.

Trzy dokumenty ćwiczeniowe obejmują grupy 1, 2–3 i 4–5, w tym oba starty 1(f),
45 przedstawionych tablic, pełne certyfikaty i wyniki wyjątkowe dla wydrukowanych
danych. Cztery skrypty podstawowego MATLAB-a sprawdzają te same dane. Niezależne
przeglądy dokładnej arytmetyki i statyczne przeszły; problem uruchamiania uniemożliwia
faktyczne wykonanie MATLAB-a. [Rejestr weryfikacji](../../matlab-verification.pl.md)
zachowuje to ograniczenie. Pochodzenie i sprzeczności źródeł pozostają w końcowych
uwagach i dokumentacji, a założenia matematyczne obok treści dydaktycznej.
