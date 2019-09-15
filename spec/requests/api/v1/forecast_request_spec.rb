require 'rails_helper'

describe 'Forecast API' do
  it 'sends forecast given city,state' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    binding.pry
    expect(parsed[:currently][:summary]).to eq("Overcast")
    expect(parsed[:currently][:temperature]).to eq(87.9)
  end
end
