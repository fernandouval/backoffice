class AddCompletenessToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :completeness, :integer
  end
end
