require "rails_helper"

describe IngestJob do
  describe "#perform" do
    let(:now) { DateTime.now }
    it "saves the log message" do
      expect { subject.perform("user", "channel", "message", now) }.to change { Log.count }.by 1
    end
  end
end
