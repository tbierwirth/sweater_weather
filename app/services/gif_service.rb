class GifService
  def get_gif(summary)
    get_json("?q=#{summary}")[:data]
  end

  private
  def conn
    Faraday.new(url: "https://api.giphy.com/v1/gifs/search") do |f|
      f.params['api_key'] = ENV['GIPHY_API_KEY']
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
