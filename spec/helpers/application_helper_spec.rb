RSpec.describe ApplicationHelper, type: :helper do
  describe "humanize_size" do
    it "returns 0 Bytes when 0" do
      expect(humanize_size(0)).to eq "0 Bytes"
    end

    it "returns only the size in Bytes when lower then a KB" do
      expect(humanize_size(1023)).to eq "1,023 Bytes"
    end

    it "returns 1 KB when bytes is 1024" do
      expect(humanize_size(1024)).to eq "1 KB (1,024 Bytes)"
    end

    it "returns 1.21 KB when bytes is 1234" do
      expect(humanize_size(1234)).to eq "1.21 KB (1,234 Bytes)"
    end

    it "returns 12.1 KB when bytes is 12345" do
      expect(humanize_size(12_345)).to eq "12.1 KB (12,345 Bytes)"
    end

    it "returns 1.18 MB when bytes is 1234567" do
      expect(humanize_size(1_234_567)).to eq "1.18 MB (1,234,567 Bytes)"
    end

    it "returns 1.15 GB when bytes is 1234567890" do
      expect(humanize_size(1_234_567_890)).to eq "1.15 GB (1,234,567,890 Bytes)"
    end

    it "returns 1.12 TB when bytes is 1234567890123" do
      expect(humanize_size(1_234_567_890_123)).to eq "1.12 TB (1,234,567,890,123 Bytes)"
    end

    it "returns 1.1 PB when bytes is 1234567890123456" do
      expect(humanize_size(1_234_567_890_123_456)).to eq "1.1 PB (1,234,567,890,123,456 Bytes)"
    end
  end
end
