# Mapa kursu 2026–27

[English](course-map-2026-27.md) | Polski

## Zakres i ścieżki czytania

Mapa obejmuje dostarczone `ProgMat_w1.pdf`, `ProgMatc1.pdf` i odręczny
`lecture_19_10_2026.pdf` (19 października 2026), dwa dostarczone zadania z laboratorium 2
oraz potwierdzone tematy laboratorium 3. Ścieżki źródeł,
pochodzenie i rozbieżności opisuje [wykaz źródeł](sources.pl.md). Numery stron
oznaczają strony PDF-ów. Numery rozdziałów opisują pojęciowy tok notatek;
są niezależne od numerów bieżących wykładów i zestawów. Wszystkie poniższe tematy
i zadania mają opracowane objaśnienia lub rozwiązania ręczne. Przyszły zakres kursu,
szczegółowe wymagania zaliczeniowe i późniejsze laboratoria pozostają nieznane. Odręczne notatki ustalają
datę wykładu 19 października; daty zajęć ze slajdów pozostają nieznane.

Do modelowania przeczytaj [rozdział 1](../output/lectures/01-optimization-modeling.pdf),
sekcje modelowania w [rozdziale 2](../output/lectures/02-linear-programming.pdf),
następnie [schematy modelowania](../output/lectures/02a-linear-modeling-patterns.pdf).
Do pierwszego zestawu przejdź przez postać standardową, geometrię i bazy w rozdziale 2,
[rozdział 3](../output/lectures/03-simplex-method.pdf) oraz potrzebne sekcje
[rozdziału 4](../output/lectures/04-degeneracy-and-duality.pdf). Odręczne notatki
potwierdzają cykle, perturbację, regułę Blanda, dualność i komplementarność jako
bieżące tematy. Złożoność w rozdziale 4 oraz
[rozdział 5](../output/lectures/05-sensitivity-and-lagrange-multipliers.pdf) pozostają
rozszerzeniami; dostarczone bieżące materiały nie potwierdzają ich jako wymagań.

## Dostarczone zadania z laboratorium 2

Przeczytaj [Laboratorium 2: rozkłady i dostawy kurierskie](../output/labs/02-linear-programming.pdf)
po sekcjach modelowania w rozdziałach 1–2. Jednostronicowe zadania
`Sam2Gr1.pdf` i `Sam2Gr5.pdf` opracowano w całości: limity prawdopodobieństw,
wspólna górna granica wartości oczekiwanych, koszt podróży zależny od ładunku
i niedopuszczalne ładunki początkowe. Odpowiadające skrypty to
`matlab/labs/lab_02_probability.m` i `matlab/labs/lab_02_courier.m`.
Oba zapisują ograniczenia zmiennych jako wiersze macierzy i zawierają wykresy
słupkowe. Ich faktyczne wykonanie w MATLAB-ie pozostaje niezweryfikowane.
Laboratorium 3 nie zostało rozpoczęte; skopiowany skrypt nie potwierdza zakresu zadań.

## Zapowiedziane laboratorium 3 i samodzielny trening

Potwierdzone tematy laboratorium 3 to sympleks i postać standardowa.
Dokładne bieżące zadanie, wymagana implementacja, toolbox i data laboratorium
pozostają niepotwierdzone.

Ścieżka przygotowania:

1. Przeczytaj przekształcenia do postaci standardowej w rozdziale 2 oraz
   równania kanoniczne, test ilorazów i inicjalizację w rozdziale 3.
2. Przejdź przez [rozwiązany przykład](../output/labs/03-simplex-demo.pdf) i
   `matlab/labs/lab_03_demo.m`: dwie ręczne wymiany, ścieżkę geometryczną oraz
   niezależne wywołania solvera dla postaci oryginalnej i standardowej.
3. Rozwiąż [cztery próbne laboratoria](../output/labs/03-simplex-practice.pdf), zanim
   otworzysz [klucz odpowiedzi](../output/labs/03-simplex-answers.pdf) lub
   `matlab/labs/lab_03_practice_answers.m`.

Wymyślone zadania obejmują start z luzami, fazę I, zmienne swobodne i ze znakiem,
stałe w celu oraz przypadki skończonego/niejednoznacznego optimum,
sprzeczności i nieograniczoności. Sugerowane czasy i punkty służą treningowi.
Ocenianie wszystkich tych rozszerzeń pozostaje niepotwierdzone.
Sprawdzenia toolboxem używają `dual-simplex-highs`; ich faktyczne wykonanie
w MATLAB-ie pozostaje niezweryfikowane.

## Dostarczony wykład 1

