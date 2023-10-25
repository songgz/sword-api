require "rails_helper"

RSpec.describe V1::AuthsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/auths").to route_to("v1/auths#index")
    end

    it "routes to #show" do
      expect(get: "/v1/auths/1").to route_to("v1/auths#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/auths").to route_to("v1/auths#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/auths/1").to route_to("v1/auths#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/auths/1").to route_to("v1/auths#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/auths/1").to route_to("v1/auths#destroy", id: "1")
    end
  end
end
