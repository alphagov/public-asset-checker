class PublicAssetStatus < ApplicationRecord
  belongs_to :public_asset

  validates :public_asset_id, :validate_by, presence: true
  validates :size, presence: true, unless: :version
  validates :version, presence: true, unless: :size
end
