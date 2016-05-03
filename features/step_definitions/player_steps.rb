# coding: utf-8
Wenn(/^ich die Terms of Use akzeptiere\.$/) do
  steps %{ Wenn ich die Checkbox "acceptedTermsOfUse" aktiviere. }
end

Wenn(/^ich bestätige, das ich die Datenschutzpolicy gelesen habe\.$/) do
  steps %{ Wenn ich die Checkbox "readPrivacyPolicy" aktiviere. }
end

Wenn(/^ich bestätige, das ich die Regeln des Games gelesen habe\.$/) do
  steps %{ Wenn ich die Checkbox "readRules" aktiviere. }
end

Wenn(/^ich bestätige, das ich auf mein Vertragswiderrufsrecht verzichte\.$/) do
  steps %{ Wenn ich die Checkbox "waivedRightToRevokeContract" aktiviere. }
end

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
