class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :destination, :summary, :temperature, :humidity, :precipitation_chance
end
