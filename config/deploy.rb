set :application, "tracknowledge"
set :repository,  "git://github.com/mperham/tracknowledge.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

default_run_options[:pty] = true
set :scm, :git
set :user, 'mike'

role :app, "www.tracknowledge.org"
role :web, "www.tracknowledge.org"
role :db,  "www.tracknowledge.org", :primary => true
