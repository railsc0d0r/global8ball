# language: de
@javascript
Funktionalität: Bestehenden Content auf einer Seite löschen
  Als Mitarbeiter möchte ich
  Inhalte in einer Seite löschen können
  um Benutzern aktuelle Informationen rund um die Plattform bereitzustellen.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Editor        |
    Und ein Abschnitt auf der Startseite mit Inhalten für "en".
    Und die App ist im Browser geladen.

  Szenario: Als Editor einen Inhaltsabschnitt auf der Startseite löschen.
    Angenommen eine Anmeldung als Editor.
    Wenn ich mich auf der Startseite befinde.
    Und ich den "Delete"-Link klicke.
    Dann möchte ich "Section on 'index' successfully deleted." sehen.
    Und möchte ich "No Sections yet..." sehen.
