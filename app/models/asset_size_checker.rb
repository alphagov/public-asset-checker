require "faraday"

class AssetSizeChecker
  attr_reader :notifications

  def initialize
    @notifications = []
  end

  def compare_sizes
    PublicAsset.where(validate_by: "size").all.find_each do |asset|
      response = Faraday.get(asset.url)
      current_size = response.body.bytesize
      expected_size = asset.latest_size

      category = "WARNING"
      if current_size == expected_size
        category = "SAME"
      elsif within_tolerance?(current_size, expected_size)
        PublicAssetStatus.create(
          public_asset_id: asset.id,
          size: current_size,
        )
        category = "UPDATE"
      end
      notifications << {
        category: category,
        current_size: current_size,
        expected_size: expected_size,
        url: asset.url,
      }
    end
    notify
  end

  def within_tolerance?(current_size, expected_size)
    tolerance = ENV["SIZE_TOLERANCE"].to_i
    current_size.between?(expected_size - tolerance, expected_size + tolerance)
  end

  def notify
    notifier = Notifier.new
    notifications.each do |notification|
      notifier.notify("#{notification[:category]}: #{notification[:url]} was [#{notification[:expected_size]}] is [#{notification[:current_size]}]")
    end
  end
end
