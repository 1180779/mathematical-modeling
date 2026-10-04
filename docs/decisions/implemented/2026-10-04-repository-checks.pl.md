# Sprawdzanie commitów, par językowych, PDF-ów i formatowania

[English](2026-10-04-repository-checks.md) | Polski

Status: implemented

## Problem

Użytkownik poprosił o krótkie, uporządkowane komunikaty commitów, sprawdzanie hashy
podobne do DeepSeek, kontrolę integralności PDF-ów oraz spójne formatowanie TikZ
z użyciem obecnej konfiguracji Neovima. Treść edytora może różnić się od indeksu,
więc sprawdzanie tylko katalogu roboczego nie zapewnia poprawnej kontroli commitu.

## Decyzja

Stosujemy wersjonowane hooki `.githooks/`, włączane w każdym klonie przez
`core.hooksPath`. Hook komunikatu wymaga najwyżej 72 znaków Unicode w wierszu
oraz pustego wiersza przed opcjonalnym opisem. Komentarze edytora Git są pomijane.
Sprawdzenia pre-commit czytają indeks Git.

Angielsko-polskie pary Markdown mają zapisy SHA-256 sekcji w sąsiadujących
plikach `.i18n.json`. Przejrzyj oba języki przed jawnym zapisaniem pary.
Nagłówki odpowiadają sobie według poziomu i kolejności; bloki kodu muszą być
identyczne i nie wchodzą do hashy sekcji. Podejście przejmuje zapis przeglądu z
[dwujęzycznej konwencji DeepSeek](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/i18n/README.md),
stosując JSON i bibliotekę standardową Pythona w tym mniejszym repozytorium.
Zastępuje początkową decyzję o pominięciu plików hashy, zachowując politykę
angielskich notatek i dwujęzycznej dokumentacji.

`build.sh` zapisuje hashe SHA-256 eksportowanych PDF-ów i danych wejściowych w
`docs/pdf-build.json`. Kontrola wykrywa zmiany notatek, plików rysunków, wspólnego
stylu oraz kopii PDF po kompilacji. Porównuje też dostępne pośrednie PDF-y z
wynikami; w pre-commit to porównanie dotyczy tylko zmian PDF-ów w indeksie.
Świeży klon może sprawdzić commitowane hashe bez plików pośrednich.

Stosujemy latexindent z `.latexindent.yaml` do źródeł `.tex`, `.sty` i `.tikz`.
Obecne grafiki pozostają wewnątrz plików wykładowych. `.editorconfig` oraz
projektowy `.nvim.lua` odpowiadają ustawieniom polecenia; formatter projektu w
Conform dotyczy typów plików TeX. Globalne ustawienia Neovima nie są edytowane.

## Rozważane alternatywy

**Hooki tylko dla katalogu roboczego:** prostsze, ale mogą pominąć błędy indeksu
zamaskowane poprawkami poza nim. Kontrola czyta pliki i konfigurację z indeksu.

**Jeden hash całego zbioru:** wykrywa zmiany, ale nie wskazuje sekcji wymagającej
przeglądu. Zapisy sekcji ułatwiają przegląd tłumaczenia i różnic.

**Pełne narzędzia DeepSeek:** wprowadzają niepotrzebne wymagania pakietów i pracy.
Mniejsza implementacja sprawdza kompletność par, nagłówki, bloki kodu, wzajemne
odnośniki i hashe przeglądu bez pełnego parsera Markdown.

**Obowiązkowe pośrednie PDF-y:** uniemożliwiają sprawdzenie świeżego klonu.
Commitowany zapis kompilacji stanowi punkt odniesienia; dostępne lokalne kopie
pośrednie pozwalają dodatkowo porównać bajty.

## Konsekwencje

Włącz hooki w każdym klonie. Przeglądaj tłumaczenia przed aktualizacją zapisów;
hashe nie dowodzą równoważności znaczenia. Formatuj źródła, kompiluj i dodawaj
do indeksu nowe PDF-y razem z manifestem. Błędy hooków opisują sposób poprawki.
Żaden hook nie zapisuje ani nie dodaje plików do indeksu automatycznie.
Sprawdzenia wymagają Python 3 i latexindent. Celowo obsługują obecny format
Markdown ATX i nie odtwarzają pełnej kontroli strukturalnej DeepSeek.
