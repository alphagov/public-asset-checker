RSpec.describe "/public_asset_statuses", type: :request do
  let(:headers) do
    {
      Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(ENV["USERNAME"], ENV["PASSWORD"]),
    }
  end

  let(:public_asset) do
    PublicAsset.create!({
      url: "https://www.bedrock.com/",
      validate_by: "size",
    })
  end

  let(:valid_attributes) do
    {
      public_asset_id: public_asset.id,
      value: 123,
    }
  end

  let(:invalid_attributes) do
    {
      public_asset_id: public_asset.id,
      value: nil,
    }
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new PublicAssetStatus" do
        expect {
          post "/public_asset_statuses", params: { public_asset_status: valid_attributes }, headers:
        }.to change(PublicAssetStatus, :count).by(1)
      end

      it "redirects to the public_asset" do
        post("/public_asset_statuses", params: { public_asset_status: valid_attributes }, headers:)
        expect(response).to redirect_to(public_asset_url(public_asset))
      end
    end

    context "with invalid parameters" do
      it "does not create a new PublicAsset" do
        expect {
          post "/public_asset_statuses", params: { public_asset_status: invalid_attributes }, headers:
        }.not_to change(PublicAssetStatus, :count)
      end

      it "redirects to the public_asset" do
        post("/public_asset_statuses", params: { public_asset_status: invalid_attributes }, headers:)
        expect(response).to redirect_to(public_asset_url(public_asset))
      end
    end
  end
end
