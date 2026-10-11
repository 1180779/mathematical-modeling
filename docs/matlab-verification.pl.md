# Weryfikacja MATLAB-a

[English](matlab-verification.md) | Polski

## Wykonanie 2026-10-04

Użytkownik uruchomił poniższe polecenie w zwykłym terminalu z katalogu głównego
repozytorium i przekazał jego wynik. MATLAB podał wersję 26.2.0.3386108 (R2026b).
Nie było to wykonanie przez agenta w sandboxie.

```sh
matlab -batch "disp(version); run('matlab/exercises/lecture_02_checks.m'); run('matlab/review/arrays_and_linear_systems.m')"
```

```text
26.2.0.3386108 (R2026b)
Production: x = (2, 6), revenue = 18 PLN
5.2 m cutting: counts = (200, 0, 400), offcut = 140 m
2 m cabinets: 11 boards; one enumerated plan = (10, 1, 0)
All numerical refresher assertions passed.
Plot exported to /home/rdkgsk/Documents/Studies/masters/sem2/progmat/mathematical-modeling/matlab/output/01-quadratic-review.png
```

## Zakres i ograniczenia

Asercje wykładu 2 sprawdzają wierzchołki produkcji, bazę optymalną, luzy,
certyfikat cięcia i wyliczenie planów szafek przy opisanych założeniach.
Powtórka sprawdza tablice, indeksowanie, operatory, układ liniowy, wektoryzację
i eksport wykresu. Nie uruchomiono solverów Optimization Toolbox.

Początkowa próba ujawniła błędne nazwy skryptów z łącznikami lub początkową cyfrą.
Poprawiono je przed udanym wykonaniem. Launcher agenta nadal kończy się kodem 1
bez komunikatu, nawet po zalogowaniu użytkownika; przyczyna pozostaje nieustalona.
Wyniki z normalnego terminalu potwierdzają działanie skryptów i instalacji MATLAB-a.

## Sprawdzenia wykładu 3 w dniu 2026-10-04

Nowy skrypt `matlab/exercises/lecture_03_checks.m` obejmuje kandydatów na
rozwiązania bazowe, trzy kroki ścieżki produkcji i alternatywny start, promień
nieograniczoności, oba warianty startu dwufazowego, zdegenerowane kroki zerowe,
sprzeczność, poprawne rozwiązanie metodą dużego M i kontrprzykład ze skończoną karą.
Wystarcza podstawowy MATLAB.

```sh
matlab -batch "run('matlab/exercises/lecture_03_checks.m')"
```

**Wykonanie w MATLAB-ie: pomyślne.** Użytkownik uruchomił to polecenie w zwykłym
terminalu z katalogu głównego repozytorium w dniu 2026-10-04 i przekazał poniższe
wyjście. Wszystkie asercje przeszły, także te bez osobnych komunikatów podsumowujących.
Nie było to wykonanie przez agenta w sandboxie. To polecenie nie wypisało wersji
MATLAB-a; wcześniejsze uruchomienie użytkownika wskazało R2026b.

```text
Production: revenue sequence = 0, 12, 16, 18 PLN
Unbounded ray: Ad = 0, d >= 0, objective slope = 2
Two-phase: both starts give x = (7/8, 0, 0, 1/8), z = -11/8
Infeasible original inequalities: Phase I optimum w = 1
All Lecture 3 numerical assertions passed.
```

Przed udanym wykonaniem przez użytkownika próba agenta w sandboxie zakończyła się
kodem 1 bez wyjścia; próba samego odczytu wersji zachowała się tak samo. Problem
startu w sandboxie pozostaje nieustalony, ale wykonanie w zwykłym terminalu
potwierdza działanie skryptu wykładu 3. Powyższe udane uruchomienia wykładu 2
i powtórki pozostają ważne.

**Analiza statyczna: pomyślna.** Zainstalowany analizator R2026b zakończył pracę
bez komunikatów diagnostycznych:

```sh
/usr/local/MATLAB/R2026b/bin/glnxa64/mlint -id matlab/exercises/lecture_03_checks.m
```

