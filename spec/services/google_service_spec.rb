require 'rails_helper'

RSpec.describe GoogleService do
  before :each do
    geocoding = File.open('./spec/fixtures/geocoding.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_API_KEY']}").
      to_return(status: 200, body: geocoding)
    directions = File.open('./spec/fixtures/directions.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/directions/json?destination=Pueblo,%20CO&key=#{ENV['GOOGLE_API_KEY']}&origin=Denver,%20CO").
      to_return(status: 200, body: directions)
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

    context "#get_duration" do
      it "can return time to travel from origin to destination" do
        origin = "Denver, CO"
        destination = "Pueblo, CO"
        service = GoogleService.new
        duration = service.get_duration(origin, destination)
        expect(duration).to eq(6383)
      end
    end
  end
end
