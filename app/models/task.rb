class Task < ApplicationRecord
  has_paper_trail

  belongs_to :website
  has_one :admin_user

  enum status: [
    'open',
    'assigned',
    'closed',
    'answered',
    'data_needed',
    'scheduled'
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
      SupportMailer.with(task: task).task_closed.deliver
    end
    if self.status == 'answered'
      SupportMailer.with(task: task).task_closed.deliver
    end
  end
end
