# encoding: utf-8
# Method to map keywords to different paths of our app
def path_for pathname, args = {}
  case pathname
  when 'Start'
    "/"
  when 'Login'
    "/login"
  when 'Mitarbeiterübersicht'
    "/employees"
  when 'Neuer Mitarbeiter'
    "/employees/new"
  when 'FAQ'
    "/faq"
  when 'About Us'
    "/about_us"
  when 'The Game'
    "/the_game"
  when 'Terms of Use'
    "/terms_of_use"
  when 'Rules'
    "/rules"
  when 'Privacy Policy'
    "/privacy"
  when 'Spielerbestätigung'
    "/confirmation"
  when 'Abschnitt bearbeiten'
    raise "no id given for section to edit" unless args[:id]
    "/sections/#{args[:id]}/edit"
  else
    raise "No path defined for page named '#{pathname}'."
  end
end
