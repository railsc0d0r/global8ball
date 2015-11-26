module UnicornCluster
  class << self
    # Starts UnicornCluster
    def start
      return false unless unicorn_installed?
      
      deployment = rails_env == "production" ? "deployment" : "development"
      `cd #{rails_root} && bundle exec unicorn -c config/unicorn.rb -E #{deployment} -D` unless is_running?
      sleep 1
      
      is_running? 
    end
    
    # Stops UnicornCluster
    def stop
      `kill -s QUIT #{pid}`
      sleep 1
      
      `kill -s TERM #{pid}` if is_running?
      sleep 1
      
      !is_running?
    end
    
    # Stops and then restarts UnicornCluster
    def restart
      stop if is_running?
      start
      
      is_running?
    end
    
    # Returns true if cluster is running
    def is_running?
      result = ""
      result = `ps -p #{pid} -o cmd=`.gsub("\n", "") unless pid.empty?

      result.split.first == "unicorn" ? true : false
    end
    
    private
      # Returns true if unicorn is installed, otherwise false
      def unicorn_installed?
        result = `which unicorn`.gsub("\n", "")
        
        puts "unicorn-binary not found" if result.empty?
        
        result.empty? ? false : true
      end
      
      # Returns PID from file
      def pid
        pid_file_path = rails_root + '/tmp/pids/unicorn.pid'
        `cat #{pid_file_path}`.gsub("\n", "")
      end
      
      # Returns current environment
      def rails_env
        ENV['RAILS_ENV'] || 'development'
      end
      
      # Returns path to rails-root
      def rails_root
        `pwd`.gsub("\n", "")
      end
  end
end

