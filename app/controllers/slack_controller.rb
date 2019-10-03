class SlackController < ApplicationController
  def handle
    case params["type"]
    when "url_verification"
      render json: challenge_token

    when "event_callback"
      IngestJob.perform_later(message_params)
      render status: :accepted
    end
  end

  private

  def challenge_token
    params.require(:token)
  end

  def message_params
    params.require(:event)
  end
end
