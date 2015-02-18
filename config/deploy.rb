require "rvm/capistrano"                  # Load RVM's capistrano plugin.
require "bundler/capistrano"
set :rvm_bin_path, "/usr/local/rvm/bin"
set :application, ENV['appname'] if ENV.has_key?('appname')
set :ds_repo_string, ENV['repo'] if ENV.has_key?('repo')
set :rvm_ruby_string, 'ruby-2.1.1@global'        # Or whatever env you want it to run in.

ssh_options[:keys] = %w(/home/mmaiza/.ssh/id_rsa)
set :ssh_options, {:forward_agent => true}
#ssh_options[:verbose] = :debug
set :use_sudo, false

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
# Repos: `subversion`, `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, "git"
set :repository, "ssh://mmaiza@tlemcen:2357/var/git/realestatemails"  # Your clone URL
set :user, "mmaiza"  # The server's user for deploys
scm_pass = fetch(:scm_passphrase, Capistrano::CLI.password_prompt("Scm pass phrase: "))
set :scm_passphrase, scm_pass  # The deploy user's password
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/vhosts/rails/#{application}"

set :keep_releases, 2
set :db_user, 'root'

# Set the host name (if only apphost is past set the rest to apphost
set :ds_apphost, ENV['apphost'] if ENV.has_key?('apphost')
set :ds_dbhost, ENV['dbhost'] if ENV.has_key?('dbhost')
set :ds_webhost, ENV['webhost'] if ENV.has_key?('webhost')

set :ds_dbhost, "#{ds_apphost}" if ! ENV.has_key?('dbhost')
set :ds_webhost, "#{ds_apphost}" if ! ENV.has_key?('webhost')

##
## CREATING DATABASE.YML
##

def surun(command)
  password = fetch(:root_password, Capistrano::CLI.password_prompt("Remote root password: "))
  run("su - -c '#{command}'") do |channel, stream, output|
    channel.send_data("#{password}\n") if output
  end
end

def database_configuration
%Q[
login: &login
  adapter: mysql2
  encoding: utf8
  reconnect: false
  pool: 5
  socket: /var/run/mysqld/mysqld.sock
  username: #{db_user}
  password: #{Capistrano::CLI.ui.ask("Enter MySQL database password: ")}

development:
  database: #{application}_development
  <<: *login

test:
  database: #{application}_test
  <<: *login

production:
  database: #{application}_production
  <<: *login
]
end

desc "Production task"
task :production do
  set :application_mode, 'production'
  set :domain, '152.160.6.101'
  set :rvm_type, :system                        # Important otherwise cap defaults to system wide rvm  
  set :port, 2357
  role :web, "#{ds_webhost}"
  role :app, "#{ds_apphost}"
  role :db, "#{ds_dbhost}", :primary => true
#  after('deploy:create_symlink', 'cache:clear')
  after('deploy:create_symlink', 'database:set_db_config')
end

desc "Staging task"
task :staging do
  set :application_mode, 'development'
  set :rvm_type, :user                        # Important otherwise cap defaults to system wide rvm
  role :web, "#{ds_webhost}"
  role :app, "#{ds_apphost}"
  role :db, "#{ds_dbhost}"
  after('deploy:create_symlink', 'database:set_db_config')  
end

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :passenger do

  desc <<-DESC
      Restarts your application. \
      This works by creating an empty `restart.txt` file in the `tmp` folder
      as requested by Passenger server.
    DESC
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc <<-DESC
      Starts the application servers. \
      Please note that this task is not supported by Passenger server.
    DESC
  task :start, :roles => :app do
    logger.info ":start task not supported by Passenger server"
  end

  desc <<-DESC
      Stops the application servers. \
      Please note that this task is not supported by Passenger server.
    DESC
  task :stop, :roles => :app do
    logger.info ":stop task not supported by Passenger server"
  end

end

namespace :deploy do

  desc <<-DESC
      Restarts your application. \
      Overwrites default :restart task for Passenger server.
    DESC
  task :restart, :roles => :app, :except => { :no_release => true } do
    passenger.restart
  end

  desc <<-DESC
      Starts the application servers. \
      Overwrites default :start task for Passenger server.
    DESC
  task :start, :roles => :app do
    passenger.start
  end

  desc <<-DESC
      Stops the application servers. \
      Overwrites default :start task for Passenger server.
    DESC
  task :stop, :roles => :app do
    passenger.stop
  end
  
  namespace :assets do
    task :precompile, :roles => :app, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end

end

namespace :database do

  task :default do
    create
    load_legacy
    migrate_db
    seed_db
  end

  desc "Set db config"
  task :set_db_config, :roles => :app do
    create_shared
    link_to_shared
  end

  desc "Create database.yml definition" 
  task :create_shared, :roles => :app do
    run "mkdir -p #{shared_path}/config"
    put database_configuration, "#{shared_path}/config/database.yml" 
  end

  desc "Link in the shared dirs" 
  task :link_to_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc <<-DESC
     Creates the original db data objects
     DESC
  task :create, :roles => :app do
    puts "Creating the database"
    run "cd #{current_release} && rake RAILS_ENV='#{application_mode}' db:create"
  end

  desc <<-DESC
     Add original data
     DESC
  task :load_legacy, :roles => :app do
    puts "Loading the data"
    db_pass = fetch(:root_password, Capistrano::CLI.password_prompt("Remote root password: "))
    run("cd #{current_release} && rake RAILS_ENV=#{application_mode} #{application}:legacy:load_db appname=#{application} db_pass=#{db_pass}" )
  end
  
  desc <<-DESC
     run the migrations
  DESC
  task :migrate_db, :roles => :app do
    run "cd #{current_release} && rake RAILS_ENV='#{application_mode}' db:migrate"
  end

  desc <<-DESC
     seed the database
  DESC
  task :seed_db, :roles => :app do
    run "cd #{current_release} && rake RAILS_ENV='#{application_mode}' db:seed"
  end

  desc <<-DESC
     add salt and encrypt password for the users
  DESC
  task :initialize_users, :roles => :app do
    run "cd #{current_release} && rake RAILS_ENV='#{application_mode}' #{application}:legacy:initialize_users --trace"
  end

end
