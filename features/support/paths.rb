# Method to map keywords to different paths of our app
def path_for pathname
  case pathname
  when 'Startseite'
    "/"
  when 'Login'
    "/login"
  else
    raise "No path defined for page named '#{pagename}'."
  end
end
