# language: de
@javascript
Funktionalität: Benutzer mit email und Passwort anmelden
  Als Benutzer möchte ich
  mich an der Applikation mit meiner email und einem Passwort anmelden können,
  um die Applikation nutzen zu können.

  Grundlage:
    Angenommen die App ist im Browser geladen.

  Szenario: Einen Benutzer mit email anmelden
    Angenommen ein Benutzer mit der email "my_user@example.com" und dem Passwort "secret987654321".
    Und ich den "LOGIN"-Link klicke.
    Und ich die email "my_user@example.com" und das Passwort "secret987654321" eingebe.
    Und ich den "Submit"-Button klicke.
    Dann möchte ich "Successfully authenticated." sehen.
    Und ich warte 2 Sekunden.
