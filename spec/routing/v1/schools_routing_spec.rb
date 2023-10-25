require "rails_helper"

RSpec.describe V1::SchoolsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/schools").to route_to("v1/schools#index")
    end

    it "routes to #show" do
      expect(get: "/v1/schools/1").to route_to("v1/schools#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/schools").to route_to("v1/schools#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/schools/1").to route_to("v1/schools#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/schools/1").to route_to("v1/schools#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/schools/1").to route_to("v1/schools#destroy", id: "1")
    end
  end
end
