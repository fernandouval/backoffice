class CreateDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :deadlines do |t|
      t.date :ddate
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
