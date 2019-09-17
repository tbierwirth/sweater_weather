class DarkSkyService
  def forecast(lat,lng)
    get_json("/forecast/#{ENV['DARKSKY_API_KEY']}/#{lat},#{lng}")
  end

  def forecast_at(time, lat, lng)
    get_json("/forecast/#{ENV['DARKSKY_API_KEY']}/#{lat},#{lng},#{time}")
  end

  private
  def conn
    Faraday.new(url: "https://api.darksky.net") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
