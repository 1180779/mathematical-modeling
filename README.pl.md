# Modelowanie matematyczne

[English](README.md) | Polski

Osobiste repozytorium do nauki modelowania matematycznego: notatki z wykładów,
ćwiczenia z rozwiązaniami ręcznymi i w MATLAB-ie, powtórka MATLAB-a oraz laboratoria.
Rozdziały pojęciowe zachowują głębię dawnych notatek i włączają dostarczone
wykład 1 oraz zestaw 1 z kursu 2026–27. Numery rozdziałów są niezależne od
numerów bieżących wykładów; przyszła zgodność z kursem pozostaje nieznana.

## Od czego zacząć

- [Mapa bieżącego kursu](docs/course-map-2026-27.pl.md): strony wykładu, numery zadań, podstawy i wyniki ręczne.
- [Przegląd notatek i dalsza nauka](docs/notes-review.pl.md): objaśnienia wizualne, rozszerzone podstawy i dalsze kierunki nauki.
- [Przewodnik pisania](docs/writing-guide.pl.md): struktura, notacja, źródła i weryfikacja.
- [Polityka językowa](docs/language-policy.pl.md): angielskie notatki z polską terminologią.
- [Słownik polsko-angielski](docs/glossary.md): wspólne słownictwo.
- [Wykaz źródeł](docs/sources.pl.md): bieżące materiały, dawne źródła i pochodzenie szablonu.
- [Rejestr decyzji](docs/decisions/README.pl.md): uzasadnienia i oczekujące propozycje.

## Rozdziały pojęciowe do nauki

- [Rozdział 1: Modelowanie problemów optymalizacji](notes/lectures/01-optimization-modeling.tex)
  ([PDF](output/lectures/01-optimization-modeling.pdf)): zmienne, ograniczenia, funkcje celu,
  klasyfikacja, model pięciu produktów w dwóch wariantach zdolności i dokładne certyfikaty ręczne.

- [Rozdział 2: Programowanie liniowe—modele i geometria](notes/lectures/02-linear-programming.tex)
  ([PDF](output/lectures/02-linear-programming.pdf)): przykłady modeli, postać standardowa,
  kierunki recesji, optymalne wierzchołki i bazowe rozwiązania dopuszczalne.

- [Schematy modelowania: Mieszanie, sieci, cele i wymagania](notes/lectures/02a-linear-modeling-patterns.tex)
  ([PDF](output/lectures/02a-linear-modeling-patterns.pdf)): pełne przykłady mieszania,
  transportu z ograniczeniami tras i magazynowania, przepływ o minimalnym koszcie,
  wybór celu i miękkie ograniczenia, z wyprowadzeniami i certyfikatami ręcznymi.

- [Rozdział 3: Metoda sympleks](notes/lectures/03-simplex-method.tex)
  ([PDF](output/lectures/03-simplex-method.pdf)): równania kanoniczne, ceny zredukowane,
  pełne tablice sympleksowe, degeneracja, promienie dopuszczalne, inicjalizacja dwufazowa i duże M.

- [Rozdział 4: Degeneracja, dualność i dualna metoda sympleks](notes/lectures/04-degeneracy-and-duality.tex)
  ([PDF](output/lectures/04-degeneracy-and-duality.pdf)): pełny przykład cyklu,
  reguła Blanda i perturbacja leksykograficzna, złożoność, konstrukcja zadania dualnego,
  certyfikaty optymalności, komplementarność i rozwiązanie dualną metodą sympleks.

- [Rozdział 5: Analiza wrażliwości i mnożniki Lagrange’a](notes/lectures/05-sensitivity-and-lagrange-multipliers.tex)
  ([PDF](output/lectures/05-sensitivity-and-lagrange-multipliers.pdf)): zakresy zmian danych,
  ceny dualne, ponowna optymalizacja po zmianach struktury, tablice i certyfikaty KKT.

Odnośniki do PDF-ów wskazują commitowane kopie do czytania w `output/`.

## Bieżący zestaw 1 i sprawdzenia modelowania

- [Grupa 1: Sympleks prymalny](notes/exercises/01-primal-simplex.tex)
  ([PDF](output/exercises/01-primal-simplex.pdf)): wszystkie sześć problemów,
  oba starty 1(f), pełne tablice, zbiory optimów i promienie wzrostu.
