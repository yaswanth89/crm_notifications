class Task < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  scope :to_remind, -> {where(remind: true)}
  scope :to_notify, -> {where(notify: true)}
end
