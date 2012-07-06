namespace :nginx do
  desc "Install latest stable release of nginx"
  task :install, roles: :web do
    super_user do
      run "add-apt-repository -y ppa:nginx/stable"
      run "apt-get -y update"
      run "apt-get -y install nginx"
    end
  end
  after "deploy:install", "nginx:install"

  desc "Setup nginx configuration for this app"
  task :setup, roles: :web do
    super_user do
      template "nginx_unicorn.erb", "/tmp/nginx_conf"
      run "mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{application}"
      run "rm -f /etc/nginx/sites-enabled/default"
    end
  end
  after "deploy:setup", "nginx:setup"


end
