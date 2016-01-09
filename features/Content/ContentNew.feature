# language: de
@javascript
Funktionalität: Neuen Content in die Seite einfügen
  Als Mitarbeiter möchte ich
  neue Inhalte in die Seite einfügen können
  um Benutzern Informationen rund um die Plattform bereitzustellen.

  Grundlage:
    Angenommen folgende Rollen:
      | Name          |
      | Administrator |
      | Editor        |
    Und die App ist im Browser geladen.

  Szenario: Als Editor neuen Inhaltsabschnitt auf der Startseite einfügen.
    Angenommen eine Anmeldung als Editor.
    Wenn ich mich auf der Startseite befinde.
    Und ich den "Add"-Link klicke.
    Und ich "Test" als Überschrift eingebe.
    Und ich "Meine neuen Inhalte" in den Editor eingebe.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Section and content on 'index' successfully created." sehen.
    Und möchte ich "Test" sehen.
    Und möchte ich "Meine neuen Inhalte" sehen.

  Szenario: Als Administrator neuen Inhaltsabschnitt auf der Startseite einfügen.
    Angenommen eine Anmeldung als Administrator.
    Wenn ich mich auf der Startseite befinde.
    Und ich den "Add"-Link klicke.
    Und ich "Test" als Überschrift eingebe.
    Und ich "Meine neuen Inhalte" in den Editor eingebe.
    Und ich den "Save"-Button klicke.
    Dann möchte ich "Section and content on 'index' successfully created." sehen.
    Und möchte ich "Test" sehen.
    Und möchte ich "Meine neuen Inhalte" sehen.