**Niezależna weryfikacja matematyczna: pomyślna.** Tymczasowe obliczenia w Pythonie
na dokładnych ułamkach z biblioteki standardowej odtworzyły wszystkie rozwiązane
tablice metodą eliminacji Gaussa–Jordana i sprawdziły dokładnie reszty równań.
Pełne wyliczenie baz dało pięć wierzchołków produkcji z maksimum 18 oraz cztery
bazy dopuszczalne przykładu równościowego z jedynym optimum −11/8. Potwierdziło
też optimum fazy I równe 1 w przykładzie sprzecznym i optimum kary −10 z dodatnią
zmienną sztuczną przy K = 100, M = 10. Sprawdzenia te potwierdzają wyniki ręczne,
a nie wykonanie skryptu MATLAB. Skrypt niezależnie oblicza każdą bazę i porównuje
aktualizacje tablic z kolejnym rozwiązaniem układu liniowego. Dokładnie sprawdzono
też wiersze wskaźników z łączną karą dużego M przy M = 10, uzyskując to samo
optimum zadania równościowego z zerowymi zmiennymi sztucznymi.

## Sprawdzenia wykładu 4 w dniu 2026-10-04

Skrypt `matlab/exercises/lecture_04_checks.m` wymaga tylko podstawowego MATLAB-a.
Sprawdza cały cykl, regułę Blanda i ścieżkę leksykograficzną, wszystkie osiem
wierzchołków przykładu Klee–Minty'ego, parę o mieszanych znakach, ceny zasobów
produkcji i zakres zmian prawej strony, komplementarność, odcinek optimów,
jeden krok dualnej metody sympleks, błędny wybór wymiany i certyfikat sprzecznego wiersza.

```sh
matlab -batch "disp(version); run('matlab/exercises/lecture_04_checks.m')"
```

**Wykonanie w MATLAB-ie: pomyślne.** Użytkownik uruchomił polecenie w zwykłym
terminalu z katalogu głównego repozytorium i przekazał poniższy wynik.
MATLAB podał wersję 26.2.0.3386108 (R2026b). Wszystkie asercje przeszły;
nie było to wykonanie przez agenta w sandboxie.

```text
26.2.0.3386108 (R2026b)
Cycling: six zero steps return to the initial basis
Anti-cycling: Bland = 6 pivots, lexicographic = 2, optimum = 5/4
Klee-Minty: 8 vertices, 7 pivots, maximum = 125
Production: dual y = (1, 1/3, 0), value = 18; RHS interval [-2, 2]
Complementarity: candidate and optimal segment have minimum = 8
Dual simplex: one pivot, minimum = 5, dual y = (0, 1/2)
Infeasibility: h*A >= 0 and h*b = -1 certify the contradictory row
All Lecture 4 numerical assertions passed.
```

Próba agenta w sandboxie zakończyła się kodem 1 bez wyjścia. Przyczyna startu
pozostaje nieustalona; poprawne wykonanie w zwykłym terminalu potwierdza skrypt.

**Analiza statyczna: pomyślna.** Zainstalowany analizator R2026b nie zgłosił uwag:

```sh
/usr/local/MATLAB/R2026b/bin/glnxa64/mlint -id matlab/exercises/lecture_04_checks.m
```

**Niezależna weryfikacja matematyczna: pomyślna.** Tymczasowe obliczenia w Pythonie
na dokładnych ułamkach z biblioteki standardowej odtworzyły wszystkie rozwiązane
ścieżki, wiersze wskaźników i certyfikaty. Dokładna mała perturbacja dała te same
dwie wymiany leksykograficzne z dodatnimi krokami w zadaniu zaburzonym. Pełne
wyliczenie baz potwierdziło osiem różnych wierzchołków z maksimum 125.
Sprawdzono również zakres zmiany prawej strony, parę o mieszanych znakach oraz
parametryzację odcinka optimów. Wyniki są zgodne z rozwiązaniami ręcznymi.

## Sprawdzenia wykładu 5 w dniu 2026-10-04

Skrypt `matlab/exercises/lecture_05_checks.m` wymaga tylko podstawowego MATLAB-a.
Sprawdza zakresy zmian i ich końce, funkcję wartości, łączne zmiany prawej strony
i kosztów z wyrazem mieszanym, wymiany po dodaniu kolumny i wiersza, usuwanie
zmiennych i ograniczeń oraz jednoznaczny certyfikat KKT. Dla małych zadań o skończonym
optimum enumeracja baz porównuje wyniki. Promienie i sprzeczne wiersze mają
osobne certyfikaty; enumeracja nie jest ogólnym testem nieograniczoności.

```sh
matlab -batch "disp(version); run('matlab/exercises/lecture_05_checks.m')"
```

