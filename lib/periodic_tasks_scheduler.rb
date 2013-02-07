class PeriodicTasksScheduler
  def self.schedule_tasks!
    puts "PeriodicTasksScheduler - #{Date.today}"
    PeriodicTask.find(:all, :conditions => ["next_run_date <= ? OR next_run_date IS NULL", Date.today]).each do |task|
      begin
        puts "Assigning #{task.subject}"

        task.next_run_date ||= Date.today
        task.next_run_date += task.interval_number.send(task.interval_units.downcase)

        issue = Issue.new
        %w(project tracker fixed_version assigned_to author subject).each do |m|
          issue.send("#{m}=", task.send(m))
        end
        issue.due_date = task.next_run_date - 1.day
        issue.save

        task.save
      rescue => e
        puts "Failed to assign #{task.subject}: #{e.message}"
      end
    end
    puts ""
  end
end
