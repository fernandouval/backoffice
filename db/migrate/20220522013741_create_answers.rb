class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.references :task, null: false, foreign_key: true
      t.text :comment
      t.boolean :send_email
      t.boolean :visible

      t.timestamps
    end
  end
end
