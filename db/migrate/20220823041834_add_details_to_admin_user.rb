class AddDetailsToAdminUser < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :name, :string
    add_column :admin_users, :phone, :string
    add_column :admin_users, :personal_email, :string
  end
end
