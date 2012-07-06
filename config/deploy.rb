require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/make_user"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"

server "xxx.xxx.xxx.xxx", :web, :app, :db, primary: true

set :sudo_user, "root"
set :user, "deployer"
set :deploy_user, user
set :deploy_user_pass, "password"

set :application, "blog"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :use_sudo, false

set :scm, "git"
set :repository, "file in repo here"
set :branch, "master"

default_run_options[:pty] = true


