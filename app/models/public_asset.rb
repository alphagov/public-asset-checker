class PublicAsset < ApplicationRecord
  has_many :public_asset_statuses, dependent: :destroy

  validates :url, :validate_by, presence: true
end
