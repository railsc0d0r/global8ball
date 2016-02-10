# coding: utf-8
Wenn(/^ich zur "(.*?)"\-Seite gehe\.$/) do |page|
  visit(path_for(page)) # go to page
end

Wenn(/^ich die "(.*?)"\-Seite aufrufe\.$/) do |page|
  steps %{ Wenn ich zur "#{page}"-Seite gehe. }
end

Wenn(/^ich zur Startseite gehe\.$/) do
  steps %{ Wenn ich zur "Start"-Seite gehe. }
end

Wenn(/^ich die Startseite aufrufe\.$/) do
  steps %{ Wenn ich zur "Start"-Seite gehe. }
end

Wenn(/^ich mich auf der Startseite befinde\.$/) do
  steps %{ Dann sollte ich auf der "Start"-Seite sein. }
end

Wenn(/^ich zur Anmeldeseite gehe\.$/) do
  steps %{ Wenn ich zur "Login"-Seite gehe. }
end

Wenn(/^ich die Seite für diesen Mitarbeiter aufrufe\.$/) do
  path = path_for('Mitarbeiterübersicht') + "/#{@employee.id}"
  visit(path)
end

Wenn(/^ich die Seite zum Bearbeiten dieses Mitarbeiters aufrufe\.$/) do
  path = path_for('Mitarbeiterübersicht') + "/#{@employee.id}/edit"
  visit(path)
end

Wenn(/^ich die Seite zum Löschen dieses Mitarbeiters aufrufe\.$/) do
  path = path_for('Mitarbeiterübersicht') + "/#{@employee.id}/delete"
  visit(path)
end

Wenn(/^dieser Spieler den Bestätigungslink in seiner Email klickt\.$/) do
  path = path_for('Spielerbestätigung') + "/#{@player.user.confirmation_token}"
  visit(path)
end

Dann(/^sollte ich auf die "(.*?)"\-Seite umgeleitet werden\.$/) do |page|
  steps %{ Dann sollte ich auf der "#{page}"-Seite sein. }
end

Dann(/^sollte ich auf der "(.*?)"\-Seite sein\.$/) do |page|
  expected_path = path_for(page)
  expect(expected_path).to eq(current_path)
end

Dann(/^wird die "(.*?)"\-Seite aufgerufen\.$/) do |page|
  steps %{ Dann sollte ich auf der "#{page}"-Seite sein. }
end
