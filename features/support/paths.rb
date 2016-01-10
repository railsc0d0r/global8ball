# encoding: utf-8
# Method to map keywords to different paths of our app
def path_for pathname
  case pathname
  when 'Start'
    "/"
  when 'Login'
    "/login"
  when 'Mitarbeiterübersicht'
    "/employees"
  when 'Neuer Mitarbeiter'
    "/employees/new"
  else
    raise "No path defined for page named '#{pagename}'."
  end
end
