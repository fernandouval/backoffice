class AddDataToAnswer < ActiveRecord::Migration[7.0]
  def change
    add_reference :answers, :admin_user, null: false, foreign_key: true
    add_column :answers, :title, :string
  end
end
