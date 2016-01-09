# language: de
@javascript
Funktionalität: Bestehenden Content auf einer Seite übersetzen
  Als Mitarbeiter möchte ich,
  um Inhalte in einer Seite übersetzen zu können,
  angezeigt bekommen, das diese Inhalte noch nicht übersetzt sind.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Editor        |
    Und ein Abschnitt auf der Startseite mit Inhalten für "en".
    Und die App ist im Browser geladen.
    Und eine Anmeldung als Editor.

  Szenario: Nicht auf Deutsch übersetzte Inhalte werden als nicht übersetzt angezeigt.
    Wenn ich mich auf der Startseite befinde.
    Und ich "de" als Sprache auswähle.
    Dann möchte ich "Abschnitt noch nicht übersetzt." sehen.

  Szenario: Nicht auf Französisch übersetzte Inhalte werden als nicht übersetzt angezeigt.
    Wenn ich mich auf der Startseite befinde.
    Und ich "fr" als Sprache auswähle.
    Dann möchte ich "article pas encore traduit." sehen.

  Szenario: Nicht auf Spanisch übersetzte Inhalte werden als nicht übersetzt angezeigt.
    Wenn ich mich auf der Startseite befinde.
    Und ich "es" als Sprache auswähle.
    Dann möchte ich "sección no traducido aún." sehen.

  Szenario: Nicht auf Russisch übersetzte Inhalte werden als nicht übersetzt angezeigt.
    Wenn ich mich auf der Startseite befinde.
    Und ich "ru" als Sprache auswähle.
    Dann möchte ich "раздел пока не переведено." sehen.
