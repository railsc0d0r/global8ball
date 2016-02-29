# Change to match your CPU core count
workers 2

# Min and Max threads per worker
threads 1, 6

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

rails_root  = `pwd`.gsub("\n", "")

# Set up socket location
bind "unix://#{rails_root}/tmp/sockets/puma.sock"

# Logging
stdout_redirect "#{rails_root}/log/puma.stdout.log", "#{rails_root}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{rails_root}/tmp/pids/puma.pid"
state_path "#{rails_root}/tmp/pids/puma.state"
activate_control_app
preload_app!

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{rails_root}/config/database.yml")[rails_env])
end