| Strony PDF | Materiał dostarczonego wykładu | Opracowane objaśnienie |
| --- | --- | --- |
| 1 | Tytuł i autorstwo | Wykaz źródeł; bez wnioskowania o dacie zajęć |
| 2–8 | Fabryka pięciu produktów i ogólny model zasobów | Rozdział 1, „A concrete model”; rozdział 2, „Production planning”. Jawne rozwiązania dla obu zdolności szlifowania |
| 9 | Dieta z granicami składników i ilości żywności | Rozdział 2, „Diet problem”, z ręcznym certyfikatem dolnego ograniczenia |
| 10–12 | Mieszanie olejów, zdolności, jakość, zysk | Schematy modelowania, „Blending”, z wyprowadzeniem ilorazu, konwencją zerowej produkcji i dokładnym optimum |
| 13 | Liniowość i decyzje | Rozdział 1, założenia; rozdział 2, definicja PL; schematy modelowania, „Building an LP” |
| 14–15 | Transport i zabronione trasy | Rozdział 2, transport ogólny; schematy modelowania, przykład dokładnego popytu i certyfikat ręczny |
| 16–17 | Produkcja, zmiany i magazynowanie między miesiącami | Schematy modelowania, „Production with storage”, sieć do przodu w czasie i optymalny plan |
| 18 | Przepływ o minimalnym koszcie | Schematy modelowania, bilanse wierzchołków, znaki macierzy incydencji i przykład sieci |
| 19 | Regresja minimaksowa i minimalizacja sumy modułów reszt | Rozdział 2, „Regression as a linear program”, z różnymi rozwiązaniami ręcznymi |
| 20–22 | Wybór celu, dopuszczalność i stałe koszty | Rozdział 1, dopuszczalność/optymalność; schematy modelowania, stałe celu, decyzje uruchomienia i przykład jednopunktowy |
| 23 | Wiele celów | Schematy modelowania, sumy ważone, ograniczenia progowe, skalowanie i wyprowadzenie max–min |
| 24 | Rodzaje ograniczeń praktycznych | Tok modelowania w rozdziale 1 oraz modele produkcji, diety, mieszania i sieci |
| 25–26 | Sprzeczne wymagania i minimalizacja odchyleń | Schematy modelowania, wymagania twarde/miękkie, odchylenia ważone i maksymalne, różnica wobec fazy I |
| 27–29 | Postać standardowa i przekształcenia | Rozdział 2, „Standard form and equivalent transformations”, z odtwarzaniem znaków i zmiennymi niedodatnimi |
| 30 | Intuicja wierzchołków | Rozdział 2, geometria, zastrzeżenia o wynikach, twierdzenie o wierzchołkach i równoważność BRD |
| 31 | Slajd przejściowy z przykładami | Brak samodzielnej treści matematycznej |
| 32–33 | Wskaźniki sympleksu, reguły wejścia/wyjścia i wymiany | Rozdział 3, równania kanoniczne, kierunki dopuszczalne, test ilorazów i operacje wierszowe |
| 34–35 | Baza początkowa, zmienne sztuczne, faza I/II i duże M | Rozdział 3, inicjalizacja i duże M, z zachowaniem zastrzeżeń o indeksach kolumn i karach |
| 36–39 | Przykład z równaniami i czterema zmiennymi | Rozdział 3, „Two different Phase I starts”; ten sam przykład liczbowy i ścieżka tablic zapisanych jako obrazy |

Wykład potwierdza obecność tematów na slajdach. Nie ustala, czy pełne dowody,
przykłady i kontrprzykłady dodane do notatek przedstawiono ustnie.

## Odręczne notatki z wykładu: 19 października 2026

Wszystkie dziesięć stron z BOOX-a przejrzano wizualnie. Najpierw przeczytaj
wskaźniki i test ilorazów z rozdziału 3, następnie poniższe sekcje
[rozdziału 4](../output/lectures/04-degeneracy-and-duality.pdf).
To sekcje pojęciowe, a nie nowy numerowany dokument wykładu.

