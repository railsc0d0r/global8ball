# coding: utf-8
Wenn(/^ich zur "(.*?)"\-Seite gehe\.$/) do |page|
  visit(path_for(page)) # go to page
end

Wenn(/^ich zur Anmeldeseite gehe\.$/) do
  steps %{ Wenn ich zur "Login"-Seite gehe. }
end
