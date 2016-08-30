class Scheduling < ApplicationRecord
  belongs_to :user
  validates :day, presence: true
  validates :hour, presence: true, uniqueness: {scope: [:day]}
  validates :user, presence: true
  after_commit :send_created_message, :on => :create
  after_commit :send_canceled_message, :on => :destroy


  def send_created_message
    SchedulingRelayJob.perform_now('created_scheduling', self)
  end

  def send_canceled_message
    SchedulingRelayJob.perform_now('canceled_scheduling', self)
  end

end
