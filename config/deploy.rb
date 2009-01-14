set :application, "tracknowledge"
set :repository,  "git://github.com/mperham/tracknowledge.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

default_run_options[:pty] = true
set :scm, :git
set :git_enable_submodules, true
set :user, 'mike'
set :use_sudo, false

role :app, "www.tracknowledge.org"
role :web, "www.tracknowledge.org"
role :db,  "www.tracknowledge.org", :primary => true

namespace :deploy do
	desc "Restart Application"
	task :restart, :roles => :app do
		run "touch #{current_path}/tmp/restart.txt"
	end
end
