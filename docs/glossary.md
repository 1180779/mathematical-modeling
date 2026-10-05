# Polish–English glossary / Słownik polsko-angielski

One shared vocabulary for English notes and Polish classes.
Wspólne słownictwo angielskich notatek i polskich zajęć.

Add terms when they occur in actual study material. Record context and notation;
flag uncertain equivalents for review against the lecturer's terminology.
Dodawaj terminy przy pracy nad materiałem. Zapisuj kontekst i notację;
oznaczaj niepewne odpowiedniki do sprawdzenia z terminologią prowadzącego.

| Polski | English | Notation / Notacja | Context / Kontekst |
| --- | --- | --- | --- |
| programowanie matematyczne | mathematical programming | — | Optimization / Optymalizacja |
| zmienna decyzyjna | decision variable | x_j | Chosen quantity / Wielkość wybierana |
| funkcja celu | objective function | f(x) | Criterion / Kryterium |
| ograniczenie | constraint | g_i(x) ≤ 0; h_j(x) = 0 | Feasibility condition / Warunek dopuszczalności |
| zbiór rozwiązań dopuszczalnych | feasible set | Ω | All admissible decisions / Wszystkie dopuszczalne decyzje |
| rozwiązanie dopuszczalne | feasible solution | x ∈ Ω | Satisfies constraints / Spełnia ograniczenia |
| rozwiązanie optymalne | optimal solution | x* | Best feasible decision / Najlepsza dopuszczalna decyzja |
| wartość optymalna | optimal value | f(x*) | Objective value / Wartość funkcji celu |
| programowanie liniowe | linear programming | LP; PL; ZPL | Continuous variables / Zmienne ciągłe |
| programowanie całkowitoliczbowe | integer programming | — | Indivisible decisions / Niepodzielne decyzje |
| programowanie wypukłe | convex optimization | — | Convex objective and feasible set (min) / Wypukła funkcja celu i zbiór dopuszczalny (min) |
| analiza wrażliwości | sensitivity analysis | — | Dependence on data / Zależność od danych |
| zmienna dopełniająca (ograniczenie ≤) | slack variable | s ≥ 0 | Unused capacity / Niewykorzystana zdolność |
| zmienna nadwyżkowa (ograniczenie ≥) | surplus variable | s ≥ 0 | Excess above requirement / Nadwyżka ponad wymaganie |
| postać standardowa | standard form | Ax = b, x ≥ 0 | Maximization in these lectures / Maksymalizacja w tych wykładach |
| hiperpłaszczyzna | hyperplane | aᵀx = b | a ≠ 0 |
| półprzestrzeń domknięta | closed halfspace | aᵀx ≤ b | Linear inequality / Nierówność liniowa |
| zbiór wielościenny | polyhedron | P | Finite intersection of closed halfspaces / Skończony przekrój półprzestrzeni domkniętych |
| wielościan (ograniczony zbiór wielościenny) | polytope | P | Bounded polyhedron / Ograniczony zbiór wielościenny |
| punkt ekstremalny; wierzchołek | extreme point; vertex | v | Not strictly between feasible points / Nie leży ściśle między punktami dopuszczalnymi |
| kierunek otwarcia; kierunek recesji | recession direction | d | Feasible for all nonnegative steps / Dopuszczalny dla wszystkich nieujemnych kroków |
| promień ekstremalny | extreme ray | {αd: α ≥ 0} | Ray of the recession cone / Promień stożka recesji |
| baza | basis | B; A_B | Independent columns / Niezależne kolumny |
| rozwiązanie bazowe | basic solution | x_N = 0 | May be infeasible / Może być niedopuszczalne |
| bazowe rozwiązanie dopuszczalne | basic feasible solution | BFS | Nonnegative basic solution / Nieujemne rozwiązanie bazowe |
| degeneracja | degeneracy | — | At least one zero basic coordinate / Co najmniej jedna zerowa zmienna bazowa |
| relaksacja liniowa | LP relaxation | — | Integrality omitted / Pominięte warunki całkowitoliczbowości |
| odpad | offcut; waste | r_j | Unused stock length / Niewykorzystana długość surowca |
| rzaz | saw kerf | — | Material removed by cutting / Materiał usunięty podczas cięcia |
| reszta regresji | regression residual | e_i | Observed minus fitted value / Wartość obserwowana minus dopasowana |
| wektor wierszowy | row vector | 1 × n | Horizontal array / Tablica pozioma |
| wektor kolumnowy | column vector | n × 1 | Decision-vector convention / Konwencja wektora decyzji |
| indeksowanie | indexing | M(i,j) | Selecting entries / Wybór elementów |
| operacje elementowe | element-wise operations | .*, ./, .^ | Operations on corresponding entries / Operacje na odpowiadających elementach |
| uchwyt do funkcji | function handle | @ | Callable reference / Odwołanie do funkcji |
| reszta układu równań | linear-system residual | Ax − b | Equation mismatch / Niedopasowanie równań |
| postać kanoniczna względem bazy | canonical form relative to a basis | Ā_B = I, b̄ ≥ 0 | Feasible basis equations / Równania bazy dopuszczalnej |
| współczynniki wymiany | transformed constraint coefficients | Ā = A_B⁻¹A | Simplex tableau / Tablica sympleksowa |
| cena zredukowana | reduced cost | ρ_j = c_j − c_BᵀA_B⁻¹a_j | Positive improves a maximization objective / Dodatnia poprawia funkcję maksymalizowaną |
| wskaźnik optymalności | optimality indicator | q_j = z_j − c_j = −ρ_j | Nonnegative indicators certify max optimum / Nieujemne wskaźniki potwierdzają optimum maksymalizacji |
| zmienna wprowadzana do bazy | entering variable | x_k | Nonbasic variable selected for a pivot / Zmienna niebazowa wybrana do wymiany |
| zmienna wyprowadzana z bazy | leaving variable | x_{j_r} | Basic variable reaching zero / Zmienna bazowa osiągająca zero |
| element główny; element pivot | pivot element | Ā_rk | Nonzero entry used for a basis exchange / Niezerowy element wymiany bazy |
| test ilorazów; kryterium wyjścia | ratio test | θ* = min_{u_i > 0} b̄_i/u_i | Largest feasible simplex step / Największy dopuszczalny krok sympleksowy |
| tablica sympleksowa | simplex tableau | [Ā, b̄; qᵀ, z₀] | Constraint and objective rows / Wiersze ograniczeń i funkcji celu |
| zmienna sztuczna | artificial variable | a_i ≥ 0 | Temporary feasibility aid; must vanish / Tymczasowa pomoc w znalezieniu dopuszczalności; musi zniknąć |
| metoda dwufazowa | two-phase method | Phase I / Phase II | Establish feasibility, then optimize / Najpierw dopuszczalność, potem optymalizacja |
| metoda dużego M; metoda kar | Big M method; penalty method | cᵀx − MΣa_i | Maximization penalty for artificials / Kara za zmienne sztuczne przy maksymalizacji |
| cykl; zapętlenie | cycling | Repeated basis / Powtórzona baza | Possible with degenerate pivots / Możliwe przy zdegenerowanych wymianach |
| reguła Blanda | Bland's rule | Smallest original indices / Najmniejsze oryginalne indeksy | Anti-cycling pivot selection / Wybór wymian zapobiegający cyklom |
| ograniczenie nadmiarowe | redundant constraint | Dependent equality / Zależne równanie | Removal preserves feasible set / Usunięcie zachowuje zbiór dopuszczalny |
| zadanie prymalne; zadanie pierwotne | primal problem | P; ZP | Original member of a dual pair / Pierwotny element pary dualnej |
| zadanie dualne | dual problem | D; ZD | Bound problem / Zadanie wyznaczające ograniczenie wartości |
| słaba dualność | weak duality | cᵀx ≤ bᵀy (max primal) | Any feasible pair / Dowolna para dopuszczalna |
| silna dualność | strong duality | z* = w* | Existence and equality of finite optima / Istnienie i równość skończonych optimów |
| luka dualności | duality gap | bᵀy − cᵀx (max primal) | Nonnegative for feasible pairs / Nieujemna dla par dopuszczalnych |
| zasada komplementarności | complementary slackness | y_i s_i = x_j t_j = 0 | Feasible optimal primal–dual pair / Dopuszczalna optymalna para prymalna–dualna |
| cena dualna; cena zasobu | dual price; resource price | y_i | RHS marginal value within a valid basis range / Krańcowa wartość prawej strony w zakresie ważności bazy |
| rozwiązanie bazowe dualnie dopuszczalne | dual feasible basic solution | BRDD; q ≥ 0 | Primal coordinates may be negative / Współrzędne prymalne mogą być ujemne |
| dualna metoda sympleks | dual simplex method | q ≥ 0 | Repairs primal feasibility / Przywraca dopuszczalność prymalną |
| metoda perturbacji | perturbation method | b(ε) | Symbolic RHS changes / Symboliczne zmiany prawej strony |
| porządek leksykograficzny | lexicographic order | L_i | First differing coordinate decides / Decyduje pierwsza różna współrzędna |
| reguła leksykograficzna | lexicographic pivot rule | lex min L_i | Anti-cycling ratio test / Test ilorazów zapobiegający cyklom |
| krok zerowy; martwy krok | zero-length step; stalled pivot | θ* = 0 | Same point, different basis / Ten sam punkt, inna baza |
| złożoność pesymistyczna | worst-case complexity | input bit length / długość bitowa danych | Requires algorithm and cost model / Wymaga algorytmu i modelu kosztu |
| metoda punktu wewnętrznego | interior-point method | — | Interior iterates / Iteracje wewnątrz zbioru |
| certyfikat sprzeczności | infeasibility certificate | hᵀA ≥ 0, hᵀb < 0 | Contradicts Ax = b, x ≥ 0 / Zaprzecza Ax = b, x ≥ 0 |
| ściana optymalna | optimal face | cᵀx = z* | All optimizers in a polyhedron / Wszystkie optima w zbiorze wielościennym |
| analiza post-optymalizacyjna | post-optimality analysis | — | Reuse a solved model / Wykorzystanie rozwiązanego modelu |
| analiza przedziałowa | one-parameter range analysis | L ≤ t ≤ U | Hold a certifying basis / Zachowanie bazy z certyfikatem |
| cena dualna; cena cienia | shadow price | y_r | RHS marginal value on a valid branch / Krańcowa wartość prawej strony na ważnej gałęzi |
| zmiana strukturalna | structural change | new/deleted row or column / nowy/usunięty wiersz lub kolumna | Modify model dimensions / Zmiana wymiarów modelu |
| ponowna optymalizacja | reoptimization | — | Start with a previous basis / Start z poprzedniej bazy |
| region dopuszczalnych zmian danych | allowable parameter region | A_B⁻¹b ≥ 0; q ≥ 0 | Coupled data conditions / Sprzężone warunki na dane |
| zbiór ograniczeń aktywnych | active set | 𝒜(x) | Tight inequalities / Nierówności spełnione równościowo |
| ograniczenie aktywne | active constraint | g_i(x) = 0 | Can have zero multiplier / Może mieć zerowy mnożnik |
| stożek normalny | normal cone | cone of active outward normals / stożek aktywnych normalnych zewnętrznych | Supports an optimum / Podpiera optimum |
| mnożnik Lagrange’a | Lagrange multiplier | λ_i; ν_j | Inequalities nonnegative, equalities free / Nierówności nieujemne, równości dowolne |
| funkcja Lagrange’a | Lagrangian | L(x, λ, ν) | Weighted objective and constraints / Ważona funkcja celu i ograniczenia |
| warunki Karusha–Kuhna–Tuckera | Karush–Kuhn–Tucker conditions | KKT | Feasibility, signs, complementarity, stationarity / Dopuszczalność, znaki, komplementarność, stacjonarność |
| stacjonarność | stationarity | ∇_x L = 0 | Normal balance / Równowaga normalnych |
| kwalifikacja ograniczeń | constraint qualification | CQ | Regularity for multiplier necessity / Regularność dla konieczności mnożników |
| warunek Slatera | Slater's condition | strict feasibility / ścisła dopuszczalność | Convex constraint qualification / Kwalifikacja ograniczeń w zadaniu wypukłym |
| problem mieszania | blending problem | y = Σx_i | Mass balance and quality / Bilans masy i jakość |
| przepływ o minimalnym koszcie; najtańszy przepływ | minimum-cost flow | Bf = s | Capacitated directed network / Skierowana sieć z przepustowościami |
| bilans przepływu | flow balance | inflow + supply = outflow | Node conservation / Zachowanie w wierzchołku |
| zapas magazynowy | inventory | I_k | Material carried forward / Materiał przenoszony na później |
| programowanie celowe | goal programming | u, v ≥ 0 | Deliberately softened requirements / Celowo zmiękczone wymagania |
| zmienna odchylenia | deviation variable | u, v | One-sided target violation / Jednostronne naruszenie wymagania |
| skalaryzacja | scalarization | Σw_i f_i | Combine objectives with stated preferences / Łączenie celów według jawnych preferencji |
| optimum Pareto | Pareto optimum | — | No feasible improvement without worsening another criterion / Brak dopuszczalnej poprawy bez pogorszenia innego kryterium |
