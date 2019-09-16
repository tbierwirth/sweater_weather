class BingService

  def initialize(location)
    @location = location
  end

  def get_images
    images = get_json[:value]
    images.map do |image|
      BackgroundImage.new(image)
    end
  end

  private

  def get_json
    response = conn.body
    JSON.parse(response, symbolize_names: true)
  end

  def conn
    uri = URI('https://api.cognitive.microsoft.com/bing/v7.0/images/search')
    uri.query = URI.encode_www_form({
        'q' => "#{@location},background",
        'imageType' => 'photo',
        'minWidth' => '1024',
        'minHeight' => '768'
    })
    request = Net::HTTP::Get.new(uri.request_uri)
    request['Ocp-Apim-Subscription-Key'] = "#{ENV['BING_API_KEY']}"
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end
  end
end
