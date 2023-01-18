class PublicAsset < ApplicationRecord
  has_many :public_asset_statuses, dependent: :destroy

  validates :url, :validate_by, presence: true

  def validate_by_size?
    validate_by == "size"
  end

  def validate_by_version?
    validate_by == "version"
  end
end
