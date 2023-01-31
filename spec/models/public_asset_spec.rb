RSpec.describe PublicAsset, type: :model do
  it { is_expected.to validate_presence_of :url }
  it { is_expected.to validate_presence_of :validate_by }
end
