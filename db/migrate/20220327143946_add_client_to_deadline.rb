class AddClientToDeadline < ActiveRecord::Migration[7.0]
  def change
    add_reference :deadlines, :client, null: false, foreign_key: true
  end
end
