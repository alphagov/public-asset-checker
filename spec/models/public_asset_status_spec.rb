RSpec.describe PublicAssetStatus, type: :model do
  it { is_expected.to validate_presence_of :public_asset_id }
  it { is_expected.to validate_presence_of :value }

  describe "#value" do
    let(:public_asset_status_size) { described_class.new(value: 123) }
    let(:public_asset_status_version) { described_class.new(value: 123) }

    it "returns the version" do
      expect(public_asset_status_version.value).to eq 123
    end

    it "returns the size" do
      expect(public_asset_status_size.value).to eq 123
    end
  end
end