| Strony PDF | Zapisany temat | Miejsce do czytania i wynik |
| --- | --- | --- |
| 1 | Cykle, wybór zmiennych wchodzących/wychodzących, perturbacja symboliczna | „Degeneracy” i „Perturbation and lexicographic tie-breaking”; zerowe kroki mogą zmieniać bazę bez poprawy pierwotnego celu |
| 2 | Przykład perturbacji z dwiema zmiennymi | „A zero-ratio tie resolved by symbolic right-hand sides”; obie tablice po wymianach, porównania ilorazów symbolicznych, graniczne optimum `(0,0)`, wartość `0` |
| 3 | Reguła Blanda, skończone zakończenie, ograniczenia ważone | „Bland's rule and its complete path”; „A weighted bound and paired primal–dual tableaus”; pełny Bland wymaga obu reguł indeksów |
| 4–5 | Definicja dualu, słaba/silna dualność, dual dualu | „Constructing the dual problem” i „Weak duality, strong duality, and possible outcomes”; cel dualny to `b^T y`, z `m` składnikami |
| 6–8 | Transpozycja słowników i powiązane wymiany prymalne/dualne | „A weighted bound and paired primal–dual tableaus”; prymalne `(0,1/4,13/4)`, dualne `(1,3)`, wspólna wartość `10` dla prawej strony `(1,3)` |
| 8–9 | Komplementarność i dowód | „Complementary slackness”; punkty dopuszczalne są optymalne dokładnie wtedy, gdy wszystkie iloczyny komplementarne znikają |
| 9–10 | Kandydat `(2,1,1,0,0)` | „Certifying a supplied candidate without running simplex”; istniejący przykład, wartość `8`, dual `(1,2,0)`, zachowany cały odcinek optymalny |
| 10 | Wybór dualu ze względu na dopuszczalną bazę luzów | „Solving the dual when its slack start is feasible”; dwie wymiany sympleksu prymalnego na przekształconym dualu, prymalne `(7,0)`, dualne `(0,0,1)`, pierwotna wartość `-7` |

Końcowe uwagi rozdziału 4 zapisują rozbieżności rękopisu: pojedynczą prawą stronę
`8` na stronie 6 wobec `3` w słownikach i kolejnych tablicach; końcowy współczynnik
perturbacji; oraz rachunki wierszy na stronie 10. Wariant prawej strony `8`
również rozwiązano w tych uwagach (wartość `25`). Ostatnia strona stosuje sympleks
prymalny do przekształconego dualu; to inna metoda niż algorytm sympleksu dualnego.
Nowe tablice wymian i certyfikaty przeszły niezależne sprawdzenie w dokładnej
arytmetyce wymiernej. Istniejącego skryptu MATLAB nie rozszerzano ani nie
uruchamiano ponownie dla tych dodatków.

## Dostarczony zestaw 1

Trzy dokumenty zachowują oryginalne polskie polecenia i dane:

- [Sympleks prymalny: grupa 1](../output/exercises/01-primal-simplex.pdf)
  ([źródło](../notes/exercises/01-primal-simplex.tex)).
- [Komplementarność i metoda dwufazowa: grupy 2–3](../output/exercises/01-complementarity-and-two-phase.pdf)
  ([źródło](../notes/exercises/01-complementarity-and-two-phase.tex)).
- [Sympleks dualny i odzyskiwanie rozwiązania prymalnego: grupy 4–5](../output/exercises/01-dual-simplex-and-recovery.pdf)
  ([źródło](../notes/exercises/01-dual-simplex-and-recovery.tex)).

| Zadanie | Potrzebne idee i podstawy | Wynik ręczny dla wydrukowanych danych |
| --- | --- | --- |
| 1(a) | Rozdział 3, zwykłe wymiany i certyfikat jednoznaczności | Jedyne `(1/3,11/3,4)`, maksimum `46/3` |
| 1(b) | Rozdział 3, wymiany i skończony cel na nieograniczonym zbiorze | Jedyne `(0,1,2)`, maksimum `5` |
| 1(c) | Rozdział 3, faktyczne ruchy o zerowym koszcie i ściany optymalne | `(t,6+2t,8)`, `0 <= t <= 2`, maksimum `36` |
| 1(d) | Rozdziały 2–3, znaki zmiennych nadwyżkowych i podana baza | `(8-2t,t,0)`, `2 <= t <= 4`, maksimum `8` |
| 1(e) | Rozdział 3, odrzucenie niedopuszczalnego startu i promień wzrostu | Podany start narusza `x1=6`; promień dopuszczalny `(6,0,4)+t(0,0,1)`, wartość `16+t` |
| 1(f), i oraz ii | Rozdziały 2–3, punkt dopuszczalny a BRD, inicjalizacja i promień | Pierwszy start jest dopuszczalny, ale niebazowy; obie ścieżki dają `(6,0,1)+t(5,0,2)`, wartość `33+24t` |
| 2(a) | Rozdział 4, dopuszczalność i komplementarny certyfikat dualny | Kandydat optymalny, maksimum `7`, dualne `(3,0,2,0)` |
| 2(b) | Rozdział 4, dopuszczalność przed optymalnością | Kandydat niedopuszczalny; faktyczne optimum `(2,0,2)`, minimum `6`, dualne `(0,9/2,6)` |
| 2(c) | Rozdział 4, różne znaki wierszy i komplementarność | Kandydat optymalny, maksimum `1`; dualne `(-1,0,2)` i odcinek optimów prymalnych |
| 3(a) | Rozdziały 3–4, różne wiersze, konstrukcja dualna i faza I/II | `(0,3,0)`, maksimum `-6`, dualne `(0,0,-1)`; alternatywy opisane w rozwiązaniu |
| 3(b) | Rozdziały 2–4, zmienna niedodatnia, ujemna prawa strona, odtworzenie znaków | `(3/2,0,-5/2)`, minimum `1/2`, dualne `(3/2,0,1/2)`; promień optymalny |
| 4 | Rozdział 4, wymiany zachowujące dopuszczalność dualną i odzyskiwanie cen | Jedyne `(3,0,2,0)`, minimum `7`; dualne `(0,3,1)` |
| 5(a) | Rozdziały 3–4, zmienna niedodatnia i certyfikat sprzeczności | Prymalne nieograniczone z dołu; dualne sprzeczne; minimum sumy sztucznych w fazie I `3` |
| 5(b) | Rozdziały 3–4, zmienna dowolna, dwufazowe dualne i odzyskiwanie prymalnego | Prymalne `(3,-6,7)`, minimum `-44`; jedyne dualne `(31/4,0,15/2,9)` |
| 5(c) | Rozdziały 3–4, dwie zmienne dowolne i sprzeczne równania dualne | Prymalne nieograniczone z dołu; dualne sprzeczne; minimum sumy sztucznych w fazie I `4` |
| 5(d) | Rozdziały 3–4, zmienna dowolna, faza II i komplementarność | Prymalne `(0,-8,5)`, minimum `80`; jedyne dualne `(0,18,0,5)` |

