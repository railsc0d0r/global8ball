# language: de
@javascript @selenium
Funktionalität: Benutzer anmelden
  Als Benutzer möchte ich
  mich an der Applikation mit email oder Benutzernamen anmelden können,
  um die Applikation nutzen zu können.

  Grundlage:
    Angenommen die App ist im Browser geladen.

  Szenario: Einen Benutzer mit Benutzernamen anmelden
    Angenommen ein Benutzer mit dem Benutzernamen "MyUser" und dem Passwort "secret987654321".
    Und ich den "LOGIN"-Link klicke.
    Und ich den Benutzernamen "MyUser" und das Passwort "secret987654321" eingebe.
    Und ich den "Login"-Button klicke.
    Dann möchte ich "Successfully authenticated." sehen.

  Szenario: Einen Benutzer mit email anmelden
    Angenommen ein Benutzer mit der email "my_user@example.com" und dem Passwort "secret987654321".
    Und ich den "LOGIN"-Link klicke.
    Und ich die email "my_user@example.com" und das Passwort "secret987654321" eingebe.
    Und ich den "Login"-Button klicke.
    Dann möchte ich "Successfully authenticated." sehen.

  Szenario: Einen Benutzer abmelden
    Angenommen eine Anmeldung als Benutzer.
    Wenn ich den "LOGOUT"-Link klicke.
    Dann möchte ich "Logging out." sehen.
