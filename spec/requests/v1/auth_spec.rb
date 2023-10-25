require 'rails_helper'

RSpec.describe "V1::Auths", type: :request do
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end

  describe "POST /v1/auth/login" do
    let!(:user) { create(:user) }
    let(:password) { 'password123' }

    it "assigns @teams" do
      post '/v1/auth/login', params: {userid: user.userid, password: password}
      expect(response).to have_http_status(:success)
    end
  end
end
