class AssetChecker
  attr_reader :notifications, :public_assets

  def initialize(public_assets)
    @notifications = []
    @public_assets = public_assets
  end

protected

  def add_notification(category, current, expected, url)
    notifications << {
      category:, current:, expected:, url:
    }
  end

  def notify
    notifier = Notifier.new
    notifications.each do |notification|
      notifier.notify("#{notification[:category]}: #{notification[:url]} old [#{notification[:expected]}] new [#{notification[:current]}]")
    end
  end
end
