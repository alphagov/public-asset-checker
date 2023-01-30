RSpec.describe "public_assets/index", type: :view do
  before do
    assign(:public_assets, [
      PublicAsset.create!(
        url: "https://www.bedrock.com/fred",
        validate_by: "thought",
      ),
      PublicAsset.create!(
        url: "https://www.bedrock.com/wilma",
        validate_by: "deed",
      ),
    ])
  end

  it "renders a list of 2 public_asset urls" do
    render
    cell_selector = "tr>td"
    assert_select cell_selector, text: Regexp.new("https://www.bedrock.com/+".to_s), count: 2
  end
end
