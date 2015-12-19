# language: de
@javascript @selenium
Funktionalität: Benutzer anmelden
  Als Betreiber möchte ich
  um die Applikation sichern zu können,
  Anmeldungen an der Applikation mit falschen Credentials unterbinden können.

  Grundlage:
    Angenommen die App ist im Browser geladen.

  Szenario: Einen Benutzer ohne Credentials anmelden
    Angenommen ein Benutzer mit der email "my_user@example.com" und dem Passwort "secret987654321".
    Und ich den "LOGIN"-Link klicke.
    Und ich den "Login"-Button klicke.
    Dann möchte ich "Login failed: You need to sign in or sign up before continuing." sehen.

  Szenario: Einen Benutzer mit falschem Passwort anmelden
    Angenommen ein Benutzer mit der email "my_user@example.com" und dem Passwort "secret987654321".
    Und ich den "LOGIN"-Link klicke.
    Und ich den Benutzernamen "MyUser" und das Passwort "1234567890" eingebe.
    Und ich den "Login"-Button klicke.
    Dann möchte ich "Login failed: Invalid login or password." sehen.

  Szenario: Einen Benutzer mit falschem Benutzer anmelden
    Angenommen ein Benutzer mit der email "my_user@example.com" und dem Passwort "secret987654321".
    Und ich den "LOGIN"-Link klicke.
    Und ich den Benutzernamen "XYZ" und das Passwort "secret987654321" eingebe.
    Und ich den "Login"-Button klicke.
    Dann möchte ich "Login failed: Invalid login or password." sehen.
