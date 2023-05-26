require "faraday"
require Rails.root.join("app/helpers/application_helper")

class AssetSizeChecker
  include ApplicationHelper

  attr_reader :asset

  def initialize(asset)
    @asset = asset
  end

  def compare
    response = Faraday.get(asset.url)
    current = response.body.bytesize
    expected = asset.latest_value

    notification = Notification.new(asset.id, asset.url)
    if expected == current
      nothing_to_do(notification, humanize_size(current), humanize_size(expected))
    elsif within_tolerance?(current, expected)
      PublicAssetStatus.create!(public_asset_id: asset.id, value: current)
      automatic_update(notification, humanize_size(current), humanize_size(expected))
    else
      action_required(notification, humanize_size(current), humanize_size(expected))
    end
  end

  def within_tolerance?(current, expected)
    tolerance = ENV["SIZE_TOLERANCE"].to_i
    current.between?(expected - tolerance, expected + tolerance)
  end

private

  def action_required(notification, current, expected)
    notification.title = "Action required"
    notification.color = "needs-attention"
    notification.value = "Expected size is *#{expected}* Actual size is *#{current}*. Please check this script and update the <#{ENV['PRODUCTION_URL']}/public_assets/#{notification.id}|latest value> when you're happy that the situation is resolved."

    notification
  end

  def automatic_update(notification, current, expected)
    notification.title = "Automatic update"
    notification.color = "other"
    notification.value = "Expected size was *#{expected}* Actual size is *#{current}*. The expected value has been automatically updated to the new actual size."

    notification
  end

  def nothing_to_do(notification, current, expected)
    notification.title = "Nothing to do"
    notification.color = "same"
    notification.value = "Expected size is *#{expected}* Actual size is *#{current}*."

    notification
  end
end
