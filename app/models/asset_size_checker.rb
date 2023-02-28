require "faraday"

class AssetSizeChecker < AssetChecker
  def initialize
    super(PublicAsset.sizes)
  end

  def compare
    public_assets.all.find_each do |asset|
      response = Faraday.get(asset.url)
      current = response.body.bytesize
      expected = asset.latest_size

      category = "WARNING"
      if current == expected
        category = "SAME"
      elsif within_tolerance?(current, expected)
        create_public_asset_status(asset.id, current)
        category = "UPDATE"
      end
      add_notification(category, current, expected, asset.url)
    end
    notify
  end

private

  def create_public_asset_status(public_asset_id, size)
    PublicAssetStatus.create!(public_asset_id:, size:)
  end

  def within_tolerance?(current, expected)
    tolerance = ENV["SIZE_TOLERANCE"].to_i
    current.between?(expected - tolerance, expected + tolerance)
  end
end
