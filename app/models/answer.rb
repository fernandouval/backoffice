class Answer < ApplicationRecord
  belongs_to :task
  belongs_to :admin_user

  accepts_nested_attributes_for :task, :allow_destroy => false

  scope :from_this_month, ->() { where("answers.created_at > ? AND answers.created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month) }
end
