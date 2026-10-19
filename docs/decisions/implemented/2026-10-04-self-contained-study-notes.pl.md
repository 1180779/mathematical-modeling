# Samodzielna treść dydaktyczna i objaśnienia graficzne

[English](2026-10-04-self-contained-study-notes.md) | Polski

Status: implemented

## Problem

Informacje o źródłach, poprawki redakcyjne, organizacja repozytorium i historia
uruchomień wtrącone w treść utrudniają naukę. Wykład 2 potrzebuje też więcej
objaśnień graficznych, podobnie jak przydatne rysunki w dawnych slajdach.

## Decyzja

Na prośbę użytkownika z 2026-10-04 treść dydaktyczna pozostaje niezależna od
decyzji repozytorium i pochodzenia materiału. Źródła i ważny kontekst redakcyjny
mogą znaleźć się w samodzielnej końcowej sekcji, bez znaczników cytowań ani
odnośników z głównej treści. Sekcja końcowa może wskazywać wcześniejszy materiał.
Zasady repozytorium i szczegółowe dowody weryfikacji pozostają w `docs/`.
Założenia i zastrzeżenia matematyczne pozostają obok odpowiednich wyników.
Stosujemy edytowalne grafiki TikZ, gdy wyjaśniają geometrię lub modele fizyczne.

## Rozważane alternatywy

**Źródła i uwagi redakcyjne w treści:** zapewniają bezpośrednie przypisanie,
ale przerywają narrację dydaktyczną; zastępują je uwagi na końcu.

**Pochodzenie wyłącznie w dokumentacji repozytorium:** skraca PDF, ale usuwa
przydatny kontekst przy samodzielnym czytaniu pliku. Końcowa sekcja go zachowuje.

**Kopiowanie obrazów slajdów:** wygodne, ale często daje małe etykiety i dawne
formatowanie. Przerysowane grafiki pasują do notatek i pozostają edytowalne.

## Konsekwencje

Notatki wykładowe, istniejąca powtórka MATLAB-a, szablony i oba przewodniki
stosują tę granicę. Aktualizacje źródeł powinny obejmować końcowe uwagi i wykaz
źródeł razem. Rysunki muszą odpowiadać opisanym modelom matematycznym i być
czytelne w skompilowanym PDF-ie.

[Decyzja o oznaczeniach wizualnych z 2026-10-19](2026-10-19-confirmed-lecture-highlights.pl.md)
wąsko zastępuje zakaz oznaczeń źródła wewnątrz tekstu dla wybranych ramek
wykładowych i ich wspólnej legendy. Pozostała granica pochodzenia nadal obowiązuje.
