RSpec.describe PublicAsset, type: :model do
  let(:public_asset_size) { described_class.new(url: "https://www.bedrock.com", validate_by: "size") }
  let(:public_asset_version) { described_class.new(url: "https://www.bedrock.com", validate_by: "version") }

  it { is_expected.to validate_presence_of :url }
  it { is_expected.to validate_presence_of :validate_by }

  describe "#validate_by_size?" do
    it "returns true" do
      expect(public_asset_size.validate_by_size?).to be true
    end

    it "returns false" do
      expect(public_asset_version.validate_by_size?).to be false
    end
  end

  describe "#validate_by_version?" do
    it "returns true" do
      expect(public_asset_version.validate_by_version?).to be true
    end

    it "returns false" do
      expect(public_asset_size.validate_by_version?).to be false
    end
  end

  describe "#latest_size" do
    it "returns the latest size" do
      public_asset = create(:public_asset, url: "https://www.asos.com", validate_by: "version")
      create(:public_asset_status, value: 1824, public_asset:, updated_at: Time.zone.now - 1, created_at: Time.zone.now - 1)
      create(:public_asset_status, value: 999, public_asset:, updated_at: Time.zone.now, created_at: Time.zone.now)
      expect(public_asset.latest_value).to eq 999
    end
  end

  describe ".sizes" do
    it "returns 0 if there are no size records" do
      create(:public_asset, url: "https://www.asos.com", validate_by: "version")
      expect(described_class.sizes.count).to eq 0
    end

    it "returns 1 if there is a size record" do
      create(:public_asset, url: "https://www.asos.com", validate_by: "size")
      expect(described_class.sizes.count).to eq 1
    end
  end

  describe ".versions" do
    it "returns 0 if there are no versions records" do
      create(:public_asset, url: "https://www.asos.com", validate_by: "size")
      expect(described_class.versions.count).to eq 0
    end

    it "returns 1 if there is a version record" do
      create(:public_asset, url: "https://www.asos.com", validate_by: "version")
      expect(described_class.versions.count).to eq 1
    end
  end
end
