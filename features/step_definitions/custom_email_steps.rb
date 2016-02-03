# coding: utf-8
Dann(/^möchte ich eine Email mit dem Betreff "(.*?)" bekommen haben\.$/) do |subject|
  steps %{ Then "#{@player.email}" should receive an email with subject "#{subject}" }
end
