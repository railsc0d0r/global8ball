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
  steps %{ Wenn ich "#{firstname}" als "firstname" eingebe. }
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
