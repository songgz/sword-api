require "rails_helper"

RSpec.describe V1::QuizzesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/quizzes").to route_to("v1/quizzes#index")
    end

    it "routes to #show" do
      expect(get: "/v1/quizzes/1").to route_to("v1/quizzes#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/quizzes").to route_to("v1/quizzes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/quizzes/1").to route_to("v1/quizzes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/quizzes/1").to route_to("v1/quizzes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/quizzes/1").to route_to("v1/quizzes#destroy", id: "1")
    end
  end
end
