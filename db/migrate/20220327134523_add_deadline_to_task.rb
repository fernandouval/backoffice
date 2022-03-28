class AddDeadlineToTask < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :deadline, foreign_key: true
  end
end
