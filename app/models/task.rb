class Task < ApplicationRecord
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
end
