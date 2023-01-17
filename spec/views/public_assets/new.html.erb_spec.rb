RSpec.describe "public_assets/new", type: :view do
  before do
    assign(:public_asset, PublicAsset.new(
                            url: "https://www.bedrock.com/fred",
                            validate_by: "thought",
                          ))
  end

  it "renders new public_asset form" do
    render

    assert_select "form[action=?][method=?]", public_assets_path, "post" do
      assert_select "input[name=?]", "public_asset[url]"
    end
  end
end
