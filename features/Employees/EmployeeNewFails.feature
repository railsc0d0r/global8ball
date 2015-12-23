# language: de
@javascript
Funktionalität: Mitarbeiter anlegen mit Validierungen
  Als Administrator möchte ich
  Mitarbeiter anlegen können
  um Mitarbeitern das Arbeiten zu ermöglichen.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Employee      |
    Und die App ist im Browser geladen.
    Und eine Anmeldung als Administrator.

  Szenario: Einen Mitarbeiter anlegen schlägt fehl
    Wenn ich aus dem Admin-Menü "Employees" auswähle.
    Und ich den "Add"-Link klicke.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Creating employee failed:" sehen.
    Und möchte ich "email can't be blank" sehen.
    Und möchte ich "password can't be blank" sehen.
    Und möchte ich "role can't be blank" sehen.
    Und möchte ich "firstname can't be blank" sehen.
    Und möchte ich "lastname can't be blank" sehen.
