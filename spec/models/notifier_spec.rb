require "spec_helper"

RSpec.describe Notifier, type: :model do
  let(:notifier) { described_class.new }
  let(:notification) { Notification.new(123, "https://www.bedrock.com") }

  describe "notify" do
    it "sends a notification" do
      stub_request(:post, ENV["SLACK_WEBHOOK_URL"])
      .with(
        body: { "payload" => "{\"channel\":\"#{ENV['SLACK_CHANNEL']}\",\"username\":\"#{ENV['SLACK_USERNAME']}\",\"attachments\":[{\"fallback\":\"\\u003chttps://govuk-public-asset-checker.herokuapp.com/public_assets/123|Asset check\\u003e: \\u003chttps://www.bedrock.com|https://www.bedrock.com\\u003e\",\"pretext\":\"\\u003chttps://govuk-public-asset-checker.herokuapp.com/public_assets/123|Asset check\\u003e: \\u003chttps://www.bedrock.com|https://www.bedrock.com\\u003e\",\"color\":\"#00703c\",\"fields\":[{\"title\":\"Bedrock rocks!\",\"value\":\"Something about Bedrock\",\"short\":false}]}]}" },
        headers: { "Accept" => "*/*" },
      )
      .to_return(status: 200, body: "", headers: {})

      notification.color = "same"
      notification.title = "Bedrock rocks!"
      notification.value = "Something about Bedrock"

      response = notifier.notify(notification)

      expect(response.last.code).to eq("200")
    end
  end
end
