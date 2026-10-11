# Przegląd notatek i dalsza nauka

[English](notes-review.md) | Polski

## Zakres i wnioski

Data przeglądu: 2026-10-11. Przegląd obejmuje sześć dokumentów pojęciowych,
trzy dokumenty rozwiązań zestawu 1, powtórkę MATLAB-a oraz ścieżki czytania
i rejestry weryfikacji repozytorium. Dotyczy założeń matematycznych, ciągłości
objaśnień, użytecznych wizualizacji i materiału wartego dalszego poznania.
Nie ustala nowego programu kursu ani nie przelicza niezależnie każdej istniejącej
tablicy. Wcześniejsze zapisy dokładnych obliczeń i wyjście MATLAB-a przekazane
przez użytkownika pozostają osobnymi dowodami.

Podstawy PL są już obszerne: równoważność postaci standardowej, twierdzenia
o wierzchołkach/BRD z założeniami, wyprowadzenia cen zredukowanych i testu
ilorazów, inicjalizacja, degeneracja, dualność, komplementarność i wrażliwość
mają dowody, kontrprzykłady i przepracowane certyfikaty. Wszystkie dostarczone
zadania zestawu 1 mają rozwiązania lub certyfikaty wyniku przy wydrukowanych
danych. Główne możliwości rozwoju dotyczą połączeń tych tematów z szerszą
mapą optymalizacji, a nie kolejnych tablic tych samych metod.

Sprzeczność zdolności szlifowania i wyjątkowe wyniki ćwiczeń pozostają jawne.
Przegląd zachowuje dane oraz rozróżnienie punktu dopuszczalnego, użytecznej
bazy i certyfikatu. Powtórka wyjaśnia już wymiary tablic, operator backslash,
reszty i uwarunkowanie; nie wymaga drugiego omówienia tych tematów.

## Rozszerzenia i nowe rysunki

Poniższe nazwy sekcji odpowiadają spisom treści PDF-ów; numery rozdziałów
pozostają numeracją pojęciową.

| Dokument | Dodane objaśnienie | Nowy rysunek TikZ |
| --- | --- | --- |
| [Rozdział 1](../output/lectures/01-optimization-modeling.pdf) | Osiąganie optimum, zwartość i koercywność; optymalność lokalna/globalna; funkcje wypukłe i dowód przejścia od lokalnego do globalnego minimum | Cięciwa funkcji wypukłej i minima lokalne o różnych wartościach |
| [Rozdział 2](../output/lectures/02-linear-programming.pdf) | „What an integer relaxation can and cannot certify”: ograniczenia wartości, zaokrąglanie i dokładne rozwiązanie małego przykładu metodą podziału i ograniczeń | Wielokąt ciągły, punkty całkowite, optimum relaksacji i zadania całkowitoliczbowego |
| [Schematy modelowania](../output/lectures/02a-linear-modeling-patterns.pdf) | Wąskie gardła przekrojów, całkowitoliczbowość przepływów i zależne bilanse; decyzje uruchomienia; ograniczenia ważonych kryteriów wielocelowych | Sprzeczny przekrój; kompromisy Pareto w przestrzeni kryteriów |
| [Rozdział 3](../output/lectures/03-simplex-method.pdf) | „From a full tableau to revised simplex”: układy bazowe, wycena kolumn, faktoryzacja i ostrożność numeryczna | Cykl obliczeń zrewidowanej metody sympleks |
| [Rozdział 4](../output/lectures/04-degeneracy-and-duality.pdf) | Alternatywa Farkasa; reszty prymalne/dualne i ograniczenia z luki przy jawnej dopuszczalności | Wektor separujący w przestrzeni wartości równań |
| [Rozdział 5](../output/lectures/05-sensitivity-and-lagrange-multipliers.pdf) | Wystarczalność i konieczność nieliniowych KKT, Slater/LICQ, kontrprzykłady stacjonarne i krzywizna z ograniczeniami; stacjonarność bariery i luka | Jawna ścieżka centralna z dwiema zmiennymi |

Nowe przykłady są dodatkami objaśniającymi, a nie nowymi dostarczonymi zadaniami
kursowymi. Ich zgodność z bieżącym programem jest nieznana. Istniejące skrypty
MATLAB-a nie zostały zmienione; nowe przykłady mają ręczne wyprowadzenia
i niezależne sprawdzenia matematyczne, bez twierdzenia, że dotychczasowe skrypty
je wykonują.

## Dalsze kierunki w użytecznej kolejności

Są to opcjonalne kierunki nauki. Bieżący wykład i zestaw nie potwierdzają,
że będą wymagane na zaliczeniu. Przed implementacją algorytmu poznaj wskazane
podstawy.

