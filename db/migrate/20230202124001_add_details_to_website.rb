class AddDetailsToWebsite < ActiveRecord::Migration[7.0]
  def change
    add_column :websites, :is_hosted, :boolean
    add_column :websites, :is_managed, :boolean
  end
end
