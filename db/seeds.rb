# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Defining languages
puts "Seeding languages\n\r"
languages = []

english = {
  name: "English",
  native_name: "English",
  i18n_code: "en"
}

languages << english

french = {
  name: "French",
  native_name: "Français",
  i18n_code: "fr"
}

languages << french

german = {
  name: "German",
  native_name: "Deutsch",
  i18n_code: "de"
}

languages << german

russian = {
  name: "Russian",
  native_name: "Pусский",
  i18n_code: "ru"
}

languages << russian

spanish = {
  name: "Spanish",
  native_name: "Español",
  i18n_code: "esp"
}

languages << spanish

languages.each do |language|
  old_language = Language.where(name: language[:name], i18n_code: language[:i18n_code]).first

  unless old_language
    puts "Creating language #{language[:name]} ->"
    Language.create!(language)
    puts "Done."
  else
    puts "Language #{language[:name]} already exists. Nothing to do here."
  end
end

# Defining roles
puts "Seeding roles:\n\r"

roles = []

admin = {
  name: "Administrator"
}

roles << admin

employee = {
  name: "Employee"
}

roles << employee

player = {
  name: "Player"
}

roles << player

roles.each do |role|
  old_role = Role.find_by_name(role[:name])

  if old_role.nil?
    puts "Creating role #{role[:name]} ->"
    Role.create!(role)
    puts "Done."
  else
    puts "Role #{role[:name]} already exists. Nothing to do here."
  end
end

# Defining default employees
puts "\n\rSeeding employees:\n\r"
employees = []

stephan = {
  firstname: "Stephan",
  lastname: "Barth",
  username: "stephan",
  password: "letMeIn_2015",
  email: "railsc0d0r@gmail.com",
  role: "Administrator"
}  

employees << stephan

mike = {
  firstname: "Mike",
  lastname: "Neubert",
  username: "mike_neubert",
  password: "global8ball_2015",
  email: "info@3trip.de",
  role: "Administrator"
}

employees << mike

employees.each do |employee|
  firstname = employee.delete(:firstname)
  lastname = employee.delete(:lastname)
  
  username = employee.delete(:username)
  email = employee.delete(:email)
  password = employee.delete(:password)
  role_name = employee.delete(:role)
  
  # First check by firstname, lastname and email, if an employee already exists
  old_employee = Employee.joins(:person).where(people: {firstname: firstname, lastname: lastname, email: email}).first

  # If not, create him 
  unless old_employee
    puts "Creating employee #{firstname} #{lastname} with role #{role_name} ->"
    params = {
      user_attributes: {
        username: username,
        role_name: role_name,
        password: password,
        password_confirmation: password
      },
      person_attributes: {
        firstname: firstname,
        lastname: lastname,
        email: email,
        address_attributes: {
          street: "",
          street2: "",
          zip: "",
          city: "",
          country: ""
        }
      }
    }

    new_employee = Employee.new(params)

    # For transition only:
    # If there exists already an user w/ given email and username,
    # associate him with this employee
    user = User.find_by_email_and_username(email, username)

    if user
      # Set existing user as user for employee
      new_employee.user = user
    end

    new_employee.save
    new_employee.activate!

    puts "Done.\n\r"
  else
    puts "Employee #{firstname} #{lastname} already exists. Nothing to do here."
  end
end
