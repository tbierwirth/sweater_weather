class Api::V1::ForecastController < ApplicationController
  def index
    coords = coordinates(location)
    forecast ||= Forecast.new(forecast(coords[:lat], coords[:lng]), location)
    render json: ForecastSerializer.new(forecast)
  end

  private
  def location
    params[:location]
  end

  def coordinates(location)
    response = GoogleService.new.coordinates(location)
    response[:results].first[:geometry][:location]
  end

  def forecast(lat,lng)
    DarkSkyService.new.forecast(lat,lng)
  end
end