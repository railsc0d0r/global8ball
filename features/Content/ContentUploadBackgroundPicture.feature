# language: de
@javascript @fs
Funktionalität: Background für Content setzen
  Als Mitarbeiter möchte ich
  Bilder als Hintergrund für einzelne Abschnitte setzen
  um Benutzern Informationen in einer angenehm gestalteten Umgebung darzustellen.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Editor        |
    Und eine Datei "test.jpg" im Testfixtures-Verzeichnis.
    Und ein Abschnitt auf der "FAQ"-Seite mit Inhalten für "en".
    Und die App ist im Browser geladen.

  @wip
  Szenario: Hintergrundbild für einen Abschnitt hochladen
    Angenommen eine Anmeldung als Editor.
    Wenn ich zur "FAQ"-Seite gehe.
    Und screenshot.
    Und ich den "Upload"-Link klicke.
    Und ich das Bild "test.jpg" als Hintergrundbild auswähle.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Backgroundimage successfully uploaded." sehen.
    Und möchte ich "test.jpg" als Hintergrundbild auf der Seite sehen.