- [Grupy 2–3: Komplementarność i metoda dwufazowa](notes/exercises/01-complementarity-and-two-phase.tex)
  ([PDF](output/exercises/01-complementarity-and-two-phase.pdf)): sprawdzanie
  kandydatów od dopuszczalności, dualne o różnych znakach i pełne ścieżki fazy I/II.
- [Grupy 4–5: Sympleks dualny i odzyskiwanie rozwiązania prymalnego](notes/exercises/01-dual-simplex-and-recovery.tex)
  ([PDF](output/exercises/01-dual-simplex-and-recovery.pdf)): wymiany dualne,
  rozwiązania dualne, odzyskiwanie prymalnych i sprzeczne dualne wydrukowanych 5(a)/5(c).

Zachowano oryginalne polskie polecenia i dane; objaśnienia są po angielsku.
Sprzeczne zdolności szlifowania z bieżącego wykładu omówiono jawnie.
Niedopuszczalnych kandydatów sprawdzamy, zamiast poprawiać.

Cztery nowe skrypty podstawowego MATLAB-a można uruchomić z katalogu głównego repozytorium:

```matlab
run('matlab/exercises/modeling_patterns_checks.m')
run('matlab/exercises/sheet_01_primal_simplex.m')
run('matlab/exercises/sheet_01_complementarity_and_two_phase.m')
run('matlab/exercises/sheet_01_dual_simplex_and_recovery.m')
```

Dokładne sprawdzenia wymierne, analiza statyczna MATLAB-a i asercje wszystkich
czterech skryptów przeszły. Użytkownik przekazał pomyślne wyjście i potwierdził
MATLAB 26.2.0.3386108 (R2026b); skrypt prymalnego sympleksu podał największą
różnicę tablica/baza `7.11e-15` przy tolerancji bezwzględnej `1e-10`.
Zobacz [rejestr weryfikacji](docs/matlab-verification.pl.md).
Przykład diety i jego sprawdzenie zmieniono po tym uruchomieniu. Nowy wynik
przechodzi dokładne obliczenia i analizę statyczną; wykonanie tej wersji
w MATLAB-ie oczekuje na weryfikację.

## Struktura

| Ścieżka | Przeznaczenie |
| --- | --- |
| `notes/lectures/` | Angielskie rozdziały pojęciowe i dodatek modelowania w LaTeX-u |
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

Aby posprzątać lokalne pliki kompilacji, także pliki tworzone przez edytor
obok źródeł, uruchom:

```sh
python3 scripts/clean_tex.py --dry-run
python3 scripts/clean_tex.py
```

Skrypt sprząta `notes/`, `templates/` i `build/`, zachowuje pliki śledzone przez
Git i nie podąża za dowiązaniami symbolicznymi. Domyślnie PDF-y pozostają.
Dodaj `--pdfs`, aby usunąć także wygenerowane PDF-y w `build/` lub obok
odpowiadającego źródła `.tex`; publikowane PDF-y w `output/` oraz zasoby PDF
bez odpowiadającego źródła są zachowywane. Skrypt działa także wywołany
ścieżką bezwzględną z innego katalogu. Typowe pliki pomocnicze TeX oraz PDF-y
generowane przez edytor w `notes/` i `templates/` są ignorowane przez Git.

## Uzupełniające PDF-y wykładów

