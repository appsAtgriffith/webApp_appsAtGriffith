set :application, 'webApp_appsAtgriffith'
set :repo_url, 'git@github.com:appsAtgriffith/webApp_appsAtGriffith.git'
set :branch, 'master'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/aagriff/apps/webApp_appsAtgriffith'
set :scm, :git


set :user, "aagriff"
set :group, "deploy-group"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :keep_releases, 5
set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/mongoid.yml config/initializers/devise.rb}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
 set :keep_releases, 5

set :filter, :hosts => %w{162.248.164.142}

namespace :deploy do


  desc "Update the sharedStuff"
  task :upload_yml_files do
    on roles(:all) do |host|
      upload! 'config/mongoid.yml',  "#{shared_path}/config/mongoid.yml"
      upload! 'config/initializers/devise.rb', "#{shared_path}/config/initializers/devise.rb"
    end
  end

  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end

  #before :started, 'deploy:upload_yml_files'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
