class PublicAssetStatus < ApplicationRecord
  belongs_to :public_asset

  validates :public_asset_id, presence: true
  validates :value, presence: true
end
