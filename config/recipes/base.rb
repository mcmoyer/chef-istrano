def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

def super_user(&block)
  old_user = user
  set :user, sudo_user
  close_sessions
  yield
  set :user, old_user
  close_sessions
end
 
def close_sessions
  sessions.values.each { |session| session.close }
  sessions.clear
end

namespace :deploy do
  desc "Install everything onto our server"
  task :install do
    super_user do
      run "apt-get -y update"
      run "apt-get -y install python-software-properties"
      run "apt-get -y install zsh"
    end
  end
end
