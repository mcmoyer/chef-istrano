namespace :nodejs do
  desc "Install the latest relase of Node.js"
  task :install, roles: :app do
    super_user do
      run "add-apt-repository -y ppa:chris-lea/node.js"
      run "apt-get -y update"
      run "apt-get -y install nodejs"
    end
  end
  after "deploy:install", "nodejs:install"
end
