require 'rails_helper'

describe 'Backgrounds API' do
  before :each do
    images = File.open('./spec/fixtures/images.json')
    stub_request(:get, "https://api.cognitive.microsoft.com/images/search?q=denver,co").
      to_return(status: 200, body: images)

    geocoding = File.open('./spec/fixtures/geocoding.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_API_KEY']}").
      to_return(status: 200, body: geocoding)
  end
  it 'sends forecast given city,state' do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data][:attributes].first[:image_name]).to eq("Denver, Colorado 2019 | The Ultimate Guide To Where To Go, Eat & Sleep in Denver | Time Out")
    expect(parsed[:data][:attributes].first[:image_url]).to eq("https://media.timeout.com/images/105124787/image.jpg")
  end
end
