# Rejestr decyzji

[English](README.md) | Polski

## Cel

Zapisuj trwałe wybory i otwarte propozycje dotyczące organizacji nauki, notacji,
języka, szablonów i narzędzi. Jest to lista decyzji i propozycji, a nie transkrypcja
rozmów ani zamiennik historii Git.

## Cykl życia

Używaj katalogów `proposed/`, `implemented/`, `rejected/` i `superseded/`.
Nazywaj pary `YYYY-MM-DD-topic.md` i `YYYY-MM-DD-topic.pl.md`, używając daty
pierwszej propozycji. Utwórz propozycję dla nierozstrzygniętego wyboru; nie wymyślaj
propozycji tylko po to, aby zapełnić listę. Przy zmianie statusu przenoś oba pliki,
aktualizuj status i naprawiaj odnośniki. Nie zapisano jeszcze nierozstrzygniętych propozycji.

Wdrożona decyzja opisuje faktycznie obowiązującą politykę lub strukturę.
Odrzucona propozycja zachowuje uzasadnienie. Gdy decyzja się zmienia, dodaj nowy
wpis i powiąż go z zastąpionym wpisem; zachowaj dawne uzasadnienie.

## Format

Zacznij od tytułu, wzajemnego odnośnika językowego oraz `Status: proposed`,
`Status: implemented`, `Status: rejected` lub `Status: superseded`.
Zachowaj identyczne tokeny statusu w obu językach. Zapisuj:

- Problem i kontekst.
- Decyzję albo propozycję, jeśli wybór jest nierozstrzygnięty.
- Rzeczywiście rozważane alternatywy i powody ich niewybrania.
- Konsekwencje wdrożonych decyzji; kryteria akceptacji i ryzyka propozycji.
- Powód odrzucenia lub odnośnik do nowej decyzji, jeśli dotyczy.

Aktualizuj oba języki w tym samym commicie, zachowując znaczenie i kolejność sekcji.
Twórz wpisy dla istotnych wyborów; zwykłe edycje opisuj komunikatami commitów.
Ta uproszczona konwencja jest inspirowana
[Agent Notes projektu DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness/blob/master/.agents/notes/README.md)
i jego [polityką dwujęzyczną](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/i18n/README.md).
Nie przejmuje katalogów klasyfikacji, plików z hashami ani mechanizmu archiwizacji.
