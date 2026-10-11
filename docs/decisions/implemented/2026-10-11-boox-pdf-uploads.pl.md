# Opcjonalne wysyłanie PDF-ów na BOOX po commitach

[English](2026-10-11-boox-pdf-uploads.md) | Polski

Status: implemented

## Problem

Użytkownik dostarczył HAR wysyłania PDF-u i poprosił o automatyczne wysyłanie
zmienionych PDF-ów, konfigurację przez środowisko oraz szybkie pomijanie
transferów, gdy urządzenie lub endpoint są niedostępne. Adresy urządzeń i ścieżki
różnią się między komputerami i nie mogą być wpisane w kod repozytorium.

## Decyzja

Dodaj hook `post-commit` obok istniejących hooków walidacji. Skrypt wysyłający
czyta commitowane zwykłe pliki PDF z `BOOX_PDF_DIR` (domyślnie `output`)
i wysyła tylko obiekty blob nieobecne w zapisie ostatnich udanych transferów.
Pierwsze użycie wysyła cały wybór plików. Lokalny dla Git stan jest zapisywany
atomowo po każdym udanym transferze i dotyczy konkretnego endpointu,
katalogu na urządzeniu i katalogu PDF-ów.

Dostarczony HAR określa pola multipart `dir`, `sender=web` i `file`
oraz udaną odpowiedź JSON z `code: 0` i `successful: true`.
Używaj curl z limitami czasu połączenia i transferu, bez ponowień, przekierowań
i pośrednictwa proxy. Zatrzymaj się przy pierwszym niedostępnym lub odrzuconym
transferze; zachowaj oczekujące pliki na kolejny commit lub ręczne uruchomienie.
Błędy wysyłania nie mogą powodować niepowodzenia commita. Nie wysyłaj
niecommitowanej zawartości, nie usuwaj plików z urządzenia i nie odtwarzaj
nagłówków przeglądarki.

Używaj eksportowanych zmiennych `BOOX_*` lub literalnych przypisań
w ignorowanym `.env.boox`; eksportowane wartości mają pierwszeństwo.
Commituj pusty przykład konfiguracji; HAR i ustawienia konkretnego urządzenia
pozostają poza kontrolą wersji. Urządzenie z przechwyconego żądania używa HTTP,
więc dopuszczaj HTTP i HTTPS zgodnie ze skonfigurowanym endpointem.

## Rozważone alternatywy

**Wysyłanie przed commitem:** wiąże walidację repozytorium z dostępnością
urządzenia i może wysłać zmiany z commita, który później nie przejdzie sprawdzeń.
Wysyłanie po commicie korzysta z zaakceptowanej zawartości Git.

**Wysyłanie tylko różnic z ostatniego commita:** pomija PDF-y z wcześniejszych
commitów offline. Zapisy udanych transferów obiektów blob zachowują wybór
oczekujących plików bez osobnej kolejki.

**Wysyłanie wszystkich PDF-ów za każdym razem:** wydłuża transfer.
Porównania udanych transferów obiektów blob pomijają identyczną zawartość,
a pierwsze użycie inicjalizuje kolekcję na urządzeniu.

**Odwzorowanie podkatalogów:** wymaga dodatkowych API zarządzania katalogami
na urządzeniu, nieobecnych w dostarczonym zapisie. Używaj jednego istniejącego
katalogu docelowego i odrzucaj powtarzające się nazwy PDF-ów przed transferem.

## Konsekwencje

Włącz wspólne hooki w każdym klonie i skonfiguruj endpoint oraz katalog
na urządzeniu. Wymagane są Python 3 i curl. Commity offline pozostają szybkie;
aktywny transfer może trwać do skonfigurowanego limitu czasu. Oczekujące pliki
są ponawiane przy kolejnym commicie, także bez zmian PDF-ów, lub ręcznym
poleceniem z README. Zmiana celu lub usunięcie lokalnego stanu rozpoczyna pełną
synchronizację.

Testy uruchamiają rzeczywisty hook w izolowanych repozytoriach Git z symulowanymi
wynikami curl. Obejmują transfery przyrostowe, błędy offline i częściowe sukcesy,
sprawdzanie odpowiedzi BOOX, konfigurację, nazwy plików i zawartość commitowaną
w porównaniu z niecommitowaną. Transfer na rzeczywiste urządzenie nie został
zweryfikowany w środowisku deweloperskim z ograniczonym dostępem do sieci.
