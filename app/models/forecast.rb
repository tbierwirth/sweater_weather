class Forecast
  attr_reader :id, :current, :location, :hourly, :daily

  def initialize(forecast, location)
    @id = forecast[:currently][:time]
    @current = forecast[:currently]
    @location = location
    @hourly = forecast[:hourly]
    @daily = forecast[:daily]
  end
end
