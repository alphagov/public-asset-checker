require "slack-notifier"
require "json"

class Notifier
  def notify(notification)
    notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"] do
      defaults channel: ENV["SLACK_CHANNEL"], username: ENV["SLACK_USERNAME"]
    end

    notifier.ping notification.message
  end
end
