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

  it "renders a list of public_assets" do
    render
    cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("URL".to_s), count: 2
  end
end
