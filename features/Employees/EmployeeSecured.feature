# language: de
@javascript
Funktionalität: Mitarbeiter ohne Autorisierung aufrufen, bearbeiten oder löschen
  Als Betreiber möchte ich
  um Daten selektiv zu schützen,
  unautorisierte Besucher auf die Login-Seite umleiten.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Employee      |
    Und ein Mitarbeiter mit dem Vornamen "Hans", dem Nachnamen "Meier", der Email "hans.meier@example.com" und der Rolle "Administrator".
    Und die App ist im Browser geladen.

  Szenario: Mitarbeiterübersicht ohne Autorisierung aufrufen
    Wenn ich die "Mitarbeiterübersicht"-Seite aufrufe.
    Dann sollte ich auf die "Login"-Seite umgeleitet werden.
    Und möchte ich "Hans" nicht sehen.
    Und möchte ich "Meier" nicht sehen.
    Und möchte ich "hans.meier@example.com" nicht sehen.

  Szenario: Mitarbeiter ohne Autorisierung anlegen
    Wenn ich die "Neuer Mitarbeiter"-Seite aufrufe.
    Dann sollte ich auf die "Login"-Seite umgeleitet werden.

  Szenario: Mitarbeiter ohne Autorisierung aurufen
    Wenn ich die Seite für diesen Mitarbeiter aufrufe.
    Dann sollte ich auf die "Login"-Seite umgeleitet werden.

  Szenario: Mitarbeiter ohne Autorisierung bearbeiten
    Wenn ich die Seite zum Bearbeiten dieses Mitarbeiters aufrufe.
    Dann sollte ich auf die "Login"-Seite umgeleitet werden.

  Szenario: Mitarbeiter ohne Autorisierung löschen
    Wenn ich die Seite zum Löschen dieses Mitarbeiters aufrufe.
    Dann sollte ich auf die "Login"-Seite umgeleitet werden.
