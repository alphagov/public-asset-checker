RSpec.describe "public_assets/show", type: :view do
  before do
    assign(:public_asset, PublicAsset.create!(
                            url: "https://www.bedrock.com/fred",
                            validate_by: "thought",
                          ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/URL/)
  end
end
