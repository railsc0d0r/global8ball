# language: de
@javascript
Funktionalität: Account-Page
  Als Benutzer der Plattform möchte ich,
  um die mich betreffenden Daten einsehen und ggf. bearbeiten zu können,
  eine Seite präsentiert bekommen, auf der ich alle meine Accountdaten und Funktionen dargestellt bekomme.

  Grundlage:
    Angenommen die App ist im Browser geladen.

  @wip
  Szenario: Accountpage für Mitarbeiter
    Angenommen die Rolle "Employee".
    Angenommen ein bestätigter Mitarbeiter mit folgenden Eigenschaften:
      | firstname | Hans                   |
      | lastname  | Meier                  |
      | email     | hans.meier@example.com |
      | password  | secret12345678         |
    Wenn ich mich mit der Email-Adresse "hans.meier@example.com" und dem Passwort "secret12345678" anmelde.
    Und ich den "Account"-Link klicke.
    Dann möchte ich "Hans" sehen.
    Und möchte ich "Meier" sehen.
    Und möchte ich "hans.meier@example.com" sehen.
    Und möchte ich "Employee" sehen.
