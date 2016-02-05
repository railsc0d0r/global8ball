# coding: utf-8
Dann(/^sollte dieser Spieler bestätigt sein\.$/) do
  expect(@player.confirmed).to be_truthy
end

Dann(/^sollte dieser Spieler aktiviert sein\.$/) do
  expect(@player.activated).to be_truthy
end
