RSpec.describe PublicAssetsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/public_assets").to route_to("public_assets#index")
    end

    it "routes to #new" do
      expect(get: "/public_assets/new").to route_to("public_assets#new")
    end

    it "routes to #show" do
      expect(get: "/public_assets/1").to route_to("public_assets#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/public_assets/1/edit").to route_to("public_assets#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/public_assets").to route_to("public_assets#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/public_assets/1").to route_to("public_assets#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/public_assets/1").to route_to("public_assets#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/public_assets/1").to route_to("public_assets#destroy", id: "1")
    end
  end
end
