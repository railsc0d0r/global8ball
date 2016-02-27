module RedisInstance
  class << self
    # Starts RedisInstance
    def start
      return false unless redis_installed?

      sleep 1

      is_running?
    end

    # Stops RedisInstance
    def stop
      `kill -s QUIT #{pid}`
      sleep 1

      `kill -s TERM #{pid}` if is_running?
      sleep 1

      !is_running?
    end

    # Stops and then restarts RedisInstance
    def restart
      stop if is_running?
      start

      is_running?
    end

    # Returns true if instance is running
    def is_running?
      result = ""
      result = `ps -p #{pid} -o cmd=`.gsub("\n", "") unless pid.empty?

      result.split.first == "redis-server" ? true : false
    end

    private
      # Returns true if redis is installed, otherwise false
      def redis_installed?
        result = `which redis-server`.gsub("\n", "")

        puts "redis-server-binary not found" if result.empty?

        result.empty? ? false : true
      end

      # Returns PID from file
      def pid
        pid_file_path = rails_root + "/tmp/pids/redis_#{rails_env}#{test_env}.pid"
        `cat #{pid_file_path}`.gsub("\n", "")
      end

      # Returns current environment
      def rails_env
        ENV['RAILS_ENV'] || 'development'
      end

      # Returns current test-environment
      def test_env
        ENV['TEST_ENV_NUMBER']
      end

      # Returns path to rails-root
      def rails_root
        `pwd`.gsub("\n", "")
      end
  end
end
