class BingService
  def get_images(location)
    images = get_json("/images/search?q=#{location},background&imageType=photo&license=public&minHeight=768&minWidth=1024")[:value]
    images.map do |image|
      BackgroundImage.new(image)
    end
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
