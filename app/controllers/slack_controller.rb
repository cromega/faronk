class SlackController < ApplicationController
  def handle
    case slack_params["type"]
    when "url_verification"
      render json: slack_params["token"]

    when "event_callback"
      IngestJob.perform_later(slack_params["event"])
      render status: :accepted
    end
  end

  private

  def slack_params
    params.permit(:type, :challenge, :token, :event)
  end
end
