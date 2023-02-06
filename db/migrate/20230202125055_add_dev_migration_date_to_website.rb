class AddDevMigrationDateToWebsite < ActiveRecord::Migration[7.0]
  def change
    add_column :websites, :last_dev_migration, :date
  end
end
