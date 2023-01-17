RSpec.describe "public_assets/edit", type: :view do
  let(:public_asset) do
    PublicAsset.create!(
      url: "https://www.bedrock.com/fred",
      validate_by: "thought",
    )
  end

  before do
    assign(:public_asset, public_asset)
  end

  it "renders the edit public_asset form" do
    render

    assert_select "form[action=?][method=?]", public_asset_path(public_asset), "post" do
      assert_select "input[name=?]", "public_asset[url]"
    end
  end
end
