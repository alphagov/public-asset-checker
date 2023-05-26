require "spec_helper"

RSpec.describe AssetVersionChecker, type: :model do
  describe "get_version" do
    let(:asset) { create(:public_asset) }
    let(:checker) { described_class.new(asset) }

    it "finds the version number when it is present in the file" do
      stub_get(asset.url, 'T="42"')

      version = checker.get_version(asset.url, /T="(\d+)"/)

      expect(version).to eq(42)
    end

    it "does not find the version number when it is not present in the file" do
      stub_get(asset.url, 'Q="42"')

      version = checker.get_version(asset.url, /T="(\d+)"/)

      expect(version).to eq(nil)
    end
  end

  describe "compare" do
    let(:asset) do
      create :public_asset,
             validate_by: "version",
             hosted_version_regex: 'T="(\d+)"',
             source_version_regex: 'SCRIPT_VERSION = "(\d+)"'
    end
    let(:checker) { described_class.new(asset) }
    let(:asset_status) do
      create :public_asset_status,
             public_asset:,
             value: 42
    end

    it "when the versions match, we get a Nothing to do notification" do
      stub_get(asset.url, 'T="42"')
      stub_get(ENV["GITHUB_URL"], 'SCRIPT_VERSION = "42"')

      notification = checker.compare

      expect(notification.title).to eq("Nothing to do")
      expect(notification.color).to eq("same")
    end

    it "when the versions don't match, we get an Action required notification" do
      stub_get(asset.url, 'T="50"')
      stub_get(ENV["GITHUB_URL"], 'SCRIPT_VERSION = "42"')

      notification = checker.compare

      expect(notification.title).to eq("Action required")
      expect(notification.color).to eq("needs-attention")
    end
  end
end
