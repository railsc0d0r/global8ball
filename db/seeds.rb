# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

# Defining default users
puts "Seeding users:\n\r"

users = []

stephan = {
  username: 'stephan',
  email: 'railsc0d0r@gmail.com',
  password: 'letMeIn_2015',
  role: "Administrator"
}

users << stephan

users.each do |user|

  user[:password_confirmation] = user[:password]

  user[:activated] = true
  role = Role.find_by_name(user.delete(:role))
  
  old_user = User.find_by(username: user[:username], email: user[:email])

  if old_user.nil?
    puts "Creating user #{user[:username]} ->"
    new_user = User.create!(user)
    
    puts "Done."
  else
    puts "User #{user[:username]} already exists. Nothing to do here."
    new_user = old_user
  end

  new_user.role = role
  new_user.save!
end
