# coding: utf-8
Wenn(/^ich "(.*?)" als Passwort eingebe\.$/) do |password|
  steps %{ Wenn ich "#{password}" als "password" eingebe. }
end

Wenn(/^ich "(.*?)" als Passwortbestätigung eingebe\.$/) do |password_confirmation|
  steps %{ Wenn ich "#{password_confirmation}" als "password_confirmation" eingebe. }
end

Wenn(/^ich "(.*?)" als Nachname eingebe\.$/) do |lastname|
  steps %{ Wenn ich "#{lastname}" als "lastname" eingebe. }
end

Wenn(/^ich "(.*?)" als Vorname eingebe\.$/) do |firstname|
  steps %{ Wenn ich "#{firstname}" als "firstname" eingebe. }
end

Wenn(/^ich "(.*?)" als Email eingebe\.$/) do |email|
  steps %{ Wenn ich "#{email}" als "email" eingebe. }
end

Wenn(/^ich "(.*?)" als Strasse eingebe\.$/) do |street|
  steps %{ Wenn ich "#{street}" als "street" eingebe. }
end

Wenn(/^ich "(.*?)" als Strassenzusatz eingebe\.$/) do |street2|
  steps %{ Wenn ich "#{street2}" als "street2" eingebe. }
end

Wenn(/^ich "(.*?)" als Postleitzahl eingebe\.$/) do |zip|
  steps %{ Wenn ich "#{zip}" als "zip" eingebe. }
end

Wenn(/^ich "(.*?)" als Stadt eingebe\.$/) do |city|
  steps %{ Wenn ich "#{city}" als "city" eingebe. }
end

Wenn(/^ich "(.*?)" als Rolle auswähle\.$/) do |role|
  steps %{ Wenn ich "#{role}" als "role" auswähle. }
end

Wenn(/^ich "(.*?)" als Land auswähle\.$/) do |country|
  steps %{ Wenn ich "#{country}" als "country" auswähle. }
end

Wenn(/^ich "([^"]*)" als ID\-Typ auswähle\.$/) do |id_type|
  steps %{ Wenn ich "#{id_type}" als "id_type" auswähle. }
end

Wenn(/^ich "([^"]*)" als ID\-Nummer eingebe\.$/) do |id_number|
  steps %{ Wenn ich "#{id_number}" als "id_number" eingebe. }
end

Wenn(/^ich "(.*?)" als Überschrift eingebe\.$/) do |headline|
  steps %{ Wenn ich "#{headline}" als "headline" eingebe. }
end

Wenn(/^ich "(.*?)" als Kreditkartennummer eingebe\.$/) do |card_number|
  steps %{ Wenn ich "#{card_number}" als "card_number" eingebe. }
end

Wenn(/^ich "(.*?)" als Geburtsdatum eingebe\.$/) do |date_of_birth|
  steps %{ Wenn ich "#{date_of_birth}" als "date_of_birth" eingebe. }
end

Wenn(/^ich "(.*?)" in den Editor eingebe\.$/) do |content|
  page.has_css?('.mce-tinymce', visible: true)
  page.execute_script("$(tinymce.editors[0].setContent('#{content}'));")
end
