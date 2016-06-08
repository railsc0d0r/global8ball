# language: de
@javascript @wip
Funktionalität: Mitarbeiter anlegen
  Als Administrator möchte ich
  Mitarbeiter anlegen können
  um Mitarbeitern das Arbeiten zu ermöglichen.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Employee      |
    Und die App ist im Browser geladen.

  Szenario: Einen Mitarbeiter anlegen
    Angenommen eine Anmeldung als Administrator.
    Wenn ich aus dem Admin-Menü "Employees" auswähle.
    Und ich den "Add"-Link klicke.
    Und ich "Employee" als Rolle auswähle.
    Und ich "Meyer" als Nachname eingebe.
    Und ich "Hans" als Vorname eingebe.
    Und ich "hans_meyer@example.com" als Email eingebe.
    Und ich "Musterstrasse 3" als Strasse eingebe.
    Und ich "Auf dem Hinterhof" als Strassenzusatz eingebe.
    Und ich "00815" als Postleitzahl eingebe.
    Und ich "Musterstadt" als Stadt eingebe.
    Und ich "Germany" als Land auswähle.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Employee 'Meyer, Hans' successfully created." sehen.
    Und möchte ich "Meyer" sehen.
    Und möchte ich "Hans" sehen.
    Und möchte ich "Employee" sehen.
    Und möchte ich "hans_meyer@example.com" sehen.
    Und möchte ich "Musterstrasse 3" sehen.
    Und möchte ich "Auf dem Hinterhof" sehen.
    Und möchte ich "00815" sehen.
    Und möchte ich "Musterstadt" sehen.
    Und möchte ich "Germany" sehen.

  Szenario: Einen Administrator anlegen
    Angenommen eine Anmeldung als Administrator.
    Wenn ich aus dem Admin-Menü "Employee" auswähle.
    Und ich den "Add"-Button klicke.
    Und ich "Administrator" als Rolle auswähle.
    Und ich "Meyer" als Nachname eingebe.
    Und ich "Hans" als Vorname eingebe.
    Und ich "hans_meyer@example.com" als Email eingebe.
    Und ich "Musterstrasse 3" als Strasse eingebe.
    Und ich "Auf dem Hinterhof" als Strassenzusatz eingebe.
    Und ich "00815" als Postleitzahl eingebe.
    Und ich "Musterstadt" als Stadt eingebe.
    Und ich "Germany" als Land auswähle.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Employee 'Meyer, Hans' successfully created." sehen.
    Und möchte ich "Meyer" sehen.
    Und möchte ich "Hans" sehen.
    Und möchte ich "Administrator" sehen.
    Und möchte ich "hans_meyer@example.com" sehen.
    Und möchte ich "Musterstrasse 3" sehen.
    Und möchte ich "Auf dem Hinterhof" sehen.
    Und möchte ich "00815" sehen.
    Und möchte ich "Musterstadt" sehen.
    Und möchte ich "Germany" sehen.

  Szenario: Bestätigen eines Mitarbeiter durch Token und Setzen des Passworts
    Angenommen ein neu registrierter Mitarbeiter.
    Wenn dieser Mitarbeiter den Bestätigungslink in seiner Email klickt.
    Und ich mich auf der Registrierungsbestätigungsseite für diesen Mitarbeiter befinde.
    Und ich "SecreT_123456789" als Passwort eingebe.
    Und ich "SecreT_123456789" als Passwortbestätigung eingebe.
    Und ich den "Confirm"-Button klicke.
    Dann möchte ich "Successfully confirmed your account." sehen.
    Und sollte dieser Mitarbeiter bestätigt sein.
    Und sollte dieser Mitarbeiter aktiviert sein.
