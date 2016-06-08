# coding: utf-8
Angenommen(/^ein Benutzer mit dem Benutzernamen "(.*?)" und dem Passwort "(.*?)"\.$/) do |username, password|
  @user = FactoryGirl.create(:user, username: username, password: password, password_confirmation: password)

  @user.save!
end

Angenommen(/^ein Benutzer mit der email "(.*?)" und dem Passwort "(.*?)"\.$/) do |email, password|
  @user = FactoryGirl.create(:user, email: email, password: password, password_confirmation: password)

  @user.save!
end

Angenommen(/^ein Administrator mit dem Benutzernamen "(.*?)" und dem Passwort "(.*?)"\.$/) do |username, password|
  steps %{ Angenommen ein Benutzer mit dem Benutzernamen "#{username}" und dem Passwort "secret987654321". }
  role = Role.find_by_name('Administrator')
  @user.role = role
  @user.save
end

Angenommen(/^ein Editor mit dem Benutzernamen "(.*?)" und dem Passwort "(.*?)"\.$/) do |username, password|
  steps %{ Angenommen ein Benutzer mit dem Benutzernamen "#{username}" und dem Passwort "secret987654321". }
  role = Role.find_by_name('Editor')
  @user.role = role
  @user.save
end

Angenommen(/^eine Anmeldung als Benutzer\.$/) do
  username = "MyUser"
  password = "secret987654321"
  
  steps %{
    Angenommen ein Benutzer mit dem Benutzernamen "#{username}" und dem Passwort "#{password}".
    Und ich melde mich mit dem Benutzernamen "#{username}" und dem Passwort "#{password}" an.
  }
end

Angenommen(/^eine Anmeldung als Administrator\.$/) do
  username = "MyAdmin"
  password = "secret987654321"

  steps %{
    Angenommen ein Administrator mit dem Benutzernamen "#{username}" und dem Passwort "#{password}".
    Und ich melde mich mit dem Benutzernamen "#{username}" und dem Passwort "#{password}" an.
  }
end

Angenommen(/^eine Anmeldung als Editor\.$/) do
  username = "MyEditor"
  password = "secret987654321"

  steps %{
    Angenommen ein Editor mit dem Benutzernamen "#{username}" und dem Passwort "#{password}".
    Und ich melde mich mit dem Benutzernamen "#{username}" und dem Passwort "#{password}" an.
  }
end

Angenommen(/^eine Anmeldung als Spieler\.$/) do
  firstname = "Hans"
  lastname = "Meier"
  email = "my_player@example.com"
  password = "secret987654321"

  step "ein bestätigter Spieler mit folgenden Eigenschaften:", table(%{
    | firstname | #{firstname} |
    | lastname  | #{lastname}  |
    | email     | #{email}     |
    | password  | #{password}  |
  })
  step "ich mich mit der Email-Adresse \"#{email}\" und dem Passwort \"#{password}\" anmelde."
end

Angenommen(/^ich melde mich mit dem Benutzernamen "(.*?)" und dem Passwort "(.*?)" an\.$/) do |username, password|
  steps %{
    Wenn ich zur Anmeldeseite gehe.
    Und ich den Benutzernamen "#{username}" und das Passwort "#{password}" eingebe.
    Und ich den "Submit"-Button klicke.
    Und ich warte 1 Sekunde.
  }
end

Angenommen(/^dieser Account ist nicht aktiviert\.$/) do
  @user.update_attribute(:activated, false)
end

Wenn(/^ich mich mit dem Benutzernamen "(.*?)" und dem Passwort "(.*?)" anmelde\.$/) do |username, password|
  steps %{ Angenommen ich melde mich mit dem Benutzernamen "#{username}" und dem Passwort "#{password}" an. }
end

Wenn(/^ich mich mit der Email\-Adresse "(.*?)" und dem Passwort "(.*?)" anmelde\.$/) do |email, password|
  steps %{ Angenommen ich melde mich mit dem Benutzernamen "#{email}" und dem Passwort "#{password}" an. }
end

Wenn(/^ich den Benutzernamen "(.*?)" und das Passwort "(.*?)" eingebe\.$/) do |username, password|
  page.has_css?('input#login', visible: true)
  fill_in 'login', :with => username

  page.has_css?('input#password', visible: true)
  fill_in 'password', :with => password
end

Wenn(/^ich die email "(.*?)" und das Passwort "(.*?)" eingebe\.$/) do |email, password|
  steps %{ Wenn ich den Benutzernamen "#{email}" und das Passwort "#{password}" eingebe. } 
end
