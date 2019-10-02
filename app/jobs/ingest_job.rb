class IngestJob < ActiveJob::Base
  def perform(*args)
    user, channel, message, sent_at = args
    Log.create!(
      user: user,
      channel: channel,
      message: message,
      sent_at: sent_at
    )
  end
end
