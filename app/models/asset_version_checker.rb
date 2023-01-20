require "faraday"

class AssetVersionChecker
  attr_reader :notifications

  def initialize
    @notifications = []
  end

  def compare
    PublicAsset.versions.all.find_each do |asset|
      current = get_version(asset.url, /"v=(\d+)"/)
      expected = get_version(ENV["GITHUB_URL"], /SCRIPT_VERSION = "(\d+)"/)

      category = "WARNING"
      category = "SAME" if expected == current

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

  def get_version(url, regex)
    response = Faraday.get(url)
    response.body.match(regex).captures.first
  end

  def notify
    notifier = Notifier.new
    notifications.each do |notification|
      notifier.notify("#{notification[:category]}: #{notification[:url]} old [#{notification[:expected]}] new [#{notification[:current]}]")
    end
  end
end
