set :application, "promo"
set :repository,  "git://github.com/fred/promo.git"
set :branch, "master"
set :domain, "globalpeacenow.com"
set :scm, :git
set :deploy_via, :remote_cache
set :rails_env, "production"
set :user, "diaspora"
set :use_sudo,  false
set :deploy_to, "/home/diaspora/#{application}"
set :mongrel_port, "3006"

role :web, domain
role :app, domain
role :db,  domain, :primary => true
role :scm, domain

ssh_options[:forward_agent] = true
default_run_options[:pty] = true
ssh_options[:paranoid] = false


# RVM 
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ruby-1.9.2-p290@promo' # Or whatever env you want it to run in.
set :rvm_type, :user

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :thin do 
  desc "Stop this app's Thin Server" 
  task :stop, :roles => :app do 
    run "thin -C #{shared_path}/config/thin.yml stop"
  end
  desc "Start this app's Thin Server" 
  task :start, :roles => :app do 
    run "thin -C #{shared_path}/config/thin.yml start"
  end
  desc "Restart this app's Thin Server" 
  task :restart, :roles => :app do 
    find_and_execute_task("thin:stop")
    find_and_execute_task("thin:start")
  end
end

namespace :deploy do 
  %w(start stop restart).each do |action| 
    desc "#{action} our server"
    task action.to_sym do 
      find_and_execute_task("thin:#{action}")
    end
  end
end

# using full path on unicorn_binary will not allow to use RVM
# set :unicorn_binary, "unicorn_rails"
# set :unicorn_config, "#{current_path}/config/unicorn.rb"
# set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"
# set :unicorn_sock, "#{shared_path}/pids/unicorn.sock"
# 
# namespace :deploy do
#   task :start, :roles => :app, :except => { :no_release => true } do 
#     run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
#   end
#   task :stop, :roles => :app, :except => { :no_release => true } do 
#     run "if [ -f #{unicorn_pid} ]; then #{try_sudo} kill `cat #{unicorn_pid}`; fi"
#   end
#   task :graceful_stop, :roles => :app, :except => { :no_release => true } do
#     run "if [ -f #{unicorn_pid} ]; then #{try_sudo} kill -s QUIT `cat #{unicorn_pid}`; fi"
#   end
#   task :reload, :roles => :app, :except => { :no_release => true } do
#     run "if [ -f #{unicorn_pid} ]; then #{try_sudo} kill -s USR2 `cat #{unicorn_pid}`; fi"
#   end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     stop
#     start
#   end
# end

namespace(:customs) do
  task :config, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end
  task :symlink, :roles => :app do
    run "if [ -d #{current_path}/public/system ]; then rm -rf #{current_path}/public/system; fi"
    run "mkdir -p #{current_path}/tmp/cache"
    run "mkdir -p #{current_path}/tmp/sessions"
    run "ln -nfs  #{shared_path}/system #{release_path}/public/system"
    run "echo \"rvm use ruby-1.9.2-p290@promo\" > #{current_path}/.rvmrc"
    run "cd #{current_path} && bundle install"
    run "cd #{current_path} && bundle exec rake db:migrate RAILS_ENV=production"
  end
end

after "deploy:symlink", "customs:config"
after "deploy:symlink", "customs:symlink"
after "deploy", "deploy:cleanup"
