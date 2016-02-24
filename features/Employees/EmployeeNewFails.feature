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

  Szenario: Einen Mitarbeiter anlegen schlägt fehl
    Angenommen eine Anmeldung als Administrator.
    Wenn ich aus dem Admin-Menü "Employees" auswähle.
    Und ich den "Add"-Link klicke.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Creating employee failed:" sehen.
    Und möchte ich "Email can't be blank" sehen.
    Und möchte ich "role can't be blank" sehen.
    Und möchte ich "Firstname can't be blank" sehen.
    Und möchte ich "Lastname can't be blank" sehen.

  Szenario: Bestätigen eines Mitarbeiters - Setzen des Passworts schlägt fehl
    Angenommen ein neu registrierter Mitarbeiter.
    Wenn dieser Mitarbeiter den Bestätigungslink in seiner Email klickt.
    Und ich mich auf der Registrierungsbestätigungsseite für diesen Mitarbeiter befinde.
    Und ich "" als Passwort eingebe.
    Und ich "" als Passwortbestätigung eingebe.
    Und ich den "Confirm"-Button klicke.
    Dann möchte ich "Successfully confirmed your account." nicht sehen.
    Und möchte ich "Password can't be blank" sehen.
    Und sollte dieser Mitarbeiter nicht bestätigt sein.
    Und sollte dieser Mitarbeiter nicht aktiviert sein.
