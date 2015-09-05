class Task < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  scope :to_remind, -> {where("remind = ? AND at < ? ", true , 10.minutes.from_now)}
  scope :to_notify, -> {where(notify: true)}

  def self.send_pending_notifications
    Task.to_remind.find_each do |task|
      task.notify_user("remind")
    end
    Task.to_notify.find_each do |task|
      task.notify_user("notify")
    end
  end

  def notify_user(type)
  	if not (ActiveUser.find_by(user_id: self.user_id).nil?)
  		case type
		when "remind"
			head = "Upcoming Task"
			theme = "info"
			self.remind = false
			self.save
		when "notify"
			head = "New Task"
			theme = "success"
			self.notify = false
			self.save
		end
		PrivatePub.publish_to ("/messages/" + self.user_id.to_s), :head => head, :theme => theme, :content => self.content
	end
  end

end
