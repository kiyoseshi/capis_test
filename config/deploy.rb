# config valid only for current version of Capistrano
lock '3.4.0'

# リポジトリの設定
set :scm, :git
set :repo_url, 'https://github.com/kiyoseshi/capis_test.git'
set :deploy_to, "/var/www/capis_test" #上で代入した値を使ってる
set :deploy_via, :remote_cache  #なんで要るか謎
set :rails_env, "production" #なんで要るか謎

#SSHの設定
#ssh_options[:port] = "22"
#ssh_options[:keys] = %w(~/.ec2/amazonkey.pem)
#ssh_options[:forward_agent] = true #なんで要るか謎
set :user, "kiyoseshi"
set :use_sudo, false
#default_run_options[:pty] = true #なんで要るか謎

# デプロイ先のホスト指定
role :web, 'ec2-52-68-213-117.ap-northeast-1.compute.amazonaws.com'
role :app, 'ec2-52-68-213-117.ap-northeast-1.compute.amazonaws.com'
role :db, 'ec2-52-68-213-117.ap-northeast-1.compute.amazonaws.com'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git


# SSHの設定


# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :keep_releases, 3

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

