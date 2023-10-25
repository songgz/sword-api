require "rails_helper"

RSpec.describe V1::WordsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/words").to route_to("v1/words#index")
    end

    it "routes to #show" do
      expect(get: "/v1/words/1").to route_to("v1/words#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/words").to route_to("v1/words#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/words/1").to route_to("v1/words#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/words/1").to route_to("v1/words#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/words/1").to route_to("v1/words#destroy", id: "1")
    end
  end
end
