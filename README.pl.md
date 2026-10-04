# Modelowanie matematyczne

[English](README.md) | Polski

Osobiste repozytorium do nauki modelowania matematycznego: notatki z wykładów,
ćwiczenia z rozwiązaniami ręcznymi i w MATLAB-ie, powtórka MATLAB-a oraz laboratoria.
Notatki powstają na podstawie dawnych źródeł; zgodność z obecnym kursem jest niepotwierdzona.

## Od czego zacząć

- [Przewodnik pisania](docs/writing-guide.pl.md): struktura, notacja, źródła i weryfikacja.
- [Polityka językowa](docs/language-policy.pl.md): angielskie notatki z polską terminologią.
- [Słownik polsko-angielski](docs/glossary.md): wspólne słownictwo.
- [Wykaz źródeł](docs/sources.pl.md): dawne wykłady i pochodzenie szablonu.
- [Rejestr decyzji](docs/decisions/README.pl.md): uzasadnienia i oczekujące propozycje.

## Notatki z wykładów

- [Wykład 1: Modelowanie problemów optymalizacji](notes/lectures/01-optimization-modeling.tex)
  ([PDF](output/lectures/01-optimization-modeling.pdf)): zmienne, ograniczenia, funkcje celu,
  klasyfikacja i historyczny zakres powtórki MATLAB-a.

- [Wykład 2: Programowanie liniowe—modele i geometria](notes/lectures/02-linear-programming.tex)
  ([PDF](output/lectures/02-linear-programming.pdf)): przykłady modeli, postać standardowa,
  kierunki recesji, optymalne wierzchołki i bazowe rozwiązania dopuszczalne.

Odnośniki do PDF-ów wskazują commitowane kopie do czytania w `output/`.

## Struktura

| Ścieżka | Przeznaczenie |
| --- | --- |
| `notes/lectures/` | Angielskie notatki z wykładów w LaTeX-u |
| `notes/exercises/` | Treści ćwiczeń, rozwiązania ręczne i porównania z MATLAB-em |
| `notes/matlab-review/` | Krótka powtórka MATLAB-a |
| `notes/labs/` | Objaśnienia laboratoriów i wyniki |
| `matlab/review/` | Skrypty do powtórki |
| `matlab/exercises/` | Skrypty powiązane z rozwiązaniami ćwiczeń |
| `matlab/labs/` | Skrypty i funkcje laboratoryjne |
| `templates/` | Wspólny styl LaTeX i dokumenty startowe |
| `docs/` | Dwujęzyczne przewodniki, decyzje, wykaz źródeł i słownik |
| `build/` | PDF-y kompilacji i pliki pośrednie, pogrupowane jak `notes/`; ignorowane przez Git |
| `output/` | Commitowane kopie PDF, pogrupowane jak `notes/`; wyłącznie PDF-y |
| `build.sh` | Kompilacja wszystkich notatek i odświeżanie kopii PDF |

Stosuj zgodne nazwy tematów dla rozwiązania ćwiczenia i jego skryptu MATLAB;
powiąż skrypt z rozwiązaniem. Utrzymuj jedną wykonywalną implementację zadania.

## Kompilacja notatek

Zainstaluj Bash, dystrybucję TeX z pdfLaTeX-em, latexmk i pakietami wymienionymi
w `templates/modeling-notes.sty`. Z katalogu głównego repozytorium uruchom:

```sh
./build.sh
```

Skrypt wykrywa wszystkie dokumenty `.tex` w `notes/`. Kompiluje je w odpowiednich
podkatalogach ignorowanego `build/`, a dopiero po pomyślnej kompilacji wszystkich
dokumentów kopiuje wyłącznie PDF-y do `output/`. Przykład:

```text
notes/lectures/02-linear-programming.tex
  -> build/lectures/02-linear-programming.pdf (plus intermediate files)
  -> output/lectures/02-linear-programming.pdf
```

`output/` ma także kategorie `exercises/`, `labs/` i `matlab-review/`.
Skrypt tworzy puste katalogi bez plików zastępczych.
Po udanej kompilacji istniejące kopie PDF są nadpisywane. Po zmianie nazwy lub
usunięciu notatki usuń również jej nieaktualny PDF z `output/`.
Skrypt można też wywołać ścieżką bezwzględną z innego katalogu.
Commituj zaktualizowane PDF-y razem z odpowiednimi zmianami notatek.
Pliki IntelliJ `.idea/`, `*.iml`, `*.ipr` i `*.iws` są ignorowane.

Aby obejrzeć pusty szablon bez eksportowania go do `output/`:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build/templates templates/lecture.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build/templates templates/exercise.tex
```

Przed opracowaniem materiału skopiuj szablon do odpowiedniego katalogu `notes/`;
zachowaj ścieżki względem katalogu głównego repozytorium i uruchom `./build.sh`.

## Powtórka MATLAB-a

[Powtórka 1: Tablice, indeksowanie i układy liniowe](notes/matlab-review/01-arrays-and-linear-systems.tex)
([PDF](output/matlab-review/01-arrays-and-linear-systems.pdf)) zawiera obliczenia ręczne i
odpowiadający im skrypt dotyczący wymiarów, indeksowania, operatorów, backslash,
uchwytów do funkcji, pętli i wykresów.

```matlab
run('matlab/review/arrays_and_linear_systems.m')
```

Wykres trafia do ignorowanego `matlab/output/`. Odśwież PDF-y notatek poleceniem:

```sh
./build.sh
```

## Sprawdzenia MATLAB z wykładu 2

```matlab
run('matlab/exercises/lecture_02_checks.m')
```

Uruchom z katalogu głównego repozytorium. Skrypt sprawdza przykłady ręczne za pomocą
podstawowego MATLAB-a; Optimization Toolbox nie jest wymagany. Oba skrypty przeszły sprawdzenia, łącznie z eksportem wykresu; zobacz [zapis weryfikacji](docs/matlab-verification.pl.md).

## Sprawdzenia Git

Włącz wspólne hooki repozytorium w każdym klonie (wymagany Python 3):

```sh
git config --local core.hooksPath .githooks
```

Hook `commit-msg` ogranicza każdy wiersz komunikatu do 72 znaków Unicode i
wymaga pustego wiersza między tytułem a opisem. Sam tytuł jest poprawny.
Komentarze edytora Git są pomijane przy sprawdzaniu.

## Sposób pracy

Porównaj dawne materiały z aktualnym wykładem lub zadaniem, zanim uznasz je za
obecny zakres przedmiotu. Napisz objaśnienie matematyczne i rozwiązanie ręczne,
a następnie sprawdź te same dane w MATLAB-ie. Zapisuj założenia, jednostki,
ustawienia solvera i rozbieżności. Dodawaj napotkane polskie terminy do słownika.

Aktualizuj obie wersje językowe przewodników i decyzji w tej samej zmianie.
Zapisuj istotne decyzje wraz z alternatywami i konsekwencjami; commity Git
utrwalają zwykłe edycje. Twórz małe, spójne commity z opisowymi komunikatami.
