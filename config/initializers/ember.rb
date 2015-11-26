EmberCli.configure do |c|
  c.app :frontend, path: Rails.root.join('frontend').to_s
  c.build_timeout = 25 # in seconds
end
