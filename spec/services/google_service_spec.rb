require 'rails_helper'

RSpec.describe GoogleService do
  before :each do
    geocoding = File.open('./spec/fixtures/geocoding.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_API_KEY']}").
      to_return(status: 200, body: geocoding)
  end

  describe "instance methods" do
    context "#coordinates" do
      it "can geocode a given city,state" do
        location = "denver,co"
        service = GoogleService.new
        coordinates = service.coordinates(location)[:results].first[:geometry][:location]
        expect(coordinates[:lat]).to eq(39.7392358)
        expect(coordinates[:lng]).to eq(-104.990251)
      end
    end
  end
end
