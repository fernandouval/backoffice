class AddClientToWebsite < ActiveRecord::Migration[7.0]
  def change
    add_reference :websites, :client, null: false, foreign_key: true
  end
end
