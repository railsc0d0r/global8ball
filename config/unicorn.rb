rails_env = ENV['RAILS_ENV'] || 'production'
rails_root  = `pwd`.gsub("\n", "")

# Set the working application directory
# working_directory "/path/to/your/app"
working_directory rails_root

# Set path to socket
addr = rails_root + '/tmp/sockets/unicorn.sock'
listen addr, :tcp_nopush => true

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid rails_root + '/tmp/pids/unicorn.pid'

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path rails_root + '/log/unicorn.log'
stdout_path rails_root + '/log/unicorn.log'

# Number of processes
worker_processes 2

# Time-out
timeout 30

# Preload app
preload_app true

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
  
  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.

  old_pid = "#{Rails.root}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end


after_fork do |server, worker|
  ActiveRecord::Base.establish_connection

  worker.user('rails', 'rails') if Process.euid == 0 && rails_env == 'production'
end
