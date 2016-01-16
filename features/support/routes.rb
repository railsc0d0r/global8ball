# encoding: utf-8
# Method to map keywords to different routes of our app
def route_for routename
  case routename
  when 'Start'
    "index"
  when 'Login'
    "login"
  when 'Mitarbeiterübersicht'
    "employees"
  when 'Neuer Mitarbeiter'
    "employees.new"
  when 'FAQ'
    "faq"
  else
    raise "No route defined for route named '#{routename}'."
  end
end
