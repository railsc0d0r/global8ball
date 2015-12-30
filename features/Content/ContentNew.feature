# language: de
@javascript
Funktionalität: Neuen Content in die Seite einfügen
  Als Administrator möchte ich
  neue Inhalte in die Seite einfügen können
  um Benutzern Informationen rund um die Plattform bereitzustellen.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Editor        |
    Und die App ist im Browser geladen.
    Und eine Anmeldung als Editor.

  Szenario: Neuen Inhaltsabschnitt auf der Startseite einfügen.
    Wenn ich den "Add"-Link klicke.
    Und ich "Test" als Überschrift eingebe.
    Und ich "Inhalte" als Inhalt eingebe.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Content successfully created." sehen.
    Und möchte ich "Test" sehen.
    Und möchte ich "Inhalte" sehen.
