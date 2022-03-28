class AddDataToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :status, :integer
    add_column :tasks, :priority, :integer
  end
end
