class Answer < ApplicationRecord
  belongs_to :task
  accepts_nested_attributes_for :task, :allow_destroy => false
end
