class BingService
  def get_images(location)
    get_json("/images/search?q=#{location}")
  end

  private
  def conn
    Faraday.new(url: "https://api.cognitive.microsoft.com/bing/v7.0") do |f|
      f.headers['Ocp-Apim-Subscription-Key'] = ENV['BING_API_KEY']
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