Parametry promieni są nieujemne, chyba że podano przedział. Zestaw ustala wymagania
ćwiczeń, a nie wcześniejsze omówienie na wykładzie 1. W szczególności grupy 2–5
wymagają dualności, której dostarczony wykład nie rozwija.
Niedopuszczalni kandydaci mogą być celowymi sprawdzianami. Ogólnego polecenia grupy 5
o optymalnych rozwiązaniach dualnych nie można spełnić dla 5(a) i 5(c) w wydrukowanej
postaci; rozwiązania podają odpowiednie certyfikaty sprzeczności i nieograniczoności.

## Dodatkowe podstawy i opcjonalna lektura

[Przegląd notatek i przewodnik dalszej nauki](notes-review.pl.md) rejestruje
całościowy przegląd, siedem nowych rysunków TikZ i dalsze kierunki. Dodane podstawy
obejmują osiąganie optimum i wypukłość (rozdział 1), relaksacje całkowitoliczbowe
(rozdział 2), przekroje i całkowitoliczbowość sieci oraz kompromisy w przestrzeni
kryteriów (schematy modelowania), zrewidowany sympleks (rozdział 3), alternatywę
Farkasa i certyfikaty numeryczne (rozdział 4), a także kwalifikacje nieliniowych KKT
oraz wstęp do bariery/ścieżki centralnej (rozdział 5). Ich zgodność z bieżącym
kursem jest nieznana; obecność tych tematów nie zmienia powyższych wymagań
wynikających z dostarczonego wykładu i zestawu.

Objaśnienia PL pozostają głównymi podstawami. Gładkie algorytmy nieliniowe, pełna
teoria drugiego rzędu, ogólne algorytmy całkowitoliczbowe, metody niegładkie
oraz optymalizacja przy niepewności są nadal kierunkami dalszej nauki, a nie
w pełni rozwiniętymi rozdziałami. Przewodnik podaje podstawy i konkretne kroki,
zamiast przypisywać zakres na podstawie historycznej mapy.

## Weryfikacja i utrzymanie

Każdy dokument ćwiczeniowy wskazuje rzeczywisty dopasowany skrypt MATLAB. Przykłady
modelowania korzystają ze wspólnego [modeling_patterns_checks.m](../matlab/exercises/modeling_patterns_checks.m).
Certyfikaty ręczne i dokładna weryfikacja wymierna uzasadniają podaną matematykę.
Faktyczne wykonanie MATLAB-a zapisujemy osobno w [rejestrze weryfikacji](matlab-verification.pl.md).
Aktualizować mapę, uwagi o źródłach i oba języki wraz z nowymi materiałami;
zachować niepewność przyszłej zgodności zamiast wnioskować z dawnych wykładów.

## Wizualne oznaczenia wykładu

Kremowe ramki `lecturecore` w rozdziałach 1–4 i Schematach modelowania oznaczają
wybrane modele, wzory i twierdzenia bezpośrednio potwierdzone przez bieżące źródła
wykładowe zmapowane powyżej (23 bloki). Każdy dokument ma legendę. Dowody,
rozwiązania i inne dodatki poza ramkami nadal objaśniają materiał bez twierdzenia,
że dokładnie te szczegóły zapisano na zajęciach. Rozdział 5 nie ma takich oznaczeń,
ponieważ jego zgodność z wykładem pozostaje niepotwierdzona. Osobne kolory komórek
w powiązanych tablicach rozdziału 4 śledzą role matematyczne, w tym współczynniki
celu, prawe strony i odzyskane rozwiązania prymalne/dualne.
