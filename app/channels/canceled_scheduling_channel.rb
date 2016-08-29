class CanceledSchedulingChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'canceled_scheduling'
  end
end
