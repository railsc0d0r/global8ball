# coding: utf-8
Wenn(/^ich den ersten Mitarbeiter zum Bearbeiten auswähle\.$/) do
  steps %{ Wenn ich den "Edit"-Link klicke. }
end

Wenn(/^ich den ersten Mitarbeiter zum Löschen auswähle\.$/) do
  steps %{ Wenn ich den "Delete"-Link klicke. }
end

Dann(/^sollte dieser Mitarbeiter gelöscht sein\.$/) do
  @employee.destroyed?
end

Dann(/^sollte dieser Mitarbeiter( nicht|) bestätigt sein\.$/) do |nicht|
  @employee.reload
  if nicht.size == 0
    expect(@employee.confirmed?).to be_truthy
  else
    expect(@employee.confirmed?).to be_falsy
  end
end

Dann(/^sollte dieser Mitarbeiter( nicht|) aktiviert sein\.$/) do |nicht|
  @employee.reload
  if nicht.size == 0
    expect(@employee.activated?).to be_truthy
  else
    expect(@employee.activated?).to be_falsy
  end
end
