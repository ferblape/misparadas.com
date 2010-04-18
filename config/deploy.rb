set :application, "misparadas.com"
set :domain, "misparadas.com"

set :deploy_to, "/home/misparadas/deploy/#{application}"

set :scm, :git
set :repository,  "git://github.com/ferblape/misparadas.com.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, 'misparadas'
set :ssh_options, {:forward_agent => true}
set :use_sudo, false

role :app, "www.#{domain}"
role :web, "www.#{domain}"
role :db,  "www.#{domain}", :primary => true

# Move over the configurations
task :update_links do
  run "cp -f #{shared_path}/config/database.yml #{current_path}/config/"
  # Add the image sym links
  #['planet', 'web_feed'].each do |link|
  #  run "ln -s #{shared_path}/system/images/#{link} #{current_path}/public/images/#{link}"
  #end
end

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "touch #{current_path}/tmp/restart.txt"
  end
end


after 'deploy', :update_links

