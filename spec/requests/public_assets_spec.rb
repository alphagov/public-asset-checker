RSpec.describe "/public_assets", type: :request do
  let(:valid_attributes) do
    skip
  end

  let(:invalid_attributes) do
    { public_asset: { url: "", validate_by: "" } }
  end

  describe "GET /index" do
    it "renders a successful response" do
      PublicAsset.create! valid_attributes
      get public_assets_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      public_asset = PublicAsset.create! valid_attributes
      get public_asset_url(public_asset)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_public_asset_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      public_asset = PublicAsset.create! valid_attributes
      get edit_public_asset_url(public_asset)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new PublicAsset" do
        expect {
          post public_assets_url, params: { public_asset: valid_attributes }
        }.to change(PublicAsset, :count).by(1)
      end

      it "redirects to the created public_asset" do
        post public_assets_url, params: { public_asset: valid_attributes }
        expect(response).to redirect_to(public_asset_url(PublicAsset.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new PublicAsset" do
        expect {
          post public_assets_url, params: { public_asset: invalid_attributes }
        }.to change(PublicAsset, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post public_assets_url, params: { public_asset: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        skip("Add a hash of attributes valid for your model")
      end

      it "updates the requested public_asset" do
        public_asset = PublicAsset.create! valid_attributes
        patch public_asset_url(public_asset), params: { public_asset: new_attributes }
        public_asset.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the public_asset" do
        public_asset = PublicAsset.create! valid_attributes
        patch public_asset_url(public_asset), params: { public_asset: new_attributes }
        public_asset.reload
        expect(response).to redirect_to(public_asset_url(public_asset))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        public_asset = PublicAsset.create! valid_attributes
        patch public_asset_url(public_asset), params: { public_asset: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested public_asset" do
      public_asset = PublicAsset.create! valid_attributes
      expect {
        delete public_asset_url(public_asset)
      }.to change(PublicAsset, :count).by(-1)
    end

    it "redirects to the public_assets list" do
      public_asset = PublicAsset.create! valid_attributes
      delete public_asset_url(public_asset)
      expect(response).to redirect_to(public_assets_url)
    end
  end
end
