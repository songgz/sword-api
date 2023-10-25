require "rails_helper"

RSpec.describe V1::TeachersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/teachers").to route_to("v1/teachers#index")
    end

    it "routes to #show" do
      expect(get: "/v1/teachers/1").to route_to("v1/teachers#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/teachers").to route_to("v1/teachers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/teachers/1").to route_to("v1/teachers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/teachers/1").to route_to("v1/teachers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/teachers/1").to route_to("v1/teachers#destroy", id: "1")
    end
  end
end
