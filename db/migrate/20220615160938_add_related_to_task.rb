class AddRelatedToTask < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :task, foreign_key: true
  end
end
