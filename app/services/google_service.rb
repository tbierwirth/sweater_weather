class GoogleService
  def coordinates(location)
    get_json("/maps/api/geocode/json?address=#{location}")
  end

  def get_duration(origin, destination)
    get_json("/maps/api/directions/json?origin=#{origin}&destination=#{destination}")[:routes][0][:legs][0][:duration]
  end

  private
  def conn
    Faraday.new(url: "https://maps.googleapis.com") do |f|
      f.params['key'] = ENV['GOOGLE_API_KEY']
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
