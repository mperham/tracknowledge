namespace :app do
	task :setup => [:environment, 'db:fixtures:load'] do
	end
end
