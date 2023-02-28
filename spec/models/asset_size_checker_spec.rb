require "spec_helper"
require "faker"

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
      stub_get(asset_status.public_asset.url, Faker::Alphanumeric.alpha(number: 0))
      stub_post(asset_status.public_asset.url, "UPDATE", 0, asset_status.size)

      checker.compare

      expect(checker.notifications.size).to eq(1)
    end

    it "when the response value is the same we send a notification" do
      stub_get(asset_status.public_asset.url, Faker::Alphanumeric.alpha(number: 10))
      stub_post(asset_status.public_asset.url, "SAME", 10, asset_status.size)

      checker.compare

      expect(checker.notifications.size).to eq(1)
    end

    it "when the response value is not the same and not within the tolerance we send a warning notification" do
      stub_get(asset_status.public_asset.url, Faker::Alphanumeric.alpha(number: 111))
      stub_post(asset_status.public_asset.url, "WARNING", 111, asset_status.size)

      checker.compare

      expect(checker.notifications.size).to eq(1)
    end
  end
end
