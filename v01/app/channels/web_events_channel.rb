class WebEventsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "web_events_channel"
  end

  def unsubscribed
  end

  def sbmjob(data)
    CleverUtilityJob.perform_later(data['command'])
  end
end
