# language: de
@javascript
Funktionalität: Mitarbeiter administrieren
  Als Administrator möchte ich
  Mitarbeiter anlegen, bearbeiten, löschen und anschauen können
  um Mitarbeitern das Arbeiten zu ermöglichen.

  Grundlage:
    Angenommen die App ist im Browser geladen.
    Und folgende Rollen:
      | Name          |
      | Administrator |
      | Employee      |
    Und eine Anmeldung als Administrator.

  Szenario: Einen Mitarbeiter anlegen
    Wenn ich aus dem Admin-Menü "Mitarbeiter" auswähle.
    Und ich den "Neu"-Button klicke.
    Und ich "Employee" als Rolle auswähle.
    Und ich "secret1234" als Passwort eingebe.
    Und ich "secret1234" als Passwortbestätigung eingebe.
    Und ich "Meyer" als Nachname eingebe.
    Und ich "Hans" als Vorname eingebe.
    Und ich "hans_meyer@example.com" als Email eingebe.
    Und ich "Musterstrasse 3" als Strasse eingebe.
    Und ich "Auf dem Hinterhof" als Strassenzusatz eingebe.
    Und ich "00815" als Postleitzahl eingebe.
    Und ich "Musterstadt" als Stadt eingebe.
    Und ich "Deutschland" als Land auswähle.
    Und ich den "Speichern"-Button klicke.
    Dann möchte ich "Meyer" sehen.
    Und möchte ich "Hans" sehen.
    Und möchte ich "Employee" sehen.
    Und möchte ich "hans_meyer@example.com" sehen.
    Und möchte ich "Musterstrasse 3" sehen.
    Und möchte ich "Auf dem Hinterhof" sehen.
    Und möchte ich "00815" sehen.
    Und möchte ich "Musterstadt" sehen.
    Und möchte ich "Deutschland" sehen.
    Und möchte ich "Mitarbeiter 'Meyer, Hans' erfolgreich gespeichert." sehen.

  Szenario: Einen Administrator anlegen
    Wenn ich aus dem Admin-Menü "Mitarbeiter" auswähle.
    Und ich den "Neu"-Button klicke.
    Und ich "Administrator" als Rolle auswähle.
    Und ich "secret1234" als Passwort eingebe.
    Und ich "secret1234" als Passwortbestätigung eingebe.
    Und ich "Meyer" als Nachname eingebe.
    Und ich "Hans" als Vorname eingebe.
    Und ich "hans_meyer@example.com" als Email eingebe.
    Und ich "Musterstrasse 3" als Strasse eingebe.
    Und ich "Auf dem Hinterhof" als Strassenzusatz eingebe.
    Und ich "00815" als Postleitzahl eingebe.
    Und ich "Musterstadt" als Stadt eingebe.
    Und ich "Deutschland" als Land auswähle.
    Und ich den "Speichern"-Button klicke.
    Dann möchte ich "Meyer" sehen.
    Und möchte ich "Hans" sehen.
    Und möchte ich "Administrator" sehen.
    Und möchte ich "hans_meyer@example.com" sehen.
    Und möchte ich "Musterstrasse 3" sehen.
    Und möchte ich "Auf dem Hinterhof" sehen.
    Und möchte ich "00815" sehen.
    Und möchte ich "Musterstadt" sehen.
    Und möchte ich "Deutschland" sehen.
    Und möchte ich "Mitarbeiter 'Meyer, Hans' erfolgreich gespeichert." sehen.
