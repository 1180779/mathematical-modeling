# Polityka językowa

[English](language-policy.md) | Polski

## Materiały do nauki

Pisz notatki z wykładów, objaśnienia, rozwiązania ręczne i powtórkę MATLAB-a po angielsku.
Dodawaj polskie odpowiedniki ważnych terminów do [wspólnego słownika](glossary.md).
Przy pierwszym użyciu można podać polski odpowiednik w nawiasie, jeżeli pomaga
powiązać angielskie pojęcie ze słownictwem zajęć. Pełne polskie rozdziały nie są wymagane.

Zachowuj otrzymane treści ćwiczeń w oryginalnym języku, podając źródło.
Oznaczaj tłumaczenia i zachowuj znaczenie matematyczne, notację oraz dane.
Stosuj angielskie identyfikatory i komentarze w MATLAB-ie, utrzymując jeden wspólny kod.

## Dokumentacja repozytorium

Łącz pliki README, przewodniki, wykazy źródeł i decyzje w pary `topic.md` i
`topic.pl.md`. Stosuj wzajemne odnośniki językowe, zgodną kolejność sekcji,
równoważną treść oraz identyczne polecenia, ścieżki, identyfikatory i wartości statusu.
Odnośniki do dokumentów w parach powinny wybierać język czytelnika. Słownik jest
dwujęzyczny w jednym pliku; `AGENTS.md`, notatki i szablony LaTeX są tylko po angielsku.

Aktualizuj obie wersje w tym samym commicie. Można zacząć od dowolnego języka;
rozbieżności należy rozwiązać przed commitem. Sprawdzaj znaczenie ręcznie:
obecność plików i zgodna struktura nie dowodzą poprawności tłumaczenia.
Każda para ma też sąsiadujący zapis `.i18n.json` z hashami sprawdzonych sekcji.
Po przeglądzie zmienionej pary uruchom
`python3 scripts/check_translations.py --write <English-file.md>` i commituj
wszystkie trzy pliki. Hook pre-commit porównuje hashe z indeksu, poziomy nagłówków,
wzajemne odnośniki językowe i dokładną treść bloków kodu. Bloki kodu są porównywane
osobno i wyłączone z hashy sekcji. Kluczami zapisu są ścieżki angielskich nagłówków;
polskie sekcje odpowiadają im według pozycji. Hashe SHA-256 obejmują nagłówek i
treść sekcji po usunięciu skrajnych białych znaków. Wykrywają zmiany od przeglądu,
ale nie poprawność znaczenia. Stosuj nagłówki ATX (`#`) w dokumentach parowanych;
skrypt celowo obsługuje obecny format repozytorium. Zakres obejmuje README i
dokumenty Markdown w `docs/`; `AGENTS.md`, notatki i pojedynczy dwujęzyczny słownik
nie są parowane. Potwierdzenie jest jawne: `--write` wymaga nazwanych par lub
wywołania `--write --all` dla całego zbioru.

## Ponowne rozważenie

To obecna polityka, a nie trwałe ograniczenie. Jeżeli przyda się ćwiczenie odpowiedzi
po polsku lub pełne polskie rozdziały, zapisz nową decyzję zastępującą
[początkową decyzję językową](decisions/implemented/2026-10-04-language-policy.pl.md).
