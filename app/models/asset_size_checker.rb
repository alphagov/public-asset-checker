require "faraday"

class AssetSizeChecker
  attr_reader :notifications

  def initialize
    @notifications = []
  end

  def compare
    PublicAsset.where(validate_by: "size").all.find_each do |asset|
      response = Faraday.get(asset.url)
      current = response.body.bytesize
      expected = asset.latest_size

      category = "WARNING"
      if current == expected
        category = "SAME"
      elsif within_tolerance?(current, expected)
        PublicAssetStatus.create(
          public_asset_id: asset.id,
          size: current,
        )
        category = "UPDATE"
      end

      notifications << {
        category: category,
        current: current,
        expected: expected,
        url: asset.url,
      }
    end
    notify
  end

private

  def within_tolerance?(current, expected)
    tolerance = ENV["SIZE_TOLERANCE"].to_i
    current.between?(expected - tolerance, expected + tolerance)
  end

  def notify
    notifier = Notifier.new
    notifications.each do |notification|
      notifier.notify("#{notification[:category]}: #{notification[:url]} old [#{notification[:expected]}] new [#{notification[:current]}]")
    end
  end
end
