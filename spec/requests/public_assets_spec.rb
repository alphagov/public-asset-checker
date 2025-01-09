RSpec.describe "/public_assets", type: :request do
  let(:headers) do
    {
      Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(ENV["USERNAME"], ENV["PASSWORD"]),
    }
  end

  let(:valid_attributes) do
    {
      url: "https://www.bedrock.com/",
      validate_by: "size",
      hosted_version_regex: 'T="(\d+)"',
      source_version_regex: 'SCRIPT_VERSION = "(\d+)"',
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      PublicAsset.create! valid_attributes
      get(public_assets_url, headers:)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      public_asset = PublicAsset.create! valid_attributes
      get(public_asset_url(public_asset), headers:)
      expect(response).to be_successful
    end
  end

  describe "GET /show with a 'version' validated model" do
    let(:valid_attributes) do
      {
        url: "https://www.bedrock.com/",
        validate_by: "version",
      }
    end

    it "renders a successful response" do
      public_asset = PublicAsset.create! valid_attributes
      get(public_asset_url(public_asset), headers:)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get(new_public_asset_url, headers:)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      public_asset = PublicAsset.create! valid_attributes
      get(edit_public_asset_url(public_asset), headers:)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new PublicAsset" do
        expect {
          post public_assets_url, params: { public_asset: valid_attributes }, headers:
        }.to change(PublicAsset, :count).by(1)
      end

      it "redirects to the created public_asset" do
        post(public_assets_url, params: { public_asset: valid_attributes }, headers:)
        expect(response).to redirect_to(public_asset_url(PublicAsset.last))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        { public_asset: { url: "", validate_by: "" } }
      end

      it "does not create a new PublicAsset" do
        expect {
          post public_assets_url, params: { public_asset: invalid_attributes }, headers:
        }.to change(PublicAsset, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post(public_assets_url, params: { public_asset: invalid_attributes }, headers:)
        expect(response).to have_http_status(422) # rubocop:disable RSpecRails/HttpStatus
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { url: "https://www.slate.com", validate_by: "version" }
      end

      it "updates the requested public_asset" do
        public_asset = PublicAsset.create! valid_attributes
        patch(public_asset_url(public_asset), params: { public_asset: new_attributes }, headers:)
        public_asset.reload
        expect(public_asset.url).to eq("https://www.slate.com")
        expect(public_asset.validate_by).to eq("version")
        expect(public_asset.hosted_version_regex).to eq('T="(\d+)"')
        expect(public_asset.source_version_regex).to eq('SCRIPT_VERSION = "(\d+)"')
      end

      it "redirects to the public_asset" do
        public_asset = PublicAsset.create! valid_attributes
        patch(public_asset_url(public_asset), params: { public_asset: new_attributes }, headers:)
        public_asset.reload
        expect(response).to redirect_to(public_asset_url(public_asset))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        public_asset = PublicAsset.create! valid_attributes
        patch(public_asset_url(public_asset), params: { public_asset: { url: "", validate_by: "version" } }, headers:)
        expect(response).to have_http_status(422) # rubocop:disable RSpecRails/HttpStatus
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested public_asset" do
      public_asset = PublicAsset.create! valid_attributes
      expect {
        delete public_asset_url(public_asset), headers:
      }.to change(PublicAsset, :count).by(-1)
    end

    it "redirects to the public_assets list" do
      public_asset = PublicAsset.create! valid_attributes
      delete(public_asset_url(public_asset), headers:)
      expect(response).to redirect_to(public_assets_url)
    end
  end
end
