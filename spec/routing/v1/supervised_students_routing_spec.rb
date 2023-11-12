require "rails_helper"

RSpec.describe V1::SupervisedStudentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/supervised_students").to route_to("v1/supervised_students#index")
    end

    it "routes to #show" do
      expect(get: "/v1/supervised_students/1").to route_to("v1/supervised_students#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/supervised_students").to route_to("v1/supervised_students#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/supervised_students/1").to route_to("v1/supervised_students#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/supervised_students/1").to route_to("v1/supervised_students#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/supervised_students/1").to route_to("v1/supervised_students#destroy", id: "1")
    end
  end
end
