RSpec.describe UrlValidator, type: :model do
  describe ".compliant?" do
    it "returns false when given an invalid url" do
      expect(described_class.compliant?("www.bedrock.com")).to be false
    end

    it "returns false when an InvalidURIError is thrown and caught" do
      expect(described_class.compliant?(1234)).to be false
    end

    it "returns true when given a valid url" do
      expect(described_class.compliant?("https://www.bedrock.com")).to be true
    end
  end

  describe "#validate_each" do
    it "is not a valid record when built with an invalid url" do
      expect(
        build(:public_asset, { url: "www.bedrock.com", validate_by: "size" }),
      ).not_to be_valid
    end

    it "raises a validation error when created with an invalid url" do
      expect {
        create(:public_asset, { url: "www.bedrock.com", validate_by: "size" })
      }.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Url is not a valid URL"
      )
    end

    it "is not a valid record when built with an invalid url which results in a InvalidURIError being thrown and caught" do
      expect(
        build(:public_asset, { url: 1234, validate_by: "size" }),
      ).not_to be_valid
    end

    it "is a valid record when given a valid url" do
      expect(
        build(:public_asset, { url: "https://www.bedrock.com", validate_by: "size" }),
      ).to be_valid
    end
  end
end
