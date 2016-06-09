# coding: utf-8
Angenommen(/^folgende Rollen:$/) do |table|
  table.hashes.each do |role|
    steps %{ Angenommen die Rolle "#{role[:Name]}".}
  end
end

Angenommen(/^die Rolle "(.*?)"\.$/) do |name|
  @role = Role.exists?(name: name) ? Role.find_by_name(name) : FactoryGirl.create(:role, name: name)
end

Angenommen(/^ein neu registrierter Spieler\.$/) do
  @player = FactoryGirl.build(:player)
  @player.deactivate!
  @player.user.encrypted_password = ""
  @player.user.confirmed_at = nil
  @player.user.unconfirmed_email = @player.user.email
  @player.save!
end

Angenommen(/^ein neu registrierter Mitarbeiter\.$/) do
  @employee = FactoryGirl.build(:employee)
  @employee.deactivate!
  @employee.user.encrypted_password = ""
  @employee.user.confirmed_at = nil
  @employee.user.unconfirmed_email = @employee.user.email
  @employee.save!
end

Angenommen(/^ein Mitarbeiter mit dem Vornamen "(.*?)", dem Nachnamen "(.*?)", der Email "(.*?)" und der Rolle "(.*?)"\.$/) do |firstname, lastname, email, role_name|

  params = {
    user_attributes: {
      role_name: role_name
    },
    person_attributes: {
      firstname: firstname,
      lastname: lastname,
      email: email
    }
  }
  
  @employee = Employee.includes(:person, user: :role).exists?(people: {firstname: firstname, lastname: lastname}, users: {email: email}, roles: {name: role_name}) ? Employee.includes(:person, user: :role).where(people: {firstname: firstname, lastname: lastname}, users: {email: email}, roles: {name: role_name}).first : FactoryGirl.create(:employee, params)

  # We need to do this, because devise somehow overwrites our factory on create :S
  @employee.user.update_attribute(:unconfirmed_email, nil)

  sleep 1
end

Angenommen(/^ein bestätigter Mitarbeiter mit folgenden Eigenschaften:$/) do |table|
  attributes = table.rows_hash
  attributes["role_name"] = "Editor" unless attributes.key?("role_name")

  params = {
    user_attributes: {
      role_name: attributes["role_name"]
    },
    person_attributes: {
      firstname: attributes["firstname"],
      lastname: attributes["lastname"],
      email: attributes["email"]
    }
  }

  params[:user_attributes].merge!({password: attributes["password"], password_confirmation: attributes["password"]}) if attributes.key?("password")

  @employee = Employee.includes(:person, user: :role).exists?(people: {firstname: attributes["firstname"], lastname: attributes["lastname"]}, users: {email: attributes["email"]}, roles: {name: attributes["role_name"]}) ? Employee.includes(:person, user: :role).where(people: {firstname: attributes["firstname"], lastname: attributes["lastname"]}, users: {email: attributes["email"]}, roles: {name: attributes["role_name"]}).first : FactoryGirl.create(:employee, params)

  # We need to do this, because devise somehow overwrites our factory on create :S
  @employee.user.confirm

  sleep 1
end

Angenommen(/^ein bestätigter Spieler mit folgenden Eigenschaften:$/) do |table|
  attributes = table.rows_hash
  attributes["role_name"] = "Player"

  params = {
    user_attributes: {
      role_name: attributes["role_name"]
    },
    person_attributes: {
      firstname: attributes["firstname"],
      lastname: attributes["lastname"],
      email: attributes["email"]
    }
  }

  params[:user_attributes].merge!({password: attributes["password"], password_confirmation: attributes["password"]}) if attributes.key?("password")

  @player = Player.includes(:person, user: :role).exists?(people: {firstname: attributes["firstname"], lastname: attributes["lastname"]}, users: {email: attributes["email"]}, roles: {name: attributes["role_name"]}) ? Player.includes(:person, user: :role).where(people: {firstname: attributes["firstname"], lastname: attributes["lastname"]}, users: {email: attributes["email"]}, roles: {name: attributes["role_name"]}).first : FactoryGirl.create(:player, params)

  # We need to do this, because devise somehow overwrites our factory on create :S
  @player.user.confirm

  sleep 1
end

Angenommen(/^ein Abschnitt auf der Startseite mit Inhalten für "(.*?)"\.$/) do |language|
  steps %{ Und ein Abschnitt auf der "Start"-Seite mit Inhalten für "#{language}". }
end

Angenommen(/^ein Abschnitt auf der "(.*?)"\-Seite mit Inhalten für "(.*?)"\.$/) do |routename, language|
  path = route_for routename
  @section = FactoryGirl.create(:section, path: path)
  @content = FactoryGirl.build(:content, language: language)
  @section.contents << @content

  @content.save
end
