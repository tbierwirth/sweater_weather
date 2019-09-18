class Api::V1::ForecastController < ApplicationController
  def index
    forecast = Rails.cache.fetch("forecast/#{location}", expires_in: 3.minutes) do
      ForecastFacade.new(location).forecast
    end
    render json: ForecastSerializer.new(forecast)
  end

  private
  def location
    params[:location]
  end
end
