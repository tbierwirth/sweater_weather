class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :origin, :destination, :duration, :summary, :temperature, :humidity, :precipitation_chance
end
