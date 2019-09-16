require 'rails_helper'

describe 'Sessions API' do
  describe 'POST /users' do
    it "user can login with correct credentials and sees their api_key in response" do
      User.create!(email: "billgates@gmail.com", password: "microsoft")
      user = {
        "email": "billgates@gmail.com",
        "password": "microsoft"
      }
      post '/api/v1/sessions', params: user

      expect(response).to be_successful
      expect(response.body).to include(User.last.api_key)
    end

    it "user can not login with correct credentials" do
      User.create!(email: "billgates@gmail.com", password: "microsoft")
      user = {
        "email": "billgates@gmail.com",
        "password": "microsift"
      }
      post '/api/v1/sessions', params: user

      expect(response).to_not be_successful
      expect(response.body).to_not include(User.last.api_key)
    end
  end
end
