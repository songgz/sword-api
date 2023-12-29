require "rails_helper"

RSpec.describe V1::StatisticsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/statistics").to route_to("v1/statistics#index")
    end

    it "routes to #show" do
      expect(get: "/v1/statistics/1").to route_to("v1/statistics#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/statistics").to route_to("v1/statistics#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/statistics/1").to route_to("v1/statistics#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/statistics/1").to route_to("v1/statistics#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/statistics/1").to route_to("v1/statistics#destroy", id: "1")
    end
  end
end
