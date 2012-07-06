namespace :deployuser do
  desc "Create the deployment user"
  task :install, roles: :app do
    super_user do
      run "if (id -u #{deploy_user}); then echo 'User already exists'; else useradd -m -d /home/#{deploy_user} -G www-data #{deploy_user}; fi"
      run %Q[echo "#{deploy_user}:#{deploy_user_pass}" | chpasswd]
      run "chsh -s /bin/bash #{deploy_user}"
      system "echo '#{deploy_user_pass}' | ssh-copy-id #{deploy_user}@#{roles[:app].servers.first.host}"
    end
  end
  after "deploy:install", "deployuser:install"
end
