class GifSearch
  def initialize(forecast)
    @forecast = forecast
  end

  def get_gifs
    service = GifService.new
    @forecast[:data].map do |daily|
      gif = service.get_gif(daily[:summary])
      url = gif.shuffle[0][:url]
      Gif.new(daily[:time], daily[:summary], url)
    end
  end

  def copyright
    'copyright: "2019"'
  end
end
