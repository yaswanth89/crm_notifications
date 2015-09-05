class User < ActiveRecord::Base
  has_many :tasks
  has_many :holidays
  validates :name, presence: true
  validates :email, presence: true
  has_secure_password

  module RoasterConstant
    DAYS_ARRAY = %w{ sunday monday tuesday wednesday thursday friday saturday }
  end

end
