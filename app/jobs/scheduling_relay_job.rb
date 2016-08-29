class SchedulingRelayJob < ApplicationJob
  def self.create_message(scheduling)
    ActionCable.server.broadcast "created_scheduling",
      {
        user: { id: scheduling.user.id, name: scheduling.user.name },
        scheduling:{ id: scheduling.id, day: scheduling.day, hour: scheduling.hour }
      }
  end

  def self.cancel_message(scheduling)
    ActionCable.server.broadcast "canceled_scheduling",
      {
        user: { id: scheduling.user.id, name: scheduling.user.name },
        scheduling:{ id: scheduling.id, day: scheduling.day, hour: scheduling.hour }
      }
  end
end
