require "rails_helper"

RSpec.describe V1::LearnedUnitsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/learned_units").to route_to("v1/learned_units#index")
    end

    it "routes to #show" do
      expect(get: "/v1/learned_units/1").to route_to("v1/learned_units#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/learned_units").to route_to("v1/learned_units#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/learned_units/1").to route_to("v1/learned_units#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/learned_units/1").to route_to("v1/learned_units#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/learned_units/1").to route_to("v1/learned_units#destroy", id: "1")
    end
  end
end