**Wykonanie w MATLAB-ie: pomyślne.** Użytkownik uruchomił polecenie w zwykłym
terminalu z katalogu głównego repozytorium i przekazał dokładnie poniższy wynik.
MATLAB podał wersję 26.2.0.3386108 (R2026b). Wszystkie asercje przeszły.

```text
26.2.0.3386108 (R2026b)
Sensitivity: RHS change [-50/3, 22]; cost endpoints = -3/2, 2, 2/5
Simultaneous RHS changes: separately feasible, combined basic slack = -9
Vector updates: new-cost value = 64/3; new-RHS value = 6; joint value = 12
Added column: x1 = 16, x6 = 10, value = 42
Added row: x = (10/3, 0, 8/3), value = 28/3
Deletions: x1 removal gives 6; production row 3 gives 18, row 1 gives 20
KKT: multiplier signs, stationarity, complementarity; unique maximum = 37/2
All Lecture 5 numerical assertions passed.
```

Próba agenta w sandboxie zakończyła się kodem 1 bez wyjścia; przyczyna startu
pozostaje nieustalona. Zapis dotyczy wykonania przez użytkownika.

**Analiza statyczna: pomyślna.** Zainstalowany analizator R2026b nie zgłosił uwag:

```sh
/usr/local/MATLAB/R2026b/bin/glnxa64/mlint -id matlab/exercises/lecture_05_checks.m
```

**Niezależna weryfikacja matematyczna: pomyślna.** Tymczasowe obliczenia w Pythonie
na ułamkach z biblioteki standardowej odtworzyły tablice, zakresy, końce przedziałów,
zmiany strukturalne i certyfikat KKT. Pełna enumeracja małych baz potwierdziła
wartości skończonych optimów, obie gałęzie funkcji wartości i brak dopuszczalnych
baz w sprzecznych przykładach. Dowody ręczne oddzielnie uzasadniają sprzeczność
i nieograniczoność tam, gdzie sama enumeracja by nie wystarczyła.

## Integracja bieżącego kursu w dniu 2026-10-05

Cztery nowe skrypty podstawowego MATLAB-a towarzyszą zmienionym rozdziałom
pojęciowym i wszystkim 16 podzadaniom pierwszego dostarczonego zestawu
(w tym obu startom 1(f)):

```matlab
run('matlab/exercises/modeling_patterns_checks.m')
run('matlab/exercises/sheet_01_primal_simplex.m')
run('matlab/exercises/sheet_01_complementarity_and_two_phase.m')
run('matlab/exercises/sheet_01_dual_simplex_and_recovery.m')
```

**Wykonanie MATLAB-a w chwili integracji: niezweryfikowane.** Próba agenta
uruchomienia samego wypisania wersji, `matlab -batch 'disp(version)'`, zakończyła
się kodem 1 bez wyjścia. Nie zapisano wtedy pomyślnego wykonania tych czterech
skryptów; wcześniejsze uruchomienia użytkownika dotyczyły wymienionych skryptów
historycznych. Późniejsze pomyślne wyjście użytkownika zachowano w następnej sekcji.

**Analiza statyczna: przeszła.** Zainstalowany samodzielny analizator R2026b
`mlint -id` sprawdził każdy z czterech skryptów bez uwag. Nie wykonuje to skryptów.

**Niezależna weryfikacja matematyczna: przeszła.** Dokładne obliczenia Python
`Fraction` i niezależne przeglądy agentów sprawdziły wszystkie 45 przedstawionych
tablic ćwiczeniowych, równania baz, wymiany, wiersze celu i certyfikaty w pierwotnych
dziedzinach. Sprawdziły również zbiory optimów, podane starty, oba nieograniczone
zadania prymalne grupy 5 i minima sumy sztucznych 3 oraz 4 w fazie I ich sprzecznych
dualnych. Niezależny przegląd poprawił opisowy luz kolumny 5(d) na `(4,0,0)`;
końcowy skrypt jawnie sprawdza tę wartość.

Przykłady modelowania niezależnie sprawdzono w dokładnej arytmetyce wymiernej:
wartości fabryki `28704/5` i `32544/5` przy zdolnościach 144 i 192; zysk mieszania
`475000/27`; koszt transportu `25919`; koszt magazynowania `1883/2`; koszt
przepływu 9; ograniczenia dla diety i regresji. Każdy skończony wynik ma ręczne
ograniczenie osiągane przez dopuszczalnego kandydata. Enumerację wykorzystano jako
osobne sprawdzenie małych przykładów fabryki, mieszania i transportu, a nie ogólny
test nieograniczoności. Promienie i sprzeczne warunki dualne osobno uzasadniają
wyniki wyjątkowe.

