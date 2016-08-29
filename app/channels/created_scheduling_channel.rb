class CreatedSchedulingChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'created_scheduling'
  end
end
