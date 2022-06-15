class AddWorkedTimeToAnswer < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :worked_time, :time
  end
end
