# language: de
@javascript
Funktionalität: Mitarbeiter bearbeiten
  Als Administrator möchte ich
  Mitarbeiter löschen können
  um Mitarbeitern das Arbeiten zu ermöglichen.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Employee      |
    Und die App ist im Browser geladen.
    Und eine Anmeldung als Administrator.

  @wip
  Szenario: Einen Mitarbeiter löschen
    Angenommen ein Mitarbeiter mit dem Vornamen "Hans", dem Nachnamen "Meier", der Email "hans.meier@example.com" und der Rolle "Administrator".
    Wenn ich aus dem Admin-Menü "Employees" auswähle.
    Und ich den ersten Mitarbeiter zum Löschen auswähle.
    Dann möchte ich "Employee 'Meier, Hans' successfully deleted." sehen.
    Und sollte dieser Mitarbeiter gelöscht sein.
