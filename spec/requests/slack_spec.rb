require "rails_helper"

describe "POST /slack" do
  context "when Slack registers the webhook" do
    let(:token) { "Jhj5dZrVaK7ZwHHjRyZWjbDl" }
    let(:payload) do
      {
        "token": token,
        "challenge": "challenge_token",
        "type": "url_verification"
      }
    end

    it "responds with the challenge token" do
      post "/slack", params: payload.to_json, headers: {"Content-Type" => "application/json"}

      expect(response.body).to eq token
    end
  end

  context "when Slack sends an event" do
    let(:payload) do
      {
        "token" => "token",
        "team_id" => "team_id",
        "api_app_id" => "api_app_id",
        "event" => {
          "type" => "message",
          "channel" => "channel",
          "user" => "user",
          "text" => "text",
          "ts" => "1560619571",
          "event_ts" => "1355517523",
          "channel_type" => "channel"
        },
        "type" => "event_callback",
        "authed_teams" => ["asd"],
        "event_id" => "event_id",
        "event_time" => "345678"
      }
    end

    it "accepts the payload" do
      post "/slack", params: payload.to_json, headers: {"Content-Type" => "application/json"}
      expect(response.status).to eq 202
    end

    it "queues the ingest job with the event data" do
      post "/slack", params: payload.to_json, headers: {"Content-Type" => "application/json"}
      job_args = enqueued_jobs[0]&.send(:[], :args)&.first
      expect(job_args).to_not be_nil, "Job was not found"

      expect(job_args["user"]).to eq "user"
      expect(job_args["channel"]).to eq "channel"
      expect(job_args["text"]).to eq "text"
      expect(job_args["event_ts"]).to eq "1355517523"
    end
  end
end
