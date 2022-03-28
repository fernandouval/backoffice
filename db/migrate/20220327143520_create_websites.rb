class CreateWebsites < ActiveRecord::Migration[7.0]
  def change
    create_table :websites do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :admin
      t.string :password_digest

      t.timestamps
    end
  end
end
