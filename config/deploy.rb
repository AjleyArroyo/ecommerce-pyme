# config valid for current version and patch releases of Capistrano
lock "~> 3.14.0"

set :application, "ecommerce-pyme"
set :repo_url, "git@gitlab.com:israellias/ecommerce-pyme.git"

set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    1
set :ssh_options, paranoid: false

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
set :format,          :pretty
# set :log_level,     :debug
set :keep_releases, 5

append :linked_files, 'config/database.yml', 'config/master.key', 'config/application.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads', 'storage'

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.6.5'
