require 'redmine'

Redmine::Plugin.register :redmine_periodic_tasks do
  name 'Redmine Periodic Task plugin'
  author 'Tanguy de Courson, eMan s.r.o.'
  description 'This is a plugin for Redmine that will allow you to schedule a task to be assigned on a schedule.'
  version '0.1'

  project_module :periodic_tasks do
    permission :periodic_tasks, { :periodic_tasks => [:index, :edit] }
  end

  menu :project_menu, :periodic_tasks, { :controller => 'periodic_tasks', :action => 'index' }, :caption => :periodic_tasks, :before => :settings, :param => :project_id
end
