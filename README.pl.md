# Modelowanie matematyczne

[English](README.md) | Polski

Osobiste repozytorium do nauki modelowania matematycznego: notatki z wykładów,
ćwiczenia z rozwiązaniami ręcznymi i w MATLAB-ie, powtórka MATLAB-a oraz laboratoria.
Pierwsza iteracja zawiera strukturę i szablony; notatki z przedmiotu jeszcze nie powstały.

## Od czego zacząć

- [Przewodnik pisania](docs/writing-guide.pl.md): struktura, notacja, źródła i weryfikacja.
- [Polityka językowa](docs/language-policy.pl.md): angielskie notatki z polską terminologią.
- [Słownik polsko-angielski](docs/glossary.md): wspólne słownictwo.
- [Wykaz źródeł](docs/sources.pl.md): dawne wykłady i pochodzenie szablonu.
- [Rejestr decyzji](docs/decisions/README.pl.md): uzasadnienia i oczekujące propozycje.

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
| `build/` | Wygenerowane PDF-y i pliki pomocnicze; ignorowane przez Git |

Stosuj zgodne nazwy tematów dla rozwiązania ćwiczenia i jego skryptu MATLAB;
powiąż skrypt z rozwiązaniem. Utrzymuj jedną wykonywalną implementację zadania.

## Kompilacja szablonu

Zainstaluj dystrybucję TeX z pdfLaTeX-em, latexmk i pakietami wymienionymi w
`templates/modeling-notes.sty`. Z katalogu głównego repozytorium:

```sh
mkdir -p build
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build templates/lecture.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build templates/exercise.tex
```

Skopiuj szablon do odpowiedniego katalogu notatek. Zachowaj ścieżki względem
katalogu głównego repozytorium i kompiluj z niego tym samym poleceniem,
podając nową ścieżkę pliku. Kod będzie sprawdzany w MATLAB-ie po dodaniu skryptów;
ten szkielet nie zawiera wykonywalnych zadań MATLAB.

## Sposób pracy

Porównaj dawne materiały z aktualnym wykładem lub zadaniem, zanim uznasz je za
obecny zakres przedmiotu. Napisz objaśnienie matematyczne i rozwiązanie ręczne,
a następnie sprawdź te same dane w MATLAB-ie. Zapisuj założenia, jednostki,
ustawienia solvera i rozbieżności. Dodawaj napotkane polskie terminy do słownika.

Aktualizuj obie wersje językowe przewodników i decyzji w tej samej zmianie.
Zapisuj istotne decyzje wraz z alternatywami i konsekwencjami; commity Git
utrwalają zwykłe edycje. Twórz małe, spójne commity z opisowymi komunikatami.
