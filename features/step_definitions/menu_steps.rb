# coding: utf-8
Wenn(/^ich aus dem Admin\-Menü "(.*?)" auswähle\.$/) do |link_name|
  steps %{ 
           Dann screenshot.
           Wenn ich den "Administration"-Link klicke.  
           Wenn ich den "#{link_name}"-Link klicke.  
         }
end

