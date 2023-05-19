require "faraday"

class AssetVersionChecker
  attr_reader :asset

  def initialize(asset)
    @asset = asset
  end

  def compare
    current = get_version(asset.url, /T="(\d+)"/)
    expected = get_version(ENV["GITHUB_URL"], /SCRIPT_VERSION = "(\d+)"/)

    notification = Notification.new(asset.id, asset.url)
    if expected == current
      nothing_to_do(notification, current, expected)
    else
      action_required(notification, current, expected)
    end
  end

  def get_version(url, regex)
    response = Faraday.get(url)
    match_data = response.body.match(regex)
    match_data ? match_data.captures.first : nil
  end

private

  def action_required(notification, current, expected)
    notification.title = "Action required"
    notification.color = "needs-attention"
    notification.value = "<#{ENV['GITHUB_URL']}|Source version> is [#{expected}] <#{notification.url}|Our version> is [#{current}]. Please fix our version then update the <#{ENV['PRODUCTION_URL']}/public_assets/#{notification.id}|latest value>."

    notification
  end

  def nothing_to_do(notification, current, expected)
    notification.title = "Nothing to do"
    notification.color = "same"
    notification.value = "<#{ENV['GITHUB_URL']}|Source version> is [#{expected}] <#{notification.url}|Our version> is [#{current}]."

    notification
  end
end
