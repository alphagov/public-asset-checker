require "spec_helper"
require "faker"

RSpec.describe AssetVersionChecker, type: :model do
  describe "initialize" do
    it "when created the checker has an empty notification array" do
      checker = described_class.new
      expect(checker.notifications).to eq([])
    end
  end
end