Pobierz wszystkie wykłady z [MIT OCW 6.251J, jesień 2009](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/pages/lecture-notes/)
oraz [UCLA ECE236B, zima 2026](https://www.seas.ucla.edu/~vandenbe/ee236b/),
włącznie z uzupełnieniem UCLA dotyczącym algebry liniowej z 2023 roku:

```sh
python3 scripts/download_lectures.py --dry-run
python3 scripts/download_lectures.py
```

Wymagane są Python 3.8+ i curl. Skrypt czyta oficjalne indeksy kursów;
obecnie zawierają one 25 wykładów MIT i 12 PDF-ów UCLA. Pliki trafiają do
sąsiednich `../sources/mit/` i `../sources/ucla/`, z zachowaniem nazw już
wymienionych w [inwentarzu źródeł](docs/sources.pl.md). Skrypt pomija istniejące
PDF-y z nagłówkiem PDF i znacznikiem końca, ponawia przejściowe błędy transferu
i zapisuje każdy nowy plik pod docelową nazwą dopiero po sprawdzeniu tych
znaczników. Nieudane pobrania można ponowić przy kolejnym uruchomieniu;
błędy powodują niezerowy kod zakończenia. `--dry-run` nadal czyta indeksy
online, ale nie tworzy plików. Zmień katalog docelowy przez
`--dest /path/to/sources` lub `LECTURE_SOURCES_DIR`. Skrypt można też uruchomić
z innego katalogu, podając jego ścieżkę bezwzględną.

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

## Sprawdzenia MATLAB z rozdziału 2

```matlab
run('matlab/exercises/lecture_02_checks.m')
```

Uruchom z katalogu głównego repozytorium. Skrypt sprawdza przykłady ręczne za pomocą
podstawowego MATLAB-a; Optimization Toolbox nie jest wymagany. Oba skrypty przeszły sprawdzenia, łącznie z eksportem wykresu; zobacz [zapis weryfikacji](docs/matlab-verification.pl.md).

## Sprawdzenia MATLAB z rozdziału 3

```matlab
run('matlab/exercises/lecture_03_checks.m')
```

Uruchom z katalogu głównego repozytorium. Skrypt korzystający z podstawowego MATLAB-a
sprawdza oba przykłady sympleksowe, oba warianty startu dwufazowego i dodane kontrprzykłady.
Wszystkie asercje przeszły w zwykłym terminalu użytkownika. Analiza statyczna
oraz niezależne obliczenia na dokładnych ułamkach także zakończyły się pomyślnie;
zobacz [zapis weryfikacji](docs/matlab-verification.pl.md).

## Sprawdzenia MATLAB-a do rozdziału 4

```matlab
run('matlab/exercises/lecture_04_checks.m')
```

Uruchom z katalogu głównego repozytorium. Skrypt wymaga tylko podstawowego MATLAB-a
i sprawdza cykl, obie ścieżki zapobiegające cyklom, przykład Klee–Minty'ego,
certyfikaty dualne, komplementarność, zmiany prawej strony oraz dualną metodę sympleks.
Wszystkie asercje przeszły w zwykłym terminalu użytkownika w R2026b. Analiza statyczna
i niezależne obliczenia na dokładnych ułamkach również przeszły; zobacz
[rejestr weryfikacji](docs/matlab-verification.pl.md).

## Sprawdzenia rozdziału 5 w MATLAB-ie

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

### Wysyłanie PDF-ów na BOOX

Opcjonalny hook `post-commit` wysyła nowe lub zmienione **commitowane** PDF-y na
urządzenie BOOX, korzystając z Pythona 3 i curl. Włącz wspólne hooki jak wyżej, a następnie:

```sh
cp .env.boox.example .env.boox
```

Edytuj ignorowany plik `.env.boox`: ustaw `BOOX_UPLOAD_URL` na pełny endpoint
widoczny w żądaniu wysyłania pliku na urządzenie, a `BOOX_REMOTE_DIR` na
bezwzględną ścieżkę istniejącego katalogu **na urządzeniu**. Żądanie odpowiada
dostarczonemu HAR: pola multipart `dir`, `sender=web` i `file`. Konfiguracja
to literalne dane `KEY=value`; wartości ze spacjami ujmij w cudzysłowy.
Polecenia powłoki i rozwijanie zmiennych nie są wykonywane. Eksportowane zmienne
środowiskowe mają pierwszeństwo przed plikiem; eksport pustego `BOOX_UPLOAD_URL`
tymczasowo wyłącza wysyłanie.

| Zmienna | Wartość domyślna / przeznaczenie |
| --- | --- |
| `BOOX_UPLOAD_URL` | Wymagana; pełny endpoint wysyłania HTTP(S) |
| `BOOX_REMOTE_DIR` | Wymagana; istniejący katalog docelowy na BOOX |
| `BOOX_PDF_DIR` | `output`; katalog PDF-ów względem katalogu repozytorium |
| `BOOX_CONNECT_TIMEOUT` | `1`; maksymalny czas nawiązania połączenia w sekundach |
| `BOOX_UPLOAD_TIMEOUT` | `15`; maksymalny łączny czas wysyłania jednego pliku w sekundach |
| `BOOX_ENV_FILE` | `.env.boox`; inny plik konfiguracji, ustawiany w środowisku |
| `BOOX_STATE_FILE` | Lokalny dla Git `boox-upload.json`; opcjonalna inna ścieżka stanu |

Pierwsze skonfigurowane uruchomienie wysyła wszystkie PDF-y z `BOOX_PDF_DIR`
w `HEAD`. Kolejne porównują hashe obiektów blob Git z ostatnimi udanymi
transferami. Domyślnie stan pozostaje w metadanych Git; własną ścieżkę stanu
utrzymuj poza kontrolą wersji. Zmiana endpointu, katalogu docelowego lub katalogu
PDF-ów rozpoczyna nową synchronizację.
PDF-y trafiają do jednego katalogu docelowego pod pierwotnymi nazwami;
powtarzające się nazwy są odrzucane przed wysyłaniem. Pliki na urządzeniu
nie są usuwane, gdy PDF-y znikają z Git.

Niedostępny host lub endpoint zatrzymuje wysyłanie po pierwszym niepowodzeniu;
nie ma natychmiastowych ponowień, a commit nadal kończy się powodzeniem.
Transfer jest zapisywany dopiero po sukcesie HTTP z odpowiedzią JSON BOOX
`successful: true` i `code: 0`. Każdy udany transfer jest zapisywany osobno,
więc oczekujące PDF-y zostaną wysłane przy kolejnym commicie. Aby ponowić
wysyłanie ręcznie albo uruchomić testy bez urządzenia:

```sh
python3 scripts/upload_boox.py
python3 -m unittest discover -s scripts/tests -v
```

## Formatowanie LaTeX i TikZ

Projektowy `.latexmkrc` ustawia `TEXINPUTS` na repozytorium i `templates/`,
zachowując ścieżki wyszukiwania zainstalowanych pakietów TeX. Małe konfiguracje
w każdym katalogu dokumentów wczytują go, gdy VimTeX/latexmk kompiluje w tym
katalogu. Dzięki temu `\usepackage{templates/modeling-notes}` działa zarówno
z katalogu głównego repozytorium, jak i z katalogu notatki, bez globalnej
instalacji stylu. Do kompilacji projektu używaj tego pliku konfiguracyjnego;
ogólna konfiguracja ścieżek wyszukiwania TeX Live to `texmf.cnf`. Zobacz
[podręcznik latexmk](https://tug.ctan.org/support/latexmk/latexmk.pdf) i
[dokumentację ścieżek wyszukiwania Kpathsea](https://tug.ctan.org/systems/doc/kpathsea/kpathsea.html#Default-expansion).

Stosuj wspólne ustawienia latexindent do plików `.tex`, `.sty` i `.tikz`:

```sh
python3 scripts/format_tex.py --write
./build.sh
```

Obecne grafiki TikZ są wewnątrz wykładowych plików `.tex` i podlegają sprawdzeniu.
Formatowanie zachowuje podziały wierszy oraz dosłowne listingi MATLAB-a.
Pliki pomocnicze formattera pozostają poza katalogami źródłowymi.

Projektowy `.nvim.lua` konfiguruje Conform z tymi samymi ustawieniami formattera
i ustawia `TEXINPUTS` dla procesów edytora, w tym wyszukiwania pakietów przez texlab.
W Neovimie, z katalogu głównego repozytorium:

```vim
:luafile .nvim.lua
```

Wczytaj konfigurację przed otwarciem bufora TeX. Jeśli texlab lub kompilator
VimTeX już działa, uruchom go ponownie albo otwórz Neovim ponownie, aby proces
odziedziczył zaktualizowane środowisko.
Następnie użyj istniejącego mapowania `<leader>f`. Opcjonalne ustawienie Neovima
`exrc` może automatycznie wczytać konfigurację projektu po jej zatwierdzeniu.
`.editorconfig` zapewnia zgodne wcięcia po dwie spacje w buforach TeX/TikZ.
Globalna konfiguracja Neovima pozostaje bez zmian.


## Sposób pracy

Korzystaj z mapy kursu, aby odróżniać dostarczony zakres wykładu, wymagania zadań
i historyczne rozszerzenia; aktualizuj ją wraz z nowymi materiałami.
Napisz objaśnienie matematyczne i rozwiązanie ręczne,
a następnie sprawdź te same dane w MATLAB-ie. Zapisuj założenia, jednostki,
ustawienia solvera i rozbieżności. Dodawaj napotkane polskie terminy do słownika.

Aktualizuj obie wersje językowe przewodników i decyzji w tej samej zmianie.
Zapisuj istotne decyzje wraz z alternatywami i konsekwencjami; commity Git
utrwalają zwykłe edycje. Twórz małe, spójne commity z opisowymi komunikatami.
