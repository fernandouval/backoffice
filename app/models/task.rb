class Task < ApplicationRecord

  enum status: [
    'open',
    'assigned',
    'closed',
    'answered',
    'data needed',
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

end
