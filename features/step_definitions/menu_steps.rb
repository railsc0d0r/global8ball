# coding: utf-8
Wenn(/^ich aus dem Admin\-Menü "(.*?)" auswähle\.$/) do |link_name|
  steps %{ 
           Wenn ich den "Administration"-Link klicke.  
           Wenn ich den "#{link_name}"-Link klicke.  
         }
end

Wenn(/^ich die Sprachauswahl öffne\.$/) do
  steps %{ Wenn ich den "toggle_language_selection"-Link klicke. }
end

Wenn(/^ich "(.*?)" als Sprache aus dem Dropdown auswähle\.$/) do |language|
  language_dropdown = page.find_by_id "language_selection"

  within language_dropdown do
    if Capybara.current_driver == :poltergeist
      find(:link, language).trigger('click')
    else
      click_link(language)
    end
  end
end
