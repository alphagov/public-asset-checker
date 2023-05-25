require "spec_helper"

RSpec.describe AssetSizeChecker, type: :model do
  describe "within_tolerance?" do
    let(:asset) { create(:public_asset) }
    let(:checker) { described_class.new(asset) }

    it "returns true when current and expected are the same" do
      expect(checker.within_tolerance?(100, 100)).to eq(true)
    end

    it "returns true when current is within the tolerance of the expected" do
      expect(checker.within_tolerance?(100, 200)).to eq(true)
    end

    it "returns false when current is not within the tolerance of the expected" do
      expect(checker.within_tolerance?(100, 201)).to eq(false)
    end
  end

  describe "compare" do
    let(:asset) { create(:public_asset) }
    let(:checker) { described_class.new(asset) }
    let(:asset_status) do
      create :public_asset_status,
             public_asset: asset,
             value: 10
    end

    it "when the response value is not the same and is within the tolerance we update the record" do
      stub_get(asset_status.public_asset.url, Faker::Alphanumeric.alpha(number: 100))

      expect {
        checker.compare
      }.to change(PublicAssetStatus, :count).by(1)
    end

    it "when the response value is not the same and is within the tolerance we send the correct notification" do
      stub_get(asset_status.public_asset.url, Faker::Alphanumeric.alpha(number: 100))

      notification = checker.compare

      expect(notification.title).to eq("Automatic update")
      expect(notification.color).to eq("other")
    end

    it "when the response value is the same we send the correct notification" do
      stub_get(asset_status.public_asset.url, Faker::Alphanumeric.alpha(number: 10))

      notification = checker.compare

      expect(notification.title).to eq("Nothing to do")
      expect(notification.color).to eq("same")
    end

    it "when the response value is not the same and not within the tolerance we send the correct notification" do
      stub_get(asset_status.public_asset.url, Faker::Alphanumeric.alpha(number: 111))

      notification = checker.compare

      expect(notification.title).to eq("Action required")
      expect(notification.color).to eq("needs-attention")
    end
  end
end
