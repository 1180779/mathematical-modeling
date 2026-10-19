# Zachowanie katalogów wyjściowych przy wysyłaniu na BOOX

[English](2026-10-19-boox-directory-layout.md) | Polski

Status: implemented

## Problem

Użytkownik poprosił o taki sam podział katalogów na BOOX jak w `output/`.
Wcześniejszy skrypt spłaszczał nazwy i odrzucał powtarzające się nazwy bazowe.

## Decyzja

Zachowuj katalog nadrzędny każdego commitowanego PDF-u względem `BOOX_PDF_DIR`
pod `BOOX_REMOTE_DIR`. PDF na poziomie głównym używa katalogu bazowego urządzenia.
Powtarzające się nazwy bazowe w różnych katalogach są dozwolone. Nadal wysyłaj
wyłącznie commitowane obiekty blob, zapisuj sukces po każdym pliku i zatrzymuj
się po pierwszym odrzuceniu. Przy błędzie podkatalogu nigdy nie przechodź do katalogu bazowego.

Wersjonuj stan celu przez `relative-directories-v1`, aby wcześniejsze zapisy
płaskich transferów nie pomijały pierwszego wysłania do właściwych katalogów.
Zachowaj istniejące płaskie kopie; nie usuwaj plików zdalnych.

To zastępuje wybór płaskiego celu z
[pierwotnej decyzji o wysyłaniu](2026-10-11-boox-pdf-uploads.pl.md). Zapisane API
potwierdza pola wysyłania, ale nie operację tworzenia katalogu. Odpowiednie
podkatalogi urządzenia muszą już istnieć; dokumentuj ten wymóg konfiguracji,
zamiast wymyślać endpoint lub deklarować automatyczne tworzenie katalogów.

## Alternatywy

- Jeden katalog docelowy traci zamówiony podział.
- Prefiksy nazw plików z nazwami katalogów nie tworzą rzeczywistych podkatalogów.
- Zgadywanie endpointu tworzenia katalogów nie ma oparcia w dostarczonym zapisie API.

## Weryfikacja

Testy integracyjne używają rzeczywistych repozytoriów Git i właściwego hooka,
zastępując granicę sieciową curl. Sprawdzają cele względne i zagnieżdżone,
powtarzające się nazwy bazowe, pliki głównego poziomu, migrację stanu płaskiego,
transfery przyrostowe, częściowy sukces i odrzucenie bez spłaszczania.
Zachowano istniejące sprawdzenia offline i commitowanej zawartości. Testy te
nie potwierdzają transferów na rzeczywiste urządzenie.
