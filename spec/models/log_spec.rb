require "rails_helper"

describe Log do
  describe "::pg_search_scope" do
    it "can search for parts of a url" do
      message = "https://youtube.com/faszom"
      create(:log, message: message)
      results = Log.search_by_message("youtube")
      expect(results.first&.message).to eq message
    end

    it "can search for word prefixes" do
      message = "this is an important message"
      create(:log, message: message)
      results = Log.search_by_message("importa")
      expect(results.first&.message).to eq message
    end
  end
end

