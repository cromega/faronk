require "rails_helper"

describe Log do
  describe "::pg_search_scope" do
    it "can search for parts of a url" do
      message = "https://youtube.com/faszom"
      create(:log, message: message)
      results = Log.search_by_message("youtube")
      expect(results.first&.message).to eq message
    end

    it "can search for full word matches" do
      message = "this is an important message"
      create(:log, message: message)
      results = Log.search_by_message("important")
      expect(results.first&.message).to eq message
    end

    it "can search for word prefixes" do
      message = "this is an important message"
      create(:log, message: message)
      results = Log.search_by_message("import")
      expect(results.first&.message).to eq message
    end

    xit "can search for word parts" do
      message = "this is an important message"
      create(:log, message: message)
      results = Log.search_by_message("porta")
      expect(results.first&.message).to eq message
    end
  end

  describe "::by_timestamp" do
    let!(:log1) { create(:log, sent_at: Time.current) }
    let!(:log2) { create(:log, sent_at: Time.current - 5.minutes) }

    it "returns logs reverse ordered by the message timestamp" do
      logs = Log.by_timestamp.limit(2)
      expect(logs).to eq [log1, log2]
    end
  end

  describe "JSON serialization" do
    let!(:log) { create(:log, sent_at: "Thu, Oct 24, 2019 11:00:00 PM GMT+01:00") }
    it "returns the timestamp as a unix epoch with milliseconds" do
      json = log.to_json
      expect(JSON.parse(json)["sent_at"]).to eq 1571954400000
    end
  end
end

