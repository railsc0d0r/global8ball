# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'global8ball'
set :repo_url, 'ssh://git@p2501.twilightparadox.com:33333/home/git/git_repos/global8ball.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'
set :deploy_to, '/home/cap/global8ball'

# User for deployment
set :deploy_user, 'cap'

# Default value for :scm is :git
# set :scm, :git
set :git_strategy, Capistrano::Git::SubmoduleStrategy

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'upload')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 4

# Set path to unicorn.rb
set :unicorn_config_path,  'config/unicorn.rb' 

namespace :deploy do

  before 'deploy', 'rvm1:install:gems'

  desc "Seed db and restart unicorn"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute "bash -l -c 'cd #{release_path}; pwd; bundle exec rake db:seed RAILS_ENV=#{fetch(:rails_env)}'"
          execute "bash -l -c 'cd #{release_path}; pwd; bundle exec rake unicorn:restart RAILS_ENV=#{fetch(:rails_env)}'"
        end
      end
    end
  end

  after 'deploy:finished', 'deploy:restart'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
