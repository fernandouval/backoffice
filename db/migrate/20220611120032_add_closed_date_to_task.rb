class AddClosedDateToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :closed_at, :date
  end
end
