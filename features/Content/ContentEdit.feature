# language: de
@javascript
Funktionalität: Bestehenden Content auf einer Seite bearbeiten
  Als Mitarbeiter möchte ich
  Inhalte in einer Seite bearbeiten können
  um Benutzern Informationen rund um die Plattform bereitzustellen.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Editor        |
    Und ein Abschnitt auf der Startseite mit Inhalten für "en".
    Und die App ist im Browser geladen.

  @wip
  Szenario: Als Editor einen Inhaltsabschnitt auf der Startseite bearbeiten.
    Angenommen eine Anmeldung als Editor.
    Wenn ich mich auf der Startseite befinde.
    Und ich den "Edit"-Link klicke.
    Und ich "Test_bearbeitet" als Überschrift eingebe.
    Und ich "Meine bearbeiteten Inhalte" in den Editor eingebe.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Content on 'index' successfully edited." sehen.
    Und möchte ich "Test_bearbeitet" sehen.
    Und möchte ich "Meine bearbeiteten Inhalte" sehen.
