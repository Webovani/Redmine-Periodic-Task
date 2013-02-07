class CreatePeriodicTasks < ActiveRecord::Migration
  def self.up
    create_table :periodic_tasks do |t|
      t.references :project
      t.references :tracker
      t.references :fixed_version
      t.references :assigned_to
      t.references :author
      t.string     :subject
      t.integer    :interval_number
      t.string     :interval_units
      t.date       :next_run_date
    end
  end

  def self.down
    drop_table :periodic_tasks
  end
end
