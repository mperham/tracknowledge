namespace :app do
	task :setup => [:environment, 'db:migrate', 'db:fixtures:load'] do
	end
end
