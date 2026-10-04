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

- [Wykład 3: Metoda sympleks](notes/lectures/03-simplex-method.tex)
  ([PDF](output/lectures/03-simplex-method.pdf)): równania kanoniczne, ceny zredukowane,
  pełne tablice sympleksowe, degeneracja, promienie dopuszczalne, inicjalizacja dwufazowa i duże M.

- [Wykład 4: Degeneracja, dualność i dualna metoda sympleks](notes/lectures/04-degeneracy-and-duality.tex)
  ([PDF](output/lectures/04-degeneracy-and-duality.pdf)): pełny przykład cyklu,
  reguła Blanda i perturbacja leksykograficzna, złożoność, konstrukcja zadania dualnego,
  certyfikaty optymalności, komplementarność i rozwiązanie dualną metodą sympleks.

- [Wykład 5: Analiza wrażliwości i mnożniki Lagrange’a](notes/lectures/05-sensitivity-and-lagrange-multipliers.tex)
  ([PDF](output/lectures/05-sensitivity-and-lagrange-multipliers.pdf)): zakresy zmian danych,
  ceny dualne, ponowna optymalizacja po zmianach struktury, tablice i certyfikaty KKT.

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

Zainstaluj Bash, Python 3, dystrybucję TeX z pdfLaTeX-em, latexmk i pakietami wymienionymi
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
Kompilacja odświeża także `docs/pdf-build.json`, zapisując hashe SHA-256 PDF-ów
i danych wejściowych. Commituj ten zapis oraz PDF-y razem ze zmianami notatek.
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

## Sprawdzenia MATLAB z wykładu 3

```matlab
run('matlab/exercises/lecture_03_checks.m')
```

Uruchom z katalogu głównego repozytorium. Skrypt korzystający z podstawowego MATLAB-a
sprawdza oba przykłady sympleksowe, oba warianty startu dwufazowego i dodane kontrprzykłady.
Wszystkie asercje przeszły w zwykłym terminalu użytkownika. Analiza statyczna
oraz niezależne obliczenia na dokładnych ułamkach także zakończyły się pomyślnie;
zobacz [zapis weryfikacji](docs/matlab-verification.pl.md).

## Sprawdzenia MATLAB-a do wykładu 4

```matlab
run('matlab/exercises/lecture_04_checks.m')
```

Uruchom z katalogu głównego repozytorium. Skrypt wymaga tylko podstawowego MATLAB-a
i sprawdza cykl, obie ścieżki zapobiegające cyklom, przykład Klee–Minty'ego,
certyfikaty dualne, komplementarność, zmiany prawej strony oraz dualną metodę sympleks.
Wszystkie asercje przeszły w zwykłym terminalu użytkownika w R2026b. Analiza statyczna
i niezależne obliczenia na dokładnych ułamkach również przeszły; zobacz
[rejestr weryfikacji](docs/matlab-verification.pl.md).

## Sprawdzenia wykładu 5 w MATLAB-ie

```matlab
run('matlab/exercises/lecture_05_checks.m')
```

Uruchom z katalogu głównego repozytorium. Skrypt podstawowego MATLAB-a sprawdza
zakresy wrażliwości, łączne zmiany, dodawanie i usuwanie zmiennych oraz ograniczeń,
wybrane wymiany i certyfikat KKT. Wszystkie asercje przeszły w zwykłym terminalu
użytkownika w R2026b. Pomyślnie zakończyły się również analiza statyczna i niezależne
obliczenia na dokładnych ułamkach; zobacz [zapis weryfikacji](docs/matlab-verification.pl.md).

## Sprawdzenia Git

Włącz wspólne hooki repozytorium w każdym klonie (wymagany Python 3):

```sh
git config --local core.hooksPath .githooks
```

Hook `commit-msg` ogranicza każdy wiersz komunikatu do 72 znaków Unicode i
wymaga pustego wiersza między tytułem a opisem. Sam tytuł jest poprawny.
Komentarze edytora Git są pomijane przy sprawdzaniu.

Hook `pre-commit` sprawdza zawartość indeksu Git pod kątem:

- Kompletności par angielsko-polskich, hashy sekcji, poziomów nagłówków i identycznych bloków kodu.
- Hashy PDF-ów, zapisanych danych wejściowych i dostępnych kopii kompilacji zmienionych PDF-ów.
- Formatowania LaTeX/TikZ zgodnie z konfiguracją `.latexindent.yaml` z indeksu.

Uruchom sprawdzenia katalogu roboczego bezpośrednio:

```sh
python3 scripts/check_translations.py
python3 scripts/check_output.py
python3 scripts/format_tex.py --check
```

Po edycji dokumentów przejrzyj oba języki, zapisz konkretną sprawdzoną parę,
a następnie dodaj wszystkie trzy pliki do indeksu:

```sh
python3 scripts/check_translations.py --write README.md
```

Każda para ma sąsiadujący plik `.i18n.json` z hashami sekcji angielskich i polskich,
inspirowany [konwencją par DeepSeek](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/i18n/README.md).
Hashe wykrywają zmiany od przeglądu; nie dowodzą jakości tłumaczenia.
Sprawdzenie PDF-ów wykrywa zmienione dane wejściowe lub pliki wynikowe; świeży klon
może przejść sprawdzenie dzięki commitowanemu zapisowi bez pośredniego drzewa `build/`.

## Formatowanie LaTeX i TikZ

Stosuj wspólne ustawienia latexindent do plików `.tex`, `.sty` i `.tikz`:

```sh
python3 scripts/format_tex.py --write
./build.sh
```

Obecne grafiki TikZ są wewnątrz wykładowych plików `.tex` i podlegają sprawdzeniu.
Formatowanie zachowuje podziały wierszy oraz dosłowne listingi MATLAB-a.
Pliki pomocnicze formattera pozostają poza katalogami źródłowymi.

Projektowy `.nvim.lua` konfiguruje Conform z tymi samymi ustawieniami formattera.
W Neovimie, z katalogu głównego repozytorium:

```vim
:luafile .nvim.lua
```

Następnie użyj istniejącego mapowania `<leader>f`. Opcjonalne ustawienie Neovima
`exrc` może automatycznie wczytać konfigurację projektu po jej zatwierdzeniu.
`.editorconfig` zapewnia zgodne wcięcia po dwie spacje w buforach TeX/TikZ.
Globalna konfiguracja Neovima pozostaje bez zmian.


## Sposób pracy

Porównaj dawne materiały z aktualnym wykładem lub zadaniem, zanim uznasz je za
obecny zakres przedmiotu. Napisz objaśnienie matematyczne i rozwiązanie ręczne,
a następnie sprawdź te same dane w MATLAB-ie. Zapisuj założenia, jednostki,
ustawienia solvera i rozbieżności. Dodawaj napotkane polskie terminy do słownika.

Aktualizuj obie wersje językowe przewodników i decyzji w tej samej zmianie.
Zapisuj istotne decyzje wraz z alternatywami i konsekwencjami; commity Git
utrwalają zwykłe edycje. Twórz małe, spójne commity z opisowymi komunikatami.