| Kierunek | Czego nadal brakuje lub co jest tylko wprowadzone | Podstawy i konkretny następny krok |
| --- | --- | --- |
| Gładka optymalizacja bez ograniczeń | Rozwinięte omówienie poszukiwania kroku, metody gradientowej, Newtona i metod quasi-Newtona; założenia spadku i zbieżności | Rozróżnienie lokalności/globalności w rozdziale 1, gradienty i hesjany. Wyprowadź krok gradientowy i tłumiony krok Newtona dla dodatnio określonej funkcji kwadratowej, a następnie wyjaśnij możliwe niepowodzenie pełnego kroku Newtona przy niewypukłości |
| Nieliniowa optymalizacja z ograniczeniami | Pełne warunki drugiego rzędu, stożki krytyczne, zredukowane hesjany, SQP i rozszerzone funkcje Lagrange’a | KKT i rozróżnienia regularności w rozdziale 5. Zbadaj krzywiznę tylko w kierunkach dozwolonych przez równość, następnie sprawdź wpływ aktywnych nierówności na te kierunki |
| Algorytmy punktu wewnętrznego | Układy Newtona, starty dopuszczalne/niedopuszczalne, długości kroku, warunki zatrzymania i dowód zbieżności; sekcja bariery jest wstępem | Dualność z rozdziału 4 i zaburzona komplementarność z rozdziału 5. Wyprowadź równania Newtona dla `Ax=b`, `A^T y-c=q`, `x_j q_j=tau` i wskaż równania podlegające linearyzacji |
| Optymalizacja całkowitoliczbowa | Ogólna implementacja metody podziału i ograniczeń, poprawne cięcia, siła sformułowania i luki optymalności całkowitoliczbowej | Przykład relaksacji z rozdziału 2. Porównaj dwa równoważne sformułowania całkowitoliczbowe z różnymi ograniczeniami z PL; odróżnij najlepsze znalezione rozwiązanie od dowiedzionego optimum |
| Optymalizacja sieciowa | Dowód całkowitej unimodularności, konstrukcja maksymalnego przepływu/minimalnego przekroju, sprowadzenia przydziału i najkrótszej ścieżki; wyspecjalizowane algorytmy przepływu | Bilanse i przekroje ze schematów modelowania. Dodaj superźródło i superujście do testu dopuszczalności podaży/popytu, następnie wyjaśnij, dlaczego dodatkowy wiersz wspólnej zdolności może zniszczyć całkowitoliczbowość |
| Niegładka optymalizacja wypukła | Subgradienty, metody proksymalne i założenia ich zbieżności; cele z wartością bezwzględną i maksimum są obecnie obsługiwane zmiennymi pomocniczymi PL | Wypukłość i sformułowania regresji/celów. Wyprowadź subgradient wartości bezwzględnej w zerze i porównaj go z epigrafowym sformułowaniem PL |
| Niepewne dane i walidacja modelu | Optymalizacja odporna i stochastyczna, scenariusze, decyzje dostosowawcze i walidacja na nowych danych | Jednostki modelu i wrażliwość. Dla popytu `d in [d_min,d_max]` wymaganie `x >= d` dla każdej realizacji oznacza `x >= d_max`; ograniczenie oczekiwanego popytu daje inną gwarancję. Ustal, które decyzje poprzedzają obserwację popytu, a które mogą się dostosować |

Historyczna mapa wymienia wiele z tych tematów, ale repozytorium rozwija obecnie
głównie PL. Historyczne PDF-y 6–13 nie zostały włączone do notatek; ich obecność
nie potwierdza bieżącego zakresu. Nowe materiały kursowe powinny wyznaczyć kolejność
rozszerzeń, gdy będą dostępne.

## Dalsza lektura

Najpierw wykorzystaj wyprowadzenia w notatkach; poniższe źródła zawierają
szersze omówienia. [Inwentarz źródeł](sources.pl.md) rejestruje materiały
sprawdzone w tym przeglądzie i stan ich przechowywania lokalnego.

- [Boyd i Vandenberghe, *Convex Optimization*](https://web.stanford.edu/~boyd/cvxbook/): rozdziały 2–5 o wypukłości i dualności; rozdziały 9–11 o metodach bez ograniczeń, z równościami i punktu wewnętrznego.
- [MIT OCW, *Discrete optimization II*](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/d0be6aa7393f489a419add7cec874a4c_MIT6_251JF09_lec25.pdf): cięcia i metoda podziału i ograniczeń.
- [MIT OCW, *Networks 2: Network flows*](https://ocw.mit.edu/courses/15-053-optimization-methods-in-management-science-spring-2013/687225c151d8cc8254dcb8b07e5f9ce2_MIT15_053S13_lec16.pdf): sformułowania przepływów, całkowitoliczbowość i zastosowania sieciowe.

## Weryfikacja

W dniu 2026-10-11 użytkownik przekazał pomyślne wyjście skryptu schematów
modelowania i wszystkich trzech skryptów zestawu 1, potwierdzając tę samą wersję
MATLAB-a co wcześniej: 26.2.0.3386108 (R2026b). Wszystkie asercje przeszły.
Największa zgłoszona różnica między tablicą a obliczeniem z bazy w prymalnej
metodzie sympleks wyniosła `7.11e-15` przy tolerancji bezwzględnej `1e-10`.
Dokładne polecenia i wyjście zachowano w
[rejestrze weryfikacji](matlab-verification.pl.md).

Niezależne sprawdzenia wykorzystały dokładną arytmetykę wymierną dla relaksacji
całkowitoliczbowej i obu gałęzi, wartości wielomianu i znaków pochodnej, wektora
Farkasa oraz wąskiego gardła przepływu. Dodatniość, stacjonarność i lukę ścieżki
centralnej sprawdzono z precyzją 60 cyfr. Wszystkie dziesięć notatek ma unikalne
etykiety i poprawne lokalne cele odsyłaczy. Wszystkie siedem nowych rysunków
obejrzano w wyrenderowanych PDF-ach.

Wszystkie dziesięć PDF-ów zbudowano bez ostrzeżeń o przepełnieniu lub nierozwiązanych
odsyłaczach. Formatowanie, zapisy tłumaczeń i skróty źródeł/PDF-ów przeszły
istniejące kontrole repozytorium. Wykresy nowych przykładów
wynikają z ich wzorów; schematy przebiegu obliczeń są odpowiednio opisane.
Żadnego nowego wykonania MATLAB-a nie przypisano agentowi.
