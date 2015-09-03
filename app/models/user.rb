class User < ActiveRecord::Base
  has_many :tasks
  validates :name, presence: true
  validates :email, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
