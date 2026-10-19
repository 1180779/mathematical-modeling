# Wizualne oznaczenia potwierdzonej treści bieżącego wykładu

[English](2026-10-19-confirmed-lecture-highlights.md) | Polski

Status: implemented

## Problem

Użytkownik poprosił o wizualne oznaczenie treści na pewno obecnych na wykładzie,
na wzór wyróżnionych notatek AZ, oraz osobne kolory łączące komórki macierzy
prymalnej i dualnej. Wcześniejsza decyzja o samodzielnym tekście dydaktycznym
przenosiła całe pochodzenie poza tekst i nie przewidywała wizualnego wyjątku.

## Decyzja

Na prośbę użytkownika z 2026-10-19 dopuszcza się wybrane kremowe ramki
`lecturecore` oraz wspólną `\lecturelegend` w dokumentach wykładowych.
To wąsko zastępuje zakaz oznaczeń źródła wewnątrz tekstu z
[decyzji o samodzielnym tekście dydaktycznym](2026-10-04-self-contained-study-notes.pl.md).
Daty, strony źródeł, rozbieżności i weryfikację pozostaw w końcowych uwagach lub dokumentacji.

Wyróżniaj tylko stwierdzenia, modele i wzory potwierdzone w dostarczonych bieżących
źródłach wykładowych. Nie wyróżniaj przez skojarzenie otaczających dodanych dowodów
lub rozwiązań ręcznych. Zakres nie oznacza wymagania egzaminacyjnego. Treść bez
wyróżnienia może nadal objaśniać temat wykładu; brak wyróżnienia nie ustala braku
na zajęciach. Zgodność rozdziału 5 pozostaje nieznana.

Użyj konwencji kremowych ramek łamanych między stronami z AZ,
`aa-lectures-2025-2026/preamble.tex`, ze znaczeniem innym niż zakres egzaminu.
Osobna, jawnie opisana paleta komórek określa role matematyczne powiązanych tablic
prymalnych–dualnych. Cała treść ma pozostawać czytelna bez koloru.

## Alternatywy

- Kolorowanie całych rozdziałów lub sekcji błędnie obejmowałoby dodane wyprowadzenia.
- Kolorowanie samych nagłówków nie wskazywałoby dokładnie potwierdzonych stwierdzeń.
- Pochodzenie tylko w końcowych uwagach nie spełniałoby prośby o wskazówkę wizualną.

## Konsekwencje i weryfikacja

Wybrano 23 bloki w rozdziałach 1–4 i Schematach modelowania, każdy dokument ze
wspólną legendą. Istniejące dowody i historyczne rozszerzenia zachowano.
Formatowanie, parowanie tłumaczeń i hashe PDF-ów sprawdza się po przebudowaniu
wszystkich notatek; wybrane strony wynikowe sprawdza się pod kątem łamania ramek
i czytelności kolorowych tablic.
