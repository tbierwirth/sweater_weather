require 'rails_helper'

describe 'GIF API' do
  before :each do
    forecast = File.open('./spec/fixtures/forecast.json')
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/39.7392358,-104.990251").
      to_return(status: 200, body: forecast)

    geocoding = File.open('./spec/fixtures/geocoding.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_API_KEY']}").
      to_return(status: 200, body: geocoding)

    clear = File.open('./spec/fixtures/clear.json')
    stub_request(:get, "https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_API_KEY']}&q=Clear%20throughout%20the%20day.").
      to_return(status: 200, body: clear)

    mostly_cloudy = File.open('./spec/fixtures/mostly_cloudy.json')
    stub_request(:get, "https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_API_KEY']}&q=Mostly%20cloudy%20throughout%20the%20day.").
      to_return(status: 200, body: mostly_cloudy)

    partly_cloudy = File.open('./spec/fixtures/partly_cloudy.json')
    stub_request(:get, "https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_API_KEY']}&q=Partly%20cloudy%20throughout%20the%20day.").
      to_return(status: 200, body: partly_cloudy)
  end
  it 'sends forecast given city,state' do
    get '/api/v1/gifs?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    binding.pry
    expect(parsed[:data][:images][0][:time]).to eq("1568527200")
    expect(parsed[:data][:images][0][:summary]).to eq("Mostly cloudy throughout the day.")
    expect(parsed[:data][:images][0][:url]).to eq("https://giphy.com/gifs/dark-castle-63xBFHKNVjZlu")
    expect(parsed[:data][:images][1][:time]).to eq("1568613600")
    expect(parsed[:data][:images][1][:summary]).to eq("Partly cloudy throughout the day.")
    expect(parsed[:data][:images][1][:url]).to eq("https://giphy.com/gifs/beach-clouds-aQ7kognlRPDzi")
  end
end
