# language: de
@javascript
Funktionalität: Mitarbeiter bearbeiten
  Als Administrator möchte ich
  Mitarbeiter bearbeiten können
  um Mitarbeitern das Arbeiten zu ermöglichen.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Employee      |
    Und die App ist im Browser geladen.
    Und eine Anmeldung als Administrator.

  Szenario: Einen Mitarbeiter bearbeiten
    Angenommen ein Mitarbeiter mit dem Vornamen "Hans", dem Nachnamen "Meier", der Email "hans.meier@example.com" und der Rolle "Employee".
    Wenn ich aus dem Admin-Menü "Employees" auswähle.
    Und ich den ersten Mitarbeiter zum Bearbeiten auswähle.
    Und ich "Administrator" als Rolle auswähle.
    Und ich "Peter" als Vorname eingebe.
    Und ich "Müller" als Nachname eingebe.
    Und ich "peter.mueller@example.com" als Email eingebe.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Employee 'Müller, Peter' successfully updated." sehen.
    Und möchte ich "Müller" sehen.
    Und möchte ich "Peter" sehen.
    Und möchte ich "peter.mueller@example.com" sehen.
    Und möchte ich "Administrator" sehen.

  Szenario: Einen Mitarbeiter bearbeiten ohne Änderungen
    Angenommen ein Mitarbeiter mit dem Vornamen "Hans", dem Nachnamen "Meier", der Email "hans.meier@example.com" und der Rolle "Employee".
    Wenn ich aus dem Admin-Menü "Employees" auswähle.
    Und ich den ersten Mitarbeiter zum Bearbeiten auswähle.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Updating employee failed" nicht sehen.
    Und möchte ich "Meier" sehen.
    Und möchte ich "Hans" sehen.
    Und möchte ich "hans.meier@example.com" sehen.
    Und möchte ich "Employee" sehen.

  Szenario: Einen Administrator bearbeiten
    Angenommen ein Mitarbeiter mit dem Vornamen "Hans", dem Nachnamen "Meier", der Email "hans.meier@example.com" und der Rolle "Administrator".
    Wenn ich aus dem Admin-Menü "Employees" auswähle.
    Und ich den ersten Mitarbeiter zum Bearbeiten auswähle.
    Und ich "Employee" als Rolle auswähle.
    Und ich "Peter" als Vorname eingebe.
    Und ich "Müller" als Nachname eingebe.
    Und ich "peter.mueller@example.com" als Email eingebe.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Employee 'Müller, Peter' successfully updated." sehen.
    Und möchte ich "Müller" sehen.
    Und möchte ich "Peter" sehen.
    Und möchte ich "peter.mueller@example.com" sehen.
    Und möchte ich "Employee" sehen.
