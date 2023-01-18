require "faraday"

class AssetSizeChecker
  attr_reader :errors

  def initialize
    @errors = []
  end

  def compare_sizes
    PublicAsset.where(validate_by: "size").all.find_each do |asset|
      response = Faraday.get(asset.url)
      current_size = response.body.bytesize
      latest_size = asset.latest_size

      unless current_size == latest_size
        errors << {
          current_size:,
          expected_size: latest_size,
          url: asset.url,
        }
      end
    end
    notify
  end

  def notify
    errors.each do |error|
      Rails.logger.debug "ERROR: #{error[:url]} has changed! It should be [#{error[:expected_size]}] but is now [#{error[:current_size]}]"
    end
  end
end
