# coding: utf-8
Angenommen(/^folgende Rollen:$/) do |table|
  table.hashes.each do |role|
    steps %{ Angenommen die Rolle "#{role[:Name]}".}
  end
end

Angenommen(/^die Rolle "(.*?)"\.$/) do |name|
  @role = Role.exists?(name: name) ? Role.find_by_name(name) : FactoryGirl.create(:role, name: name)
end
