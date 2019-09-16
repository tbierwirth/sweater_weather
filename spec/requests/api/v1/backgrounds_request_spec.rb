require 'rails_helper'

describe 'Backgrounds API' do
  before :each do
    images = File.open('./spec/fixtures/images.json')
    stub_request(:get, "https://api.cognitive.microsoft.com/images/search?imageType=photo&license=public&minHeight=768&minWidth=1024&q=denver,co,background").
      to_return(status: 200, body: images)

    geocoding = File.open('./spec/fixtures/geocoding.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_API_KEY']}").
      to_return(status: 200, body: geocoding)
  end
  it 'sends forecast given city,state' do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data].first[:attributes][:name]).to eq("Free stock photo of colorado, rocky mountain, sunset")
    expect(parsed[:data].first[:attributes][:url]).to eq("https://static.pexels.com/photos/110924/pexels-photo-110924.jpeg")
  end
end
