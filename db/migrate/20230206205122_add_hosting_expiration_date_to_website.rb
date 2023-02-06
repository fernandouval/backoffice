class AddHostingExpirationDateToWebsite < ActiveRecord::Migration[7.0]
  def change
    add_column :websites, :hosting_expiration_date, :date
  end
end
