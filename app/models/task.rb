class Task < ApplicationRecord
  has_paper_trail

  belongs_to :website
  belongs_to :admin_user
  has_many :answers
  accepts_nested_attributes_for :answers, :allow_destroy => false

  enum status: [
    'open',
    'assigned',
    'closed',
    'answered',
    'data_needed',
    'scheduled',
    'in_progress'
  ]

  enum priority: [
    'low',
    'middle-low',
    'middle',
    'high',
    'urgent',
    'critical'
  ]
  def is_open
    !self.status.in?( ['closed', 'answered'] )
  end
  def is_closed
    self.status.in?( ['closed', 'answered'] )
  end
  #
  after_create do
    SupportMailer.with(task: self).task_new.deliver
  end
  #
  after_update do
    if self.status == 'closed'
      SupportMailer.with(task: self).task_closed.deliver
    end
    if self.status == 'answered'
      SupportMailer.with(task: self).task_answered.deliver
    end
  end
  def send_assignment
    SupportMailer.with(task: self, to: self.admin_user.email).task_assigned.deliver
  end
end
