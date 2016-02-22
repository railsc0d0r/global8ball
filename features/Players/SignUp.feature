# language: de
@javascript
Funktionalität: Spieler Registrierung
  Als Spieler möchte ich,
  um am Turnier teilnehmen zu können,
  meine Daten registrieren und bestätigen können.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Employee      |
      | Player        |
    Und die App ist im Browser geladen.

  Szenario: Registrieren eines Spielers
    Wenn ich den "SIGNUP"-Link klicke.
    Und ich "Meyer" als Nachname eingebe.
    Und ich "Hans" als Vorname eingebe.
    Und ich "hans_meyer@example.com" als Email eingebe.
    Und ich "Musterstrasse 3" als Strasse eingebe.
    Und ich "Auf dem Hinterhof" als Strassenzusatz eingebe.
    Und ich "00815" als Postleitzahl eingebe.
    Und ich "Musterstadt" als Stadt eingebe.
    Und ich "Germany" als Land auswähle.
    Und ich "344458255604261" als Kreditkartennummer eingebe.
    Und ich "09/23/1983" als Geburtsdatum eingebe.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Player 'Meyer, Hans' successfully signed up. Please check your emails." sehen.
    Und möchte ich eine Email mit dem Betreff "Confirmation instructions" bekommen haben.

  Szenario: Bestätigen eines Spielers durch Token und Setzen des Passworts
    Angenommen ein neu registrierter Spieler.
    Wenn dieser Spieler den Bestätigungslink in seiner Email klickt.
    Und ich mich auf der Registrierungsbestätigungsseite für diesen Spieler befinde.
    Und ich "SecreT_123456789" als Passwort eingebe.
    Und ich "SecreT_123456789" als Passwortbestätigung eingebe.
    Und ich den "Confirm"-Button klicke.
    Dann möchte ich "Successfully confirmed your account." sehen.
    Und sollte dieser Spieler bestätigt sein.
    Und sollte dieser Spieler aktiviert sein.

  Szenario: Bestätigen eines Spielers - Setzen des Passworts schlägt fehl
    Angenommen ein neu registrierter Spieler.
    Wenn dieser Spieler den Bestätigungslink in seiner Email klickt.
    Und ich mich auf der Registrierungsbestätigungsseite für diesen Spieler befinde.
    Und ich "SecreT_123456789" als Passwort eingebe.
    Und ich "SecreT_12345678" als Passwortbestätigung eingebe.
    Und ich den "Confirm"-Button klicke.
    Dann möchte ich "Successfully confirmed your account." nicht sehen.
    Und sollte dieser Spieler nicht bestätigt sein.
    Und sollte dieser Spieler nicht aktiviert sein.
