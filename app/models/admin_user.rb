class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :tasks
  has_many :answers

  enum role: [
   'super_admin',
   'admin',
   'developer',
   'designer',
  ]

  def is_admin?
   ['admin', 'super_admin'].include?(self.role)
  end

  def is_superadmin?
   ['super_admin'].include?(self.role)
  end
end
