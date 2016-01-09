# coding: utf-8
Angenommen(/^folgende Rollen:$/) do |table|
  table.hashes.each do |role|
    steps %{ Angenommen die Rolle "#{role[:Name]}".}
  end
end

Angenommen(/^die Rolle "(.*?)"\.$/) do |name|
  @role = Role.exists?(name: name) ? Role.find_by_name(name) : FactoryGirl.create(:role, name: name)
end

Angenommen(/^ein Mitarbeiter mit dem Vornamen "(.*?)", dem Nachnamen "(.*?)", der Email "(.*?)" und der Rolle "(.*?)"\.$/) do |firstname, lastname, email, role_name|

  params = {
    user_attributes: {
      email: email,
      role_name: role_name
    },
    person_attributes: {
      firstname: firstname,
      lastname: lastname,
      email: email
    }
  }
  
  @employee = Employee.includes(:person, user: :role).exists?(people: {firstname: firstname, lastname: lastname}, users: {email: email}, roles: {name: role_name}) ? Employee.includes(:person, user: :role).where(people: {firstname: firstname, lastname: lastname}, users: {email: email}, roles: {name: role_name}).first : FactoryGirl.create(:employee, params)
  sleep 1
end

Angenommen(/^ein Abschnitt auf der Startseite mit Inhalten für "(.*?)"\.$/) do |language|
  @section = FactoryGirl.create(:section, path: 'index')
  @content = FactoryGirl.build(:content, language: language)
  @section.contents << @content

  @content.save
end
