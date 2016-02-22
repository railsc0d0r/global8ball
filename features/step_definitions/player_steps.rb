# coding: utf-8
Dann(/^sollte dieser Spieler( nicht|) bestätigt sein\.$/) do |nicht|
  @player.reload
  if nicht.size == 0
    expect(@player.confirmed?).to be_truthy
  else
    expect(@player.confirmed?).to be_falsy
  end
end

Dann(/^sollte dieser Spieler( nicht|) aktiviert sein\.$/) do |nicht|
  @player.reload
  if nicht.size == 0
    expect(@player.activated?).to be_truthy
  else
    expect(@player.activated?).to be_falsy
  end
end
