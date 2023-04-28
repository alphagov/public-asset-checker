class PublicAssetStatus < ApplicationRecord
  belongs_to :public_asset

  validates :public_asset_id, presence: true
  validates :size, presence: true, unless: :version
  validates :version, presence: true, unless: :size

  def value
    version || size
  end
end
