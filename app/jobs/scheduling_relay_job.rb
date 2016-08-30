class SchedulingRelayJob < ApplicationJob

  def perform(channel, scheduling)
    send_msg_aux(channel, scheduling)
  end

  private

    def send_msg_aux(channel, scheduling)
      exceptions = [:created_at, :updated_at, :lock_version, :user_id]

      ActionCable.server.broadcast channel,
        scheduling.as_json(include: [user: {except: exceptions}], except: exceptions)
    end
end
