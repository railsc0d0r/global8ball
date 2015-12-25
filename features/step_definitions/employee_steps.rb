# coding: utf-8
Wenn(/^ich den ersten Mitarbeiter zum Bearbeiten auswähle\.$/) do
  steps %{ Wenn ich den "Edit"-Link klicke. }
end

Wenn(/^ich den ersten Mitarbeiter zum Löschen auswähle\.$/) do
  steps %{ Wenn ich den "Delete"-Link klicke. }
end

Dann(/^sollte dieser Mitarbeiter gelöscht sein\.$/) do
  @employee.destroyed?
end
