# Przewodnik pisania

[English](writing-guide.md) | Polski

## Styl i szablony

Wspólny styl pochodzi z `Lecture_5May.tex` i `egzamin_AZ.tex` w repozytorium AZ
z poprzedniego semestru. Zachowuje artykuły A4 z pismem 11 punktów, marginesy
2,4 cm, fonty Latin Modern, matematykę AMS, numerację twierdzeń w obrębie sekcji
i niebieskie odnośniki. Nazwy środowisk i etykiety są angielskie. W tym checkoutcie
nie znaleziono osobnych plików szablonu ani przewodnika; ten dokument opisuje
wyodrębniony styl. Pochodzenie opisuje [wykaz źródeł](sources.pl.md).

W razie potrzeby skopiuj `templates/lecture.tex` lub `templates/exercise.tex` do
`notes/`. Używaj opisowych nazw ASCII, np. `01-topic.tex`, oraz stałych prefiksów
etykiet `sec:`, `def:`, `thm:`, `eq:` i `fig:`. Kompiluj z katalogu głównego
repozytorium zgodnie z [README](../README.pl.md). Wyniki zapisuj w `build/`.

## Notatki z wykładów

Podawaj źródło, datę, jeśli jest znana, oraz informację, czy zgodność z obecnym
kursem została potwierdzona. Zdefiniuj problem, symbole, dziedziny, założenia i
jednostki przed ich użyciem. Wyjaśnij ideę modelowania, wyprowadź równania krok
po kroku, podaj warunki każdego wyniku i odróżniaj dowody od intuicji. W miarę
opracowywania materiału dodawaj rozwiązane przykłady, ograniczenia i typowe błędy.
Nie przedstawiaj niesprawdzonego dawnego zakresu jako obecnego programu zajęć.

## Ćwiczenia i MATLAB

Zachowuj treść zadania i podawaj źródło. Przedstaw założenia i rozwiązanie ręczne,
a następnie odnośnik do `matlab/exercises/<matching-topic>.m`. Stosuj te same dane
i parametry w obu rozwiązaniach. W razie potrzeby zapisuj oczekiwane wyniki,
błąd bezwzględny lub względny, jednostki, ustawienia solvera, tolerancje oraz
przyczyny rozbieżności. Podawaj, czy sprawdzenie faktycznie wykonano, a także
wersję MATLAB-a, jeśli jest znana. Nie przedstawiaj planowanych skryptów ani
wymyślonych wyników jako weryfikacji.

Oddzielaj przybliżenia numeryczne od dokładnych wyników matematycznych.
Odróżniaj poprawność modelu od sukcesu solvera numerycznego. Powtórka MATLAB-a
i laboratoria podlegają tym samym zasadom i mają własne katalogi notatek i kodu.


Nazwy skryptów i funkcji MATLAB muszą być poprawnymi identyfikatorami: zaczynać
się literą i używać liter, cyfr oraz podkreśleń. Stosuj `lecture_02_checks.m`,
a nie nazwę z łącznikami lub rozpoczynającą się cyfrą.

## Język i decyzje

Stosuj [politykę językową](language-policy.pl.md). Dodawaj nowe terminy do
[słownika](glossary.md). Zmieniaj obie wersje dokumentów repozytorium razem.
Dla trwałych wyborów zapisuj uzasadnienie i rzeczywiste alternatywy w
[rejestrze decyzji](decisions/README.pl.md); zwykłe poprawki należą do historii Git.
