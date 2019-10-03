require "rails_helper"

describe IngestJob do
  describe "#perform" do
    let(:now) { DateTime.now.to_i }
    let(:event_data) {
      {
        "user" => "user",
        "channel" => "channel",
        "text" => "message",
        "event_ts" => now
      }
    }

    it "saves the log message" do
      expect { subject.perform(event_data) }.to change { Log.count }.by 1
    end
  end
end
