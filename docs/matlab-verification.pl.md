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
