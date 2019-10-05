require "rails_helper"

describe "GET logs" do
  before do
    create(:log)
    create(:log)
  end

  #context "when format is html" do
  #end

  context "when format is json" do
    it "returns the most recent logs" do
      get "/logs.json", params: ""
      logs = JSON.parse(response.body)
      expect(logs.count).to eq 2
    end
  end
end
