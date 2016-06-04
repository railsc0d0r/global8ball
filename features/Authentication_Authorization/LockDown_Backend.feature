# language: de
@javascript
Funktionalität: LockDown Zugang zum Backend
  Als Betreiber der Webseite möchte ich,
  um unauthorisierten Zugang zu Inhalten zu verhindern,
  ein Rollen- und Rechtesystem implementieren, das jedem Benutzer nur genau die Aktionen ermöglicht, die ihm nach Kontext und zugewiesener Rolle erlaubt sind.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Employee      |
      | Player        |
    Und ein Abschnitt auf der Startseite mit Inhalten für "en".
    Und die App ist im Browser geladen.

  @wip
  Szenario: Spieler versucht, Inhalte zu ändern
    Angenommen eine Anmeldung als Spieler.
    Wenn ich versuche, diesen Abschnitt zu bearbeiten.
    Dann möchte ich "Permission denied." sehen.
