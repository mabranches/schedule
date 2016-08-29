class Scheduling < ApplicationRecord
  belongs_to :user
  validates :day, presence: true
  validates :hour, presence: true, uniqueness: {scope: [:day]}
  validates :user, presence: true
  after_commit :send_created_message, :on => :create
  after_commit :send_canceled_message, :on => :destroy


  def send_created_message
    SchedulingRelayJob.create_message(self)
  end

  def send_canceled_message
    SchedulingRelayJob.cancel_message(self)
  end

end
