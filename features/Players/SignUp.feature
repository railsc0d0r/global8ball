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
    Und ich "SecreT_123456789" als Passwort eingebe.
    Und ich "SecreT_123456789" als Passwortbestätigung eingebe.
    Und ich "Meyer" als Nachname eingebe.
    Und ich "Hans" als Vorname eingebe.
    Und ich "hans_meyer@example.com" als Email eingebe.
    Und ich "Musterstrasse 3" als Strasse eingebe.
    Und ich "Auf dem Hinterhof" als Strassenzusatz eingebe.
    Und ich "00815" als Postleitzahl eingebe.
    Und ich "Musterstadt" als Stadt eingebe.
    Und ich "Germany" als Land auswähle.
    Und ich "" als Kreditkartennummer eingebe.
    Und ich "" als Geburtsdatum eingebe.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Successfully signed up. Please check your emails" sehen.
    Und möchte ich eine Email mit dem Betreff "Please confirm your email address" bekommen haben.

  @wip
  Szenario: Bestätigen eines Spielers durch email
    Angenommen ein neu registrierter Spieler.
    Wenn dieser Spieler den Bestätigungslink in seiner Email klickt.
    Dann wird die "Registrierungsbestätigung"-Seite aufgerufen.
    Und ich möchte "Email successfully confirmed." sehen.
    Und sollte dieser Spieler bestätigt sein.
    Und sollte dieser Spieler aktiviert sein.
