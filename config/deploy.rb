require "bundler/capistrano"

set :application, "ears"

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:the-experimenters/ears.git"  # Your clone URL
set :scm, "git"

set :user, ENV["EARS_SERVER_USER"]  # The server's user for deploys
#set :use_sudo, false # avoid using the root user
ssh_options[:port] = 22
ssh_options[:username] = ENV["EARS_SERVER_USER"]
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
ssh_options[:paranoid] = false

set :branch, "master"
set :scm_verbose, true
set :deploy_via, :remote_cache

set :deploy_to, "/var/www/#{application}"
server ENV["EARS_SERVER_IP"], :web, :app, :db, :primary => true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

