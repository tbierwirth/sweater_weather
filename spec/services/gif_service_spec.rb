require 'rails_helper'

RSpec.describe GoogleService do
  before :each do
    mostly_cloudy = File.open('./spec/fixtures/partly_cloudy.json')
    stub_request(:get, "api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_API_KEY']}?q=Mostly cloudy throughout the day.").
      to_return(status: 200, body: mostly_cloudy)

    geocoding = File.open('./spec/fixtures/geocoding.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_API_KEY']}").
      to_return(status: 200, body: geocoding)

    forecast = File.open('./spec/fixtures/forecast.json')
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/39.7392358,-104.990251").
      to_return(status: 200, body: forecast)
  end

  describe "instance methods" do
    context "#get_gifs" do
      it "can return gifs if given a daily forecast" do
        location = "denver,co"

        response = GoogleService.new.coordinates(location)
        coords = response[:results].first[:geometry][:location]

        forecast = DarkSkyService.new.forecast(coords[:lat],coords[:lng])[:daily]

        gifs = GifService.new.get_gifs(forecast)

        expect(gifs[0][:url]).to eq("https://giphy.com/gifs/dark-castle-63xBFHKNVjZlu")
      end
    end
  end
end
