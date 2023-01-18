require "slack-notifier"

class Notifier
  attr_reader :webhook_url

  def initialize
    @webhook_url = ENV["SLACK_WEBHOOK_URL"]
  end

  def notify(message)
    notifier = Slack::Notifier.new webhook_url do
      defaults channel: ENV["SLACK_CHANNEL"], username: ENV["SLACK_USERNAME"]
    end

    notifier.ping message
  end
end
