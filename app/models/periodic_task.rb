class PeriodicTask < ActiveRecord::Base
  unloadable

  belongs_to :project
  belongs_to :tracker
  belongs_to :author, :class_name => 'User'
  belongs_to :assigned_to, :class_name => 'User'
  belongs_to :fixed_version, :class_name => 'Version'

  INTERVAL_UNITS = ['day','week', 'month']

  validates_presence_of :subject, :project_id, :author_id, :tracker_id
  validates_presence_of :fixed_version_id, :if => :budget_active?
  validates_inclusion_of :interval_units, :in => INTERVAL_UNITS
  validates_numericality_of :interval_number, :only_integer => true, :greater_than_or_equal_to => 1

  include Redmine::SafeAttributes
  safe_attributes 'tracker_id', 'assigned_to_id', 'author_id', 'subject', 'interval_number', 'interval_units',
                  'next_run_date'

  def budget_active?
    project.module_enabled?(:budget)
  end
end
