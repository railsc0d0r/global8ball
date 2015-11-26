require_relative '../unicorn_cluster'

namespace :unicorn do
  desc "Starts unicorn-cluster"
  task start: :environment do
    UnicornCluster.start
  end

  desc "Stops unicorn-cluster"
  task stop: :environment do
    UnicornCluster.stop
  end
  
  desc "Restarts unicorn-cluster"
  task restart: :environment do
    UnicornCluster.restart
  end

  desc "Status of unicorn-cluster"
  task status: :environment do
    puts UnicornCluster.is_running? ? "Unicorn is running." : "Unicorn is not running."
  end
end

