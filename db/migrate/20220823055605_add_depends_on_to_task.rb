class AddDependsOnToTask < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :depends_on, foreign_key: {to_table: :tasks}
  end
end
