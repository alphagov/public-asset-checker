require "spec_helper"

RSpec.describe Notification, type: :model do
  let(:notification) { described_class.new(123, "https://www.bedrock.com") }

  describe "banner" do
    it "returns the banner with the correct id and url" do
      expect(notification.banner).to eq("<#{ENV['PRODUCTION_URL']}/public_assets/123|Asset check>: <https://www.bedrock.com|https://www.bedrock.com>")
    end
  end

  describe "priority_color" do
    it "returns #d4351c given needs-attention" do
      expect(notification.priority_color("needs-attention")).to eq("#d4351c")
    end

    it "returns #00703c given same" do
      expect(notification.priority_color("same")).to eq("#00703c")
    end

    it "returns #1d70b8 given other, or anything else" do
      expect(notification.priority_color("other")).to eq("#1d70b8")
      expect(notification.priority_color("qwerty")).to eq("#1d70b8")
    end
  end

  describe "message" do
    it "returns the data in the correct structure" do
      banner = "<#{ENV['PRODUCTION_URL']}/public_assets/123|Asset check>: <https://www.bedrock.com|https://www.bedrock.com>"

      expected = {
        "attachments": [
          {
            "fallback": banner,
            "pretext": banner,
            "color": "#00703c",
            "fields": [
              {
                "title": "Bedrock rocks!",
                "value": "Something about Bedrock",
                "short": false,
              },
            ],
          },
        ],
      }

      notification.color = "same"
      notification.title = "Bedrock rocks!"
      notification.value = "Something about Bedrock"

      expect(notification.message).to eq(expected)
    end
  end
end
