RSpec.describe PublicAssetStatus, type: :model do
  it { is_expected.to validate_presence_of :public_asset_id }
  it { is_expected.to validate_presence_of :size }
  it { is_expected.to validate_presence_of :version }
end
