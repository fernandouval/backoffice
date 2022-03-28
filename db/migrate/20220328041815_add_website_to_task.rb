class AddWebsiteToTask < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :website, null: false, foreign_key: true
  end
end
