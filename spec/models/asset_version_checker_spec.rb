require "spec_helper"
require "faker"

RSpec.describe AssetVersionChecker, type: :model do
  describe "initialize" do
    it "when created the checker has an empty notification array" do
      checker = described_class.new
      expect(checker.notifications).to eq([])
    end
  end

  describe "compare" do
    let(:public_asset) { create(:public_asset, validate_by: "version") }
    let(:checker) { described_class.new }
    let(:asset_status) do
      create :public_asset_status,
             public_asset:,
             size: nil,
             version: 42
    end

    it "when the versions match, we get a SAME notification" do
      stub_get(public_asset.url, 'T="42"')
      stub_get(ENV["GITHUB_URL"], 'SCRIPT_VERSION = "42"')
      stub_post(public_asset.url, "SAME", 42, 42)

      checker.compare

      expect(checker.notifications.size).to eq(1)
    end

    it "when the versions don't match, we get a WARNING notification" do
      stub_get(public_asset.url, 'T="50"')
      stub_get(ENV["GITHUB_URL"], 'SCRIPT_VERSION = "42"')
      stub_post(public_asset.url, "WARNING", 50, 42)

      checker.compare

      expect(checker.notifications.size).to eq(1)
    end
  end
end
