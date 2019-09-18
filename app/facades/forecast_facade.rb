class ForecastFacade
  def initialize(location)
    @location = location
  end

  def forecast
    coords = coordinates(@location)
    Forecast.new(get_forecast(coords[:lat], coords[:lng]), @location)
  end

  private

  def coordinates(location)
    response = GoogleService.new.coordinates(location)
    response[:results].first[:geometry][:location]
  end

  def get_forecast(lat,lng)
    @_get_forecast = DarkSkyService.new.forecast(lat,lng)
  end
end
