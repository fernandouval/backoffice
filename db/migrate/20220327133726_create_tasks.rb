class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :client, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.date :end_date
      t.decimal :fixed_price
      t.decimal :worked_hours

      t.timestamps
    end
  end
end
