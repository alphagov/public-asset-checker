require "spec_helper"
require "faker"

def stub_get(url, bytesize)
  stub_request(:get, url).to_return(
    status: 200,
    body: Faker::Alphanumeric.alpha(number: bytesize),
  )
end

def stub_post(category, new_value)
  stub_request(:post, ENV["SLACK_WEBHOOK_URL"])
    .with(body: payload(asset_status, category, new_value))
    .to_return(status: 200, body: "")
end

def payload(asset_status, category, new_value)
  { payload:
    {
      channel: ENV["SLACK_CHANNEL"],
      username: ENV["SLACK_USERNAME"],
      text: "#{category}: #{asset_status.public_asset.url} old [#{asset_status.size}] new [#{new_value}]",
    }.to_json }
end

RSpec.describe AssetSizeChecker, type: :model do
  describe "initialize" do
    it "when created the checker has an empty notification array" do
      checker = described_class.new
      expect(checker.notifications).to eq([])
    end
  end

  describe "compare" do
    let(:checker) { described_class.new }
    let(:asset_status) { create(:public_asset_status) }

    it "when the response value is not the same and is within the tolerance we update the record and send a notification" do
      bytesize = 0
      stub_get(asset_status.public_asset.url, bytesize)
      stub_post("UPDATE", bytesize)

      checker.compare

      expect(checker.notifications.size).to eq(1)
    end

    it "when the response value is the same we send a notification" do
      bytesize = 10
      stub_get(asset_status.public_asset.url, bytesize)
      stub_post("SAME", bytesize)

      checker.compare

      expect(checker.notifications.size).to eq(1)
    end

    it "when the response value is not the same and not within the tolerance we send a warning notification" do
      bytesize = 111
      stub_get(asset_status.public_asset.url, bytesize)
      stub_post("WARNING", bytesize)

      checker.compare

      expect(checker.notifications.size).to eq(1)
    end
  end
end