Wszystkie cztery skrypty porównują te same podane dane z tolerancją bezwzględną
`1e-10`. Korzystają z podstawowego MATLAB-a i określonych obliczeń, bez Optimization
Toolbox i ogólnego solvera PL. Poniższe późniejsze zdarzenie wykonania dostarcza
faktycznego wyjścia i aktualizuje stan weryfikacji w MATLAB-ie; nie zastępuje
niezależnych dowodów z dokładnej arytmetyki.

## Dowody wykonania bieżącego kursu otrzymane 2026-10-11

**Wykonanie MATLAB-a: pomyślne.** Użytkownik przekazał poniższe wyjście czterech
poleceń i potwierdził tę samą wersję co wcześniej: 26.2.0.3386108 (R2026b).
Wersję potwierdzono osobno; te polecenia jej nie wypisują. Dokładnej daty wykonania
nie podano osobno. Jest to dowód przekazany przez użytkownika, a nie wykonanie
przez agenta w sandboxie.

```text
>> run('matlab/exercises/modeling_patterns_checks.m')
Factory: optima 28704/5 and 32544/5 for G = 144 and 192
Blending: profit 475000/27; transport cost 25919
Storage: cost 1883/2; three-node flow cost 9
All modeling-pattern certificate assertions passed.
>> run('matlab/exercises/sheet_01_primal_simplex.m')
1(a): unique maximum 15.3333333333 at (1/3, 11/3, 4).
1(b): unique maximum 5; feasible set itself is unbounded.
1(c): maximum 36 on (t, 6+2*t, 8), 0 <= t <= 2.
1(d): maximum 8 on (8-2*t, t, 0), 2 <= t <= 4.
1(e): rejected supplied start; ray (6,0,4)+theta*(0,0,1), z=16+theta.
1(f)(i): nonbasic start moved to a BFS; two pivots reach (6,0,1).
1(f)(ii): one pivot from supplied BFS; same ray, z=33+24*theta.
Largest checked tableau/basis discrepancy: 7.11e-15 (absolute tolerance 1e-10).
All prescribed primal-simplex paths and certificates passed.
>> run('matlab/exercises/sheet_01_complementarity_and_two_phase.m')
2(a): supplied point optimal, maximum 7, dual (3,0,2,0)
2(b): supplied point infeasible; actual minimum 6, dual (0,9/2,6)
2(c): supplied point optimal, maximum 1, full segment checked
3(a): Phase I steps 4/3,5; Phase II maximum -6, dual (0,0,-1)
3(b): Phase I step 4, Phase II step 5/2; original minimum 1/2
3(b): dual (3/2,0,1/2), constant-objective optimal ray checked
All complementary certificates and displayed tableaus passed at tol = 1.0e-10
>> run('matlab/exercises/sheet_01_dual_simplex_and_recovery.m')
Task 4: primal = (3,0,2,0), dual = (0,3,1), value = 7; both unique
Task 5(a): dual infeasible, Phase I artificial sum = 3; primal slope = -3
Task 5(b): dual = (31/4,0,15/2,9), recovered primal = (3,-6,7), value = -44; both unique
Task 5(c): dual infeasible, Phase I artificial sum = 4; primal slope = -4
Task 5(d): dual = (0,18,0,5), recovered primal = (0,-8,5), value = 80; both unique
All Sheet 1 dual-simplex and recovery assertions passed.
```

Wszystkie asercje przeszły, a zgłoszone wartości zgadzają się z certyfikatami
ręcznymi. Największa zgłoszona różnica tablica/baza w prymalnym sympleksie,
`7.11e-15`, jest mniejsza od tolerancji bezwzględnej skryptu `1e-10`.
Jest to zaobserwowana różnica dla tych sprawdzeń, a nie uniwersalne ograniczenie
błędu. Wcześniejsze niepowodzenie startu w sandboxie pozostaje kontekstem
historycznym; nie pozostawia już tych czterech skryptów bez weryfikacji.
Nowe przykłady pojęciowe w [przeglądzie notatek](notes-review.pl.md) nie zmieniają
skryptów i nie twierdzimy, że zostały przez nie wykonane.
