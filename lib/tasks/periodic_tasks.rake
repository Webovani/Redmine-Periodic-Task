desc <<-END_DESC
Check for and assign periodic tasks

Example:
  rake redmine:check_periodictasks RAILS_ENV="production"
END_DESC

namespace :redmine do
  task :periodic_tasks => :environment do
    PeriodicTasksScheduler.schedule_tasks!
  end
end
