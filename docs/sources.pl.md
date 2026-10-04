# Wykaz źródeł

[English](sources.md) | Polski

## Dawne wykłady

Obok repozytorium znajduje się trzynaście PDF-ów. Nazwa ich katalogu wskazuje na
wykłady z 2020 roku; wykład 1 zawiera harmonogram 2019/2020. Wykłady 1 i 2 zostały
przejrzane przy opracowaniu notatek; zgodność z obecnym prowadzącym, programem,
ćwiczeniami i laboratoriami jest niepotwierdzona.
Poniższe ścieżki są względem katalogu głównego repozytorium. Oryginały pozostają poza nim.

| Plik | Ścieżka lokalna |
| --- | --- |
| `s4_w1.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w1.pdf` |
| `s4_w2.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w2.pdf` |
| `s4_w3.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w3.pdf` |
| `s4_w4.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w4.pdf` |
| `s4_w5.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w5.pdf` |
| `s4_w6.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w6.pdf` |
| `s4_w7.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w7.pdf` |
| `s4_w8.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w8.pdf` |
| `s4_w9.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w9.pdf` |
| `s4_w10.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w10.pdf` |
| `s4_w11.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w11.pdf` |
| `s4_w12.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w12.pdf` |
| `s4_w13.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w13.pdf` |

Dla każdego opracowywanego tematu podawaj nazwę pliku i numery stron, odróżniaj
materiały źródłowe od dodanych objaśnień i zapisuj porównanie z obecnymi zajęciami.
Aktualny program, listy ćwiczeń i instrukcje laboratoriów nie zostały jeszcze dostarczone.

## Opracowane notatki i doprecyzowania źródeł

- Wykład 1: `s4_w1.pdf`, strony PDF 1–6; wprowadzenie i dawny plan przedmiotu.
- Wykład 2: `s4_w2.pdf`, strony PDF 1–11, slajdy numerowane 1–44; modele PL,
  postać standardowa, geometria i bazy. Wzory regresji oraz szkic szafki
  sprawdzono również wizualnie.
- Notatki odróżniają dodane dowody i wyprowadzenia ręczne od treści slajdów.
  Doprecyzowania obejmują przychód i zysk, dokładny i minimalny popyt,
  całkowitoliczbowe i ciągłe liczby cięć, ścisłe kombinacje wypukłe,
  kierunki recesji dla domkniętych zbiorów wypukłych, reprezentację zbiorów
  wielościennych niezawierających prostych oraz założenia twierdzenia o optymalnym wierzchołku.
- Rozwiązanie zadania z szafkami i deskami 2 m zakłada trzy elementy 0,8 m oraz
  dwa elementy 0,3 m na szafkę, zerowy rzaz i brak naddatków na połączenia
  lub grubość; założenia te wykraczają poza informacje technologiczne szkicu.

## Źródła uzupełniające poza repozytorium

[MIT OCW 15.081J/6.251J, Lecture 10 (Fall 2009)](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/ab890d20b071105239fe0b9bcf599f57_MIT6_251JF09_lec10.pdf),
strony PDF 4 i 6, przeczytano przez narzędzie web w celu sprawdzenia stożka recesji
oraz założeń reprezentacji za pomocą wierzchołków i promieni. Materiał uzupełnia
dawny wykład; nie potwierdza obecnego zakresu przedmiotu.

Planowana ścieżka lokalna względem repozytorium:
`../sources/mit/mit-6-251j-2009-lecture-10-polyhedral-representation.pdf`.
**Nie pobrano:** rozwiązywanie nazwy DNS w powłoce nie powiodło się 2026-10-04.
Zewnętrzny plik `../sources/README.md` zawiera oficjalny URL i polecenie ponowienia pobrania.

## Dokumentacja do powtórki MATLAB-a

Powtórka 1 zawiera własne przykłady ręczne oraz poniższe oficjalne źródła MathWorks
dotyczące tablic, indeksowania, operatorów, rozwiązywania układów i eksportu wykresów.
Równania produkcji pochodzą z `s4_w2.pdf`, slajdy 7–9.

- [Matrices and Arrays](https://www.mathworks.com/help/matlab/learn_matlab/matrices-and-arrays.html)
- [Array Indexing](https://www.mathworks.com/help/matlab/math/array-indexing.html)
- [Array vs. Matrix Operations](https://www.mathworks.com/help/matlab/matlab_prog/array-vs-matrix-operations.html)
- [mldivide](https://www.mathworks.com/help/matlab/ref/double.mldivide.html)
- [exportgraphics](https://www.mathworks.com/help/matlab/ref/exportgraphics.html)

## Pochodzenie stylu AZ

Styl dostosowano na podstawie preambuł i organizacji `Lecture_5May.tex`
i `egzamin_AZ.tex` w:

`/home/rdkgsk/Documents/Studies/masters/sem1/az/AZ_lectures`

Nie znaleziono osobnego szablonu, pakietu stylu ani przewodnika pisania w podanym
checkoutcie, również na liście śledzonych plików. Nowy styl wyodrębnia wspólny
układ i konwencje twierdzeń, używa angielskich etykiet i dodaje listingi MATLAB.
Do notatek nie skopiowano treści przedmiotu AZ.
