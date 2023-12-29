require "rails_helper"

RSpec.describe V1::DictionariesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/dictionaries").to route_to("v1/dictionaries#index")
    end

    it "routes to #show" do
      expect(get: "/v1/dictionaries/1").to route_to("v1/dictionaries#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/dictionaries").to route_to("v1/dictionaries#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/dictionaries/1").to route_to("v1/dictionaries#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/dictionaries/1").to route_to("v1/dictionaries#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/dictionaries/1").to route_to("v1/dictionaries#destroy", id: "1")
    end
  end
end
