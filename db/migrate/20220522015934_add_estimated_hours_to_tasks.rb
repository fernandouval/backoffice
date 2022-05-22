class AddEstimatedHoursToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :estimated_hours, :decimal, scale:2, precision:4
  end
end
