# Oddzielenie kompilacji pośredniej od PDF-ów do czytania

[English](2026-10-04-pdf-build-and-output.md) | Polski

Status: implemented

## Problem

Ręczne polecenia LaTeX pozostawiają PDF-y do czytania razem z plikami pośrednimi.
Użytkownik poprosił o skrypt kompilacji i katalog zawierający wyłącznie PDF-y,
pogrupowane jak notatki, oraz wyłączenie kompilacji pośredniej z Git.
Metadane IntelliJ również muszą pozostać lokalne.

## Decyzja

`build.sh` kompiluje każdy dokument `.tex` z `notes/` do odpowiedniego podkatalogu
`build/`. Po udanej kompilacji wszystkich dokumentów kopiuje PDF-y do odpowiednich
ścieżek w `output/`. Oba drzewa zachowują względne katalogi i nazwy plików,
więc identyczne nazwy w różnych kategoriach nauki nie powodują kolizji.
Szablony są kompilowane osobno do podglądu i nie są eksportowane jako notatki.

Git ignoruje `build/`. Kopie PDF do czytania w `output/` są commitowane razem
ze źródłami, dzięki czemu notatki można bezpośrednio czytać z repozytorium.
Skrypt tworzy puste kategorie bez dodawania plików zastępczych innych niż PDF.
Po zmianie nazwy lub usunięciu notatki nieaktualne PDF-y usuwa się ręcznie.
Pliki IntelliJ `.idea/`, `*.iml`, `*.ipr` i `*.iws` są ignorowane.

## Rozważane alternatywy

**Jeden katalog na PDF-y i pliki pośrednie:** zachowuje dotychczasowy sposób pracy,
ale utrudnia przeglądanie kolekcji do czytania.

**Płaskie katalogi kompilacji:** dają prostsze ścieżki, ale dokumenty z różnych
kategorii mogą mieć tę samą nazwę i nadpisywać się wzajemnie.

**Nieśledzone PDF-y do czytania:** ograniczają zmiany binarne w Git, ale wymagają
instalacji TeX i kompilacji przed otwarciem notatek. Kolekcja do czytania pozostaje
w repozytorium; wyłączone jest tylko drzewo kompilacji pośredniej.

## Konsekwencje

Po zmianach notatek uruchom `./build.sh`, a następnie commituj źródła i odświeżone
PDF-y razem. Błąd kompilacji zatrzymuje skrypt przed aktualizacją kopii do czytania.
Kompilacja wymaga Bash, latexmk, pdfLaTeX i pakietów TeX wspólnego stylu.
Ustawienia IDE pozostają lokalne. Zasady kompilacji są opisane poza treścią dydaktyczną.
