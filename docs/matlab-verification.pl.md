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
