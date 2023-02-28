require "faraday"

class AssetVersionChecker < AssetChecker
  def initialize
    super(PublicAsset.versions)
  end

  def compare
    public_assets.all.find_each do |asset|
      current = get_version(asset.url, /"v=(\d+)"/)
      expected = get_version(ENV["GITHUB_URL"], /SCRIPT_VERSION = "(\d+)"/)

      category = "WARNING"
      category = "SAME" if expected == current
      add_notification(category, current, expected, asset.url)
    end
    notify
  end

private

  def get_version(url, regex)
    response = Faraday.get(url)
    response.body.match(regex).captures.first
  end
end
