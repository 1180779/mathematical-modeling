# Przechowywanie dodatkowych PDF-ów poza repozytorium notatek

[English](2026-10-04-external-source-storage.md) | Polski

Status: implemented

## Problem

Dodatkowe źródła pomagają doprecyzować dawne wykłady, ale pobrane PDF-y zwiększałyby
rozmiar repozytorium notatek materiałami referencyjnymi. Użytkownik poprosił
2026-10-04 o przechowywanie ich w nadrzędnym katalogu przedmiotu.

## Decyzja

Dodatkowe PDF-y należą do `../sources/`, z podziałem według dostawcy (początkowo `mit/`).
Oryginalne dawne wykłady zachowują dotychczasowe położenie. Dwujęzyczny wykaz źródeł
repozytorium podaje pochodzenie, planowane ścieżki, faktyczny status pobrania i sposób
wykorzystania każdej pozycji. Zewnętrzny `../sources/README.md` opisuje pobieranie.
Struktura już istnieje; pobranie pierwszego PDF-u MIT pozostaje oczekujące,
ponieważ rozwiązywanie nazw DNS w powłoce nie powiodło się.

## Rozważane alternatywy

**PDF-y w repozytorium notatek:** odrzucone zgodnie z prośbą użytkownika, aby
materiały referencyjne pozostawały poza nim.

**Tymczasowe pobieranie do `/tmp`:** próba podjęta, gdy katalog nadrzędny znajdował
się poza zapisywalnym obszarem roboczym; użytkownik następnie rozszerzył go do
katalogu przedmiotu, umożliwiając trwałe utworzenie katalogu źródeł. Tymczasowe
przechowywanie nie jest już wybraną lokalizacją.

## Konsekwencje

Repozytorium Git skupia się na własnych notatkach i skryptach. Sąsiadujący katalog
źródeł trzeba kopiować osobno przy przenoszeniu projektu. Oficjalne odnośniki i jawny
status pobrania zapobiegają przedstawianiu brakującego pliku jako dostępnego.
Korzystanie z uzupełnienia nie potwierdza obecnego programu przedmiotu.
