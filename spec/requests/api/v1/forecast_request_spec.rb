require 'rails_helper'

describe 'Forecast API' do
  before :each do
    forecast = File.open('./spec/fixtures/forecast.json')
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/39.7392358,-104.990251").
      to_return(status: 200, body: forecast)

    geocoding = File.open('./spec/fixtures/geocoding.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_API_KEY']}").
      to_return(status: 200, body: geocoding)
  end
  it 'sends forecast given city,state' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data][:attributes][:current][:summary]).to eq("Overcast")
    expect(parsed[:data][:attributes][:current][:temperature]).to eq(87.9)
    expect(parsed[:data][:attributes][:hourly][:summary]).to eq("Mostly cloudy throughout the day.")
  end
end
