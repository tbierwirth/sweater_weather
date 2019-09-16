class Api::V1::GifsController < ApplicationController
  def index
    coords = coordinates(location)
    forecast ||= Forecast.new(forecast(coords[:lat], coords[:lng]), location)
    gifs = GifSearch.new(forecast.daily).get_gifs

    render :json => gifs, each_serializer: GifSerializer
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
