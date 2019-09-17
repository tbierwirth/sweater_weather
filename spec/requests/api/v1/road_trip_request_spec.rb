require 'rails_helper'
describe 'Road Trip API' do
  describe "POST /road_trip" do
    before :each do
      time = Time.at(1568689140)
      Timecop.freeze(time)
      pueblo_forecast = File.open('./spec/fixtures/destination_forecast.json')
      stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/38.2544472,-104.6091409,1568695523").
        to_return(status: 200, body: pueblo_forecast)

      origin = File.open('./spec/fixtures/geocoding.json')
      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_API_KEY']}").
        to_return(status: 200, body: origin)

      destination = File.open('./spec/fixtures/destination_geocoding.json')
      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=Pueblo,CO&key=#{ENV['GOOGLE_API_KEY']}").
        to_return(status: 200, body: destination)

      directions = File.open('./spec/fixtures/directions.json')
      stub_request(:get, "https://maps.googleapis.com/maps/api/directions/json?destination=Pueblo,CO&key=#{ENV['GOOGLE_API_KEY']}&origin=Denver,CO").
        to_return(status: 200, body: directions)
    end
    it "user can receive forecast for a destination for the estimated time of arrival" do
      User.create!(email: "billgates@gmail.com", password: "microsoft")
      request = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "#{User.last.api_key}"
      }

      post '/api/v1/road_trip', params: request

      expect(response).to be_successful
      forecast = response.body

      expect(forecast[:summary]).to eq("Clear")
      expect(forecast[:temperature]).to eq("71.18")
      expect(forecast[:humidity]).to eq("0.44")
      expect(forecast[:precipitation_chance]).to eq("0.11")
    end
  end
end
