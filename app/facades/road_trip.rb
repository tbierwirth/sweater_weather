class RoadTrip
  attr_reader :id, :destination, :summary, :temperature, :humidity, :precipitation_chance
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @id = forecast[:time]
    @summary = forecast[:summary]
    @temperature = forecast[:temperature]
    @humidity = forecast[:humidity]
    @precipitation_chance = forecast[:precipProbability]
  end

  def forecast
    duration = GoogleService.new.get_duration(@origin, @destination)
    time = (duration + Time.now.to_i)
    coords = GoogleService.new.coordinates(@destination)[:results][0][:geometry][:location]
    DarkSkyService.new.forecast_at(time, coords[:lat], coords[:lng])[:currently]
  end
end
