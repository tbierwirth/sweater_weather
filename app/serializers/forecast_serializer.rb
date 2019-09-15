class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current, :location, :hourly, :daily
end
