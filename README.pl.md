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
  ([PDF](build/01-optimization-modeling.pdf)): zmienne, ograniczenia, funkcje celu,
  klasyfikacja i historyczny zakres powtórki MATLAB-a.

- [Wykład 2: Programowanie liniowe—modele i geometria](notes/lectures/02-linear-programming.tex)
  ([PDF](build/02-linear-programming.pdf)): przykłady modeli, postać standardowa,
  kierunki recesji, optymalne wierzchołki i bazowe rozwiązania dopuszczalne.

Odnośniki do PDF-ów wskazują lokalne wyniki kompilacji, które nie są commitowane.

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
skrypt sprawdzający z wykładu 2 nie został jeszcze uruchomiony w MATLAB-ie.

Skompiluj oba PDF-y wykładów z katalogu głównego repozytorium:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build notes/lectures/01-optimization-modeling.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build notes/lectures/02-linear-programming.tex
```

## Sprawdzenia MATLAB z wykładu 2

```matlab
run('matlab/exercises/lecture-02-checks.m')
```

Uruchom z katalogu głównego repozytorium. Skrypt sprawdza przykłady ręczne za pomocą
podstawowego MATLAB-a; Optimization Toolbox nie jest wymagany. Wykonanie w MATLAB-ie pozostaje niezweryfikowane.

## Sposób pracy

Porównaj dawne materiały z aktualnym wykładem lub zadaniem, zanim uznasz je za
obecny zakres przedmiotu. Napisz objaśnienie matematyczne i rozwiązanie ręczne,
a następnie sprawdź te same dane w MATLAB-ie. Zapisuj założenia, jednostki,
ustawienia solvera i rozbieżności. Dodawaj napotkane polskie terminy do słownika.

Aktualizuj obie wersje językowe przewodników i decyzji w tej samej zmianie.
Zapisuj istotne decyzje wraz z alternatywami i konsekwencjami; commity Git
utrwalają zwykłe edycje. Twórz małe, spójne commity z opisowymi komunikatami.
