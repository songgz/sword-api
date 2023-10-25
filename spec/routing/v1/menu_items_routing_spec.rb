require "rails_helper"

RSpec.describe V1::MenuItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/menu_items").to route_to("v1/menu_items#index")
    end

    it "routes to #show" do
      expect(get: "/v1/menu_items/1").to route_to("v1/menu_items#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/menu_items").to route_to("v1/menu_items#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/menu_items/1").to route_to("v1/menu_items#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/menu_items/1").to route_to("v1/menu_items#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/menu_items/1").to route_to("v1/menu_items#destroy", id: "1")
    end
  end
end
