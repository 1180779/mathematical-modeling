# Wysyłanie na BOOX podczas opracowywania notatek

[English](2026-10-24-boox-development-uploads.md) | Polski

Status: implemented

## Problem

Skrypt odczytuje obiekty blob Git z `HEAD`, więc ponowna kompilacja notatek
nie udostępnia niezacommitowanych PDF-ów do wysłania. Użytkownik potrzebuje
czytać wersje robocze na BOOX podczas pracy nad notatkami.

## Decyzja

Dodajemy jawny wybór `--working-tree` lokalnych zwykłych PDF-ów, także nowych
i ignorowanych plików w `BOOX_PDF_DIR`. Pomijamy dowiązania symboliczne
i utrwalamy zawartość przed wysyłaniem. `make upload-boox-dev` najpierw
kompiluje, odświeża `output/`, a potem wysyła aktualne pliki. Nieudana kompilacja
blokuje to wysyłanie. Flaga pozwala też wybrać istniejące PDF-y w `build/`
bez ich eksportowania.

Zachowujemy wybór z commita dla hooka i `make upload-boox`. Oba tryby
współdzielą identyfikatory zawartości blobów Git i stan udanych transferów.
Commit niezmienionej wysłanej wersji roboczej nie powoduje ponownego transferu;
wysłanie z `HEAD` po wersji roboczej przywraca na urządzeniu bajty z commita.
Zachowujemy katalogi względne i obsługę błędów z
[decyzji o układzie katalogów](2026-10-19-boox-directory-layout.pl.md).
Rozszerzamy jej regułę wyboru wyłącznie commitowanych plików o jawne wysyłanie
wersji roboczych.

## Alternatywy

- Wymaganie commita dla każdej wersji roboczej przerywa pracę nad notatkami.
- Zmiana hooka, aby wysyłał pliki lokalne, mogłaby przesłać niepowiązane edycje.
- Oddzielny stan każdego trybu może błędnie pominąć transfer po nadpisaniu
  kopii na urządzeniu przez drugi tryb.

## Konsekwencje

Transfery robocze nie wymagają dodawania do indeksu ani commitowania.
Bezpośredni wybór `build/` obejmuje każdy PDF, także podglądy szablonów,
jeśli istnieją. Katalogi na urządzeniu muszą istnieć. Testy integracyjne
zastępują curl, obejmując wersje robocze, nowe i ignorowane PDF-y, dowiązania,
ponowienia oraz przełączanie między zawartością lokalną i commitowaną.
Nie potwierdzają powodzenia transferu na rzeczywiste urządzenie.
