class IngestJob < ActiveJob::Base
  def perform(args)
    user, channel, message, sent_at = args.values_at("user", "channel", "text", "event_ts")

    Log.create!(
      user: user,
      channel: channel,
      message: message,
      sent_at: Time.at(sent_at),
    )
  end
end
