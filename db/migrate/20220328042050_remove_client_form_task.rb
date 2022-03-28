class RemoveClientFormTask < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tasks, :client, null: false, foreign_key: true
  end
end
