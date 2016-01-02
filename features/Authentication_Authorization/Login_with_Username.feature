# language: de
@javascript
Funktionalität: Benutzer mit Benutzernamen und Passwort anmelden
  Als Benutzer möchte ich
  mich an der Applikation mit email oder Benutzernamen anmelden können,
  um die Applikation nutzen zu können.

  Grundlage:
    Angenommen die App ist im Browser geladen.

  Szenario: Einen Benutzer mit Benutzernamen anmelden
    Angenommen ein Benutzer mit dem Benutzernamen "MyUser" und dem Passwort "secret987654321".
    Und ich den "LOGIN"-Link klicke.
    Und ich den Benutzernamen "MyUser" und das Passwort "secret987654321" eingebe.
    Und ich den "Submit"-Button klicke.
    Dann möchte ich "Successfully authenticated." sehen.
    Und ich warte 2 Sekunden.
