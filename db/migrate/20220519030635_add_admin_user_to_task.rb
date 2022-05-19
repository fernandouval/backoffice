class AddAdminUserToTask < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :admin_user, foreign_key: true
  end
end
