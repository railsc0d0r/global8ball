# coding: utf-8
Dann(/^sollte dieser Spieler bestätigt sein\.$/) do
  raise "Player is not confirmed" unless @player.confirmed
end

Dann(/^sollte dieser Spieler aktiviert sein\.$/) do
  raise "Player is not activated" unless @player.activated
end
