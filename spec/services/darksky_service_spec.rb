require 'rails_helper'

RSpec.describe DarkSkyService do
  before :each do
    forecast = File.open('./spec/fixtures/forecast.json')
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/39.7392358,-104.990251").
      to_return(status: 200, body: forecast)
  end

  describe "instance methods" do
    context "#coordinates" do
      it "can geocode a given city,state" do
        lat = 39.7392358
        lng = -104.990251
        service = DarkSkyService.new
        forecast = service.forecast(lat,lng)
        expect(forecast[:currently][:summary]).to eq("Overcast")
        expect(forecast[:currently][:temperature]).to eq(87.9)
      end
    end
  end
end
