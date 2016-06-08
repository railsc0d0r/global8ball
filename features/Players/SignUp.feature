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

  @wip
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
    Und ich "Passport" als ID-Typ auswähle.
    Und ich "1234567890" als ID-Nummer eingebe.
    Und ich "09/23/1983" als Geburtsdatum eingebe.
    Und ich die Terms of Use akzeptiere.
    Und ich bestätige, das ich die Datenschutzpolicy gelesen habe.
    Und ich bestätige, das ich die Regeln des Games gelesen habe.
    Und ich bestätige, das ich auf mein Vertragswiderrufsrecht verzichte.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Player 'Meyer, Hans' successfully signed up. Please check your emails." sehen.
    Und möchte ich eine Email mit dem Betreff "Confirmation instructions" bekommen haben.

  Szenario: Einen Spieler registrieren schlägt fehl
    Wenn ich den "SIGNUP"-Link klicke.
    Und ich "" als Nachname eingebe.
    Und ich "" als Vorname eingebe.
    Und ich "" als Email eingebe.
    Und ich "" als Strasse eingebe.
    Und ich "" als Strassenzusatz eingebe.
    Und ich "" als Postleitzahl eingebe.
    Und ich "" als Stadt eingebe.
    Und ich "" als Kreditkartennummer eingebe.
    Und ich "" als ID-Nummer eingebe.
    Und ich "" als Geburtsdatum eingebe.
    Und ich die Terms of Use akzeptiere.
    Und ich bestätige, das ich die Datenschutzpolicy gelesen habe.
    Und ich bestätige, das ich die Regeln des Games gelesen habe.
    Und ich bestätige, das ich auf mein Vertragswiderrufsrecht verzichte.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Signing up player failed:" sehen.
    Und möchte ich "Email can't be blank" sehen.
    Und möchte ich "Firstname can't be blank" sehen.
    Und möchte ich "Lastname can't be blank" sehen.
    Und möchte ich "city can't be blank" sehen.
    Und möchte ich "country can't be blank" sehen.
    Und möchte ich "Type of ID-Document can't be blank" sehen.
    Und möchte ich "Number of ID-Document can't be blank" sehen.
    Und möchte ich "Date of Birth can't be blank" sehen.

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
